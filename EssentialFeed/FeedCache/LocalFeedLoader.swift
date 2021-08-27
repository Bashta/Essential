//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Erison on 28/08/2021.
//

public final class LocalFeedLoader {
    private let store: FeedStore
    private let curentDate: () -> Date
    
    public typealias SaveResult = Error?
    
    public init(store: FeedStore, curentDate: @escaping () -> Date) {
        self.store = store
        self.curentDate = curentDate
    }
    
    public func save(_ items: [FeedItem], completion: @escaping (SaveResult) -> Void) {
        store.deleCachedFeed() { [weak self] error in
            guard let self = self else { return }

            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(items, with: completion)
            }
        }
    }
    
    private func cache(_ items: [FeedItem], with completion: @escaping (SaveResult) -> Void) {
        store.insert(items.toLoacal(), timestamp: curentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

private extension Array where Element == FeedItem {
    func toLoacal() -> [LocalFeedItem] {
        return map { LocalFeedItem(id: $0.id,
                                   description: $0.description,
                                   location: $0.location,
                                   imageURL: $0.imageURL) }
    }
}
