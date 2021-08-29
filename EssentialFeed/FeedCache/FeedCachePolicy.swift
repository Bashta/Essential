//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Erison on 29/08/2021.
//

import Foundation

internal final class FeedCachePolicy {
    private init() {}
    private static let calendar = Calendar(identifier: .gregorian)
    
    static private var max_cache_age: Int {
        return 7
    }
    
    internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        guard let maxCacheAge = calendar.date(byAdding: .day, value: FeedCachePolicy.max_cache_age, to: timestamp) else {
            return false
        }
        return date < maxCacheAge
    }
}
