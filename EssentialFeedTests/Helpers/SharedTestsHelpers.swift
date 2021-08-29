//
//  SharedTestsHelpers.swift
//  EssentialFeedTests
//
//  Created by Erison on 29/08/2021.
//

import Foundation

func anyError() -> NSError {
    return NSError(domain: "any error", code: 200)
}

func anyURL() -> URL {
    return URL(string: "httpS://a-url.com")!
}
