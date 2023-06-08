//
//  FeedCacheTestHelper.swift
//  EssentialFeedTests
//
//  Created by Jose Luis Enriquez on 08/06/2023.
//

import Foundation
import EssentialFeed

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedItemImage]) {
    let models = [uniqueImage(), uniqueImage()]
    let local = models.map { LocalFeedItemImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    return (models, local)
}

func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(),
                    description: "any",
                    location: "any",
                    url: anyURL())
}

extension Date {
    func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
}
