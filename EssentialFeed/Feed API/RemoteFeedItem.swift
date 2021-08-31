//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Erison on 28/08/2021.
//

import Foundation

 struct RemoteFeedItem: Decodable {
     let id: UUID
     let description: String?
     let location: String?
     let image: URL
}
