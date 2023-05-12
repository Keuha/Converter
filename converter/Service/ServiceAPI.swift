//
//  ServiceAPI.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation
import Combine
import SwiftUI

struct ServiceAPI<T: Codable> {
    let route: ExchangeRatesRoute
    @Injected(\.urlSession) var urlSession
    var dataTask: AnyPublisher<T, Error> {
        self.urlSession
            .dataTaskPublisher(for: route.url)
            .map {
                $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
