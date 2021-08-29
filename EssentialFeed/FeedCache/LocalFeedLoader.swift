//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Erison on 28/08/2021.
//

public final class LocalFeedLoader {
    private let store: FeedStore
    private let curentDate: () -> Date
    
    private var max_cache_age: Int {
        return 7
    }
    
    public typealias SaveResult = Error?
    public typealias LoadResult = LoadFeedResult
    
    public init(store: FeedStore, curentDate: @escaping () -> Date) {
        self.store = store
        self.curentDate = curentDate
    }
    
    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        store.deleCachedFeed() { [weak self] error in
            guard let self = self else { return }

            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(feed, with: completion)
            }
        }
    }
    
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retreive() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
                
            case let .found(feed, timestamp) where self.validate(timestamp):
                completion(.success(feed.toModels()))
                
            case .found:
                completion(.success([]))

            case .empty:
                completion(.success([]))
            }
        }
    }
    
    public func validateCache() {
        store.retreive { [unowned self] result in
            switch result {
            case .failure:
                self.store.deleCachedFeed { _ in }
            
            case let .found(_, timestamp) where !self.validate(timestamp):
                self.store.deleCachedFeed { _ in }

            case .empty, .found:
                break
            }
        }
    }
    
    private func validate(_ timestamp: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        guard let maxCacheAge = calendar.date(byAdding: .day, value: max_cache_age, to: timestamp) else {
            return false
        }
        return curentDate() < maxCacheAge
    }
    
    private func cache(_ feed: [FeedImage], with completion: @escaping (SaveResult) -> Void) {
        store.insert(feed.toLoacal(), timestamp: curentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

private extension Array where Element == FeedImage {
    func toLoacal() -> [LocalFeedImage] {
        return map { LocalFeedImage(id: $0.id,
                                   description: $0.description,
                                   location: $0.location,
                                   url: $0.url) }
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        return map { FeedImage(id: $0.id,
                                   description: $0.description,
                                   location: $0.location,
                                   url: $0.url) }
    }
}
