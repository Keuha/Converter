//
//  NetworkingStub.swift
//  converterTests
//
//  Created by Frqnck  on 15/05/2023.
//

import Foundation
import Combine
@testable import converter
import ConverterUtility

class NetWorkingStub : Networking {
    private var route: converter.ExchangeRatesRoute
    var valueToReturn: Data = ExchangeMock.data!
    var error = false
   
    required init(_ route: converter.ExchangeRatesRoute = .latest) {
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
