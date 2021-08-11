//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Erison on 11/08/2021.
//

import XCTest

class RemoteFeedLoader { }

class HTTPClient {
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_DoesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
}
