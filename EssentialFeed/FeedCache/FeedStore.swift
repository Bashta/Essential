//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Erison on 28/08/2021.
//

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetreivalCompletion = (Error?) -> Void

    func deleCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    func retreive(completion: @escaping RetreivalCompletion)
}
