//
//  CacheFeedUseCase.swift
//  EssentialFeedTests
//
//  Created by Erison on 27/08/2021.
//

import XCTest
import EssentialFeed

class LocalFeedLoader {
    private let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
    func save(_ items: [FeedItem]) {
        store.deleCachedFeed()
    }
}

class FeedStore {
    var deleteFeedCacheCallCount = 0
    
    func deleCachedFeed() {
        deleteFeedCacheCallCount += 1
    }
}

class CacheFeedUseCase: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteFeedCacheCallCount, 0)
    }
    
    func test_save_requestCacheDeletion() {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        let items = [uniqueItem(), uniqueItem()]
        
        sut.save(items)
        
        XCTAssertEqual(store.deleteFeedCacheCallCount, 1)
    }
    
    // Mark: - Helpers
    
    private func uniqueItem() -> FeedItem {
        return FeedItem(
            id: UUID(), description: "any", location: "any", imageURL: anyURL())
    }
    
    private func anyURL() -> URL {
        return URL(string: "httpS://a-url.com")!
    }
}
