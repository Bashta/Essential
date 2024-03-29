//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Erison on 11/08/2021.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
