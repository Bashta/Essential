//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Erison on 11/08/2021.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(Completion: @escaping (LoadFeedResult) -> Void)
}
