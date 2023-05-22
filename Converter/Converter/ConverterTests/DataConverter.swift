//
//  DataConverter.swift
//  converterTests
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation
import RealmSwift
import ConverterUtility
@testable import Converter

enum DataConverter {
    // because model is creating a Date object upon init.
    // we can force the date to be the one from the date for comparaison purpose
    static func translateExchangeModelType(data: Data, forceDate: Bool = false) -> ExchangeRates {
        let mockAPIData: ExchangeRatesAPI = try! ConfiguredJSONDecoder.decode(ExchangeRatesAPI.self, from: ExchangeFakes.smallList!)
        var model = ExchangeRates(mockAPIData)
        if forceDate {
            model.timestamp = mockAPIData.timestamp
        }
        return model
    }
    
    static func translateExchangeDBType(data: Data) -> ExchangeRatesDB {
        let mockAPIData: ExchangeRatesAPI = try! ConfiguredJSONDecoder.decode(ExchangeRatesAPI.self, from: ExchangeFakes.smallList!)
        return ExchangeRatesDB(mockAPIData)
    }
}
