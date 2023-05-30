//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jose Luis Enriquez on 17/04/2023.
//

import Foundation

public enum LoadFeedResult{
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: @escaping (LoadFeedResult)-> Void)
}
