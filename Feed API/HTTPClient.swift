//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Jose Luis Enriquez on 26/04/2023.
//

import Foundation

public enum HTTPClientresult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping(HTTPClientresult)-> Void)
}
