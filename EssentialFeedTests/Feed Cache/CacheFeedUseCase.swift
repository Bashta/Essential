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
    var insertCallCount = 0
    
    func deleCachedFeed() {
        deleteFeedCacheCallCount += 1
    }
    
    func completeDeletion(with: Error, at index: Int = 0) {
        
    }
}

class CacheFeedUseCase: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.deleteFeedCacheCallCount, 0)
    }
    
    func test_save_requestCacheDeletion() {
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT()
        
        sut.save(items)
        
        XCTAssertEqual(store.deleteFeedCacheCallCount, 1)
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeletionError() {
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT()
        let deletionError = anyError()
        
        sut.save(items)
        store.completeDeletion(with: deletionError)
        
        XCTAssertEqual(store.insertCallCount, 0)
    }
    
    // Mark: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStore) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut: sut, store: store)
    }
    
    private func uniqueItem() -> FeedItem {
        return FeedItem(
            id: UUID(), description: "any", location: "any", imageURL: anyURL())
    }
    
    private func anyURL() -> URL {
        return URL(string: "httpS://a-url.com")!
    }
    
    private func anyError() -> NSError {
        return NSError(domain: "any error", code: 200)
    }
}
