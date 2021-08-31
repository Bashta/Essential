//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Erison on 28/08/2021.
//

import EssentialFeed

 class FeedStoreSpy: FeedStore {
    enum ReceivedMessage: Equatable {
        case deleteCachedFeed
        case insert([LocalFeedImage], Date)
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionCompletions = [DeletionCompletion]()
    private var insertionCompletions = [InsertionCompletion]()
    private var retreivalCompletions = [RetrievalCompletion]()
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedMessages.append(.deleteCachedFeed)
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deletionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deletionCompletions[index](nil)
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        insertionCompletions.append(completion)
        receivedMessages.append(.insert(feed, timestamp))
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertionCompletions[index](error)
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](nil)
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        retreivalCompletions.append(completion)
        receivedMessages.append(.retrieve)
    }
    
    func completeRetreival(with error: Error, at index: Int = 0) {
        retreivalCompletions[index](.failure(error))
    }
    
    func completeRetreivalWithEmptyCache(at index: Int = 0) {
        retreivalCompletions[index](.empty)
    }
    
    func completeRetreival(with feed: [LocalFeedImage], timestamp: Date, at index: Int = 0) {
        retreivalCompletions[index](.found(feed: feed, timestamp: timestamp))
    }
}
