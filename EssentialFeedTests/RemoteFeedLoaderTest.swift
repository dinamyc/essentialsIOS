//
//  RemoteFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Jose Luis Enriquez on 17/04/2023.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoaderTest: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (sut:RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    //Because it is only for testing porpuses
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        
        func get(from url: URL) {
            requestedURLs.append(url)
        }
    }
}
