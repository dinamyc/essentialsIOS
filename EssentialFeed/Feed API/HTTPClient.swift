//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Jose Luis Enriquez on 26/04/2023.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    ///The completion handler can be invoked in any thread
    ///Clients are responsable to dispatch to appropriate threads if needed
    func get(from url: URL, completion: @escaping(HTTPClientResult)-> Void)
}
