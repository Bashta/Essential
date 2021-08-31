//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Erison on 11/08/2021.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>

    func load(completion: @escaping (Result) -> Void)
}
