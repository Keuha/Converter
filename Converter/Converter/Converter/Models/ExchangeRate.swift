//
//  ExchangeRate.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation

struct ExchangeRates: Codable, Model, Equatable {
    var timestamp: Date
    var base: String
    var rates: [String: Double]
    
    public init(_ apiModel: ExchangeRatesAPI) {
        self.base = apiModel.base
        self.timestamp = apiModel.timestamp
        self.rates = apiModel.rates
    }
    
    public init(_ dbModel: ExchangeRatesDB) {
        self.base = dbModel.base
        self.timestamp = dbModel.timestamp
        self.rates = Dictionary<String, Double>()
        zip(dbModel.rates.keys, dbModel.rates.values).forEach { (key, value) in
            self.rates[key] = value
        }
    }
    
    func toDataBaseObject() -> DateBaseObject {
        return ExchangeRatesDB(timestamp: self.timestamp, base: self.base, rates: self.rates)
    }
}
