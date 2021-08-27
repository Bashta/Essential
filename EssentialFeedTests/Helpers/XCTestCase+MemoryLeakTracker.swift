//
//  XCTestCase+MemoryLeakTracker.swift
//  EssentialFeedTests
//
//  Created by Erison on 26/08/2021.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated! Potential memory leak.", file: file, line: line)
        }
    }
}
