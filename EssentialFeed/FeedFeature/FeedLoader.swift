//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Erison on 11/08/2021.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
