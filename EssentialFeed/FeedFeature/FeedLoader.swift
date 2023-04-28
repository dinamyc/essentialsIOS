//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jose Luis Enriquez on 17/04/2023.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: @escaping (LoadFeedResult<Error>)-> Void)
}
