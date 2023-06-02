//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Jose Luis Enriquez on 30/05/2023.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
