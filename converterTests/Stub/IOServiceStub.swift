//
//  URLProtocolMock.swift
//  converterTests
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation
import Combine
@testable import converter


// use to catch call done on URL session to avoid real API call to be perform durijng Unit testing
class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()
    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // if we have a valid URL…
        if let url = request.url {
            
            // if we have test data for that URL…
            if let data = URLProtocolMock.testURLs[url] {
                // load it immediately.
                // can't figure out why I got an issue forwarding the result
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        
        // mark that we've finished
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    // this method is required but doesn't need to do anything
    override func stopLoading() { }
}


struct CustomURLSession {
    
    static func create(_ route: ExchangeRatesRoute, data: Data) -> URLSession {
        // this is the URL we expect to call
        let url = route.url
        
        // attach that to some fixed data in our protocol handler
        URLProtocolMock.testURLs = [url: data]
        
        // now set up a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        // and create the URLSession from that
        return URLSession(configuration: config)
    }
}
