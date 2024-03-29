//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Erison on 28/08/2021.
//


public final class LocalFeedLoader {
    private let store: FeedStore
    private let curentDate: () -> Date
    
    public init(store: FeedStore, curentDate: @escaping () -> Date) {
        self.store = store
        self.curentDate = curentDate
    }
}

extension LocalFeedLoader {
    public typealias LoadResult = LoadFeedResult

    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed() { [weak self] error in
            guard let self = self else { return }

            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(feed, with: completion)
            }
        }
    }
    
    private func cache(_ feed: [FeedImage], with completion: @escaping (SaveResult) -> Void) {
        store.insert(feed.toLoacal(), timestamp: curentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

extension LocalFeedLoader: FeedLoader {
    public typealias SaveResult = Error?

    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
                
            case let .found(feed, timestamp) where FeedCachePolicy.validate(timestamp, against: self.curentDate()):
                completion(.success(feed.toModels()))

            case .empty, .found:
                completion(.success([]))
            }
        }
    }
}

extension LocalFeedLoader {
    public func validateCache() {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure:
                self.store.deleteCachedFeed { _ in }
            
            case let .found(_, timestamp) where !FeedCachePolicy.validate(timestamp, against: self.curentDate()):
                self.store.deleteCachedFeed { _ in }

            case .empty, .found:
                break
            }
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
