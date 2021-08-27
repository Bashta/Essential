//
//  CacheFeedUseCase.swift
//  EssentialFeedTests
//
//  Created by Erison on 27/08/2021.
//

import XCTest

class LocalFeedLoader {
    init(store: FeedStore) { }
}

class FeedStore {
    var deleFeedCacheCallCount = 0
}

class CacheFeedUseCase: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleFeedCacheCallCount, 0)
    }
}
