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
        
        sut.load{_ in }
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load{_ in }
        sut.load{_ in }
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        //var capturedErrors = [RemoteFeedLoader.Error]()
        //sut.load{ capturedErrors.append($0) }
        
        expect(sut, toCompleteWithError: .connectivity, when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
        //client.complete(with: clientError)
        
        //XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        let samples = [199, 201, 300, 400, 500]
        
        
        samples.enumerated().forEach { index, code in
            
            expect(sut, toCompleteWithError: .invalidData, when: {
                client.complete(withStatusCode: code, at: index)
            })
            //var capturedErrors = [RemoteFeedLoader.Error]()
            //sut.load{ capturedErrors.append($0) }
            
            //client.complete(withStatusCode: code, at: index)
            //XCTAssertEqual(capturedErrors, [.invalidData])
            //capturedErrors = []
        } 
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWithError: .invalidData, when: {
            let invalidJSON = Data(bytes: "invalid JSON".utf8)
            client.complete(withStatusCode: 200, data:invalidJSON)
        })
        
//        var capturedErrors = [RemoteFeedLoader.Error]()
//        sut.load{ capturedErrors.append($0) }
//
//        let invalidJSON = Data(bytes: "invalid JSON".utf8)
//        client.complete(withStatusCode: 200, data:invalidJSON)
//        XCTAssertEqual(capturedErrors, [.invalidData])
    }
    
    func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
    }
    
    
     // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (sut:RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private func expect(_ sut: RemoteFeedLoader, toCompleteWithError error: RemoteFeedLoader.Error, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        var capturedErrors = [RemoteFeedLoader.Result]()
        sut.load{ capturedErrors.append($0) }
        
        action()
        
        XCTAssertEqual(capturedErrors, [.failure(error)], file: file, line: line)
    }
    
    //Because it is only for testing porpuses
    private class HTTPClientSpy: HTTPClient {
        //var requestedURLs = [URL]()
        //var error: Error?
       // var completions = [(Error) -> Void]()
        private var messages = [(url: URL, completion: (HTTPClientresult) ->Void)]()
        var requestedURLs: [URL] {
            return messages.map({ $0.url })
        }
    
        func get(from url: URL, completion: @escaping(HTTPClientresult) ->Void) {
            /*if let error = error {
                completion(error)
            }*/
            messages.append((url: url,completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index],
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil
            )!
            messages[index].completion(.success(data, response))
        }
    }
}
