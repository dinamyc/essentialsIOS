//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Jose Luis Enriquez on 06/06/2023.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedItemImage], timestamp: Date, completion: @escaping InsertionCompletion)
}
