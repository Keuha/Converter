//
//  DataConverter.swift
//  converterTests
//
//  Created by Frqnck  on 16/05/2023.
//

import Foundation
import RealmSwift
import ConverterUtility
@testable import converter

enum DataConverter {
    static func translateExchangeModelType(data: Data) -> ExchangeRates {
        let mockAPIData: ExchangeRatesAPI = try! ConfiguredJSONDecoder.decode(ExchangeRatesAPI.self, from: ExchangeMock.smallList!)
        return ExchangeRates(mockAPIData)
    }
    
    static func translateExchangeDBType(data: Data) -> ExchangeRatesDB {
        let mockAPIData: ExchangeRatesAPI = try! ConfiguredJSONDecoder.decode(ExchangeRatesAPI.self, from: ExchangeMock.smallList!)
        return ExchangeRatesDB(mockAPIData)
    }
}
