//
//  CodableFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Erison on 29/08/2021.
//

import XCTest
import EssentialFeed

class CodableFeedStore {
    func retreive(completion: @escaping FeedStore.RetreivalCompletion) {
        completion(.empty)
    }
}

class CodableFeedStoreTests: XCTestCase {
    
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = CodableFeedStore()
        
        let exp = expectation(description: "Wait for cache retrival")
        sut.retreive { result in
            switch result {
            case .empty:
                break
            default:
                XCTFail("Expected empty result, got result: \(result) instead")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }
}
