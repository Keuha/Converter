//
//  ServiceAPI.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation
import Combine
import SwiftUI
import ConverterUtility

protocol Networking {
    init(_ route: ExchangeRatesRoute)
    func task<T: Codable>() ->  AnyPublisher<T, Error>
}

struct ServiceAPI<T: Codable>: Networking {
    private let route: ExchangeRatesRoute
    private let urlSession = URLSession.shared
    
    init(_ route: ExchangeRatesRoute) {
        self.route = route
    }

    func task<T: Codable>() -> AnyPublisher<T, Error>  {
        return self.urlSession
            .dataTaskPublisher(for: route.url)
            .map {
                $0.data
            }
            .decode(type: T.self, decoder: ConfiguredJSONDecoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
  
}
