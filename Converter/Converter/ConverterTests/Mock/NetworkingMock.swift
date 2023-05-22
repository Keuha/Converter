//
//  NetworkingMock.swift
//  converterTests
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation
import Combine
import ConverterUtility
@testable import Converter

class NetWorkingMock : Networking {
    private var route: Converter.ExchangeRatesRoute
    var valueToReturn: Data = ExchangeFakes.data!
    var error = false
   
    required init(_ route: Converter.ExchangeRatesRoute = .latest) {
        self.route = route
    }
    
    func task<T: Codable>() -> AnyPublisher<T, Error> {
        if error {
            return Result<T, Error>.failure(URLError(.timedOut)).publisher.eraseToAnyPublisher()
        }
        let toReturn: T = try! ConfiguredJSONDecoder.decode(T.self, from: valueToReturn)
        return Result<T, Error>.success(toReturn).publisher.eraseToAnyPublisher()
    }
}
