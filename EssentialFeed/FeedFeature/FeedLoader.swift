//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Erison on 11/08/2021.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    
    func load(Completion: @escaping (LoadFeedResult<Error>) -> Void)
}
