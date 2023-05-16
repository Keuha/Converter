//
//  ExchangeRates.swift
//  converter
//
//  Created by Frqnck  on 16/05/2023.
//

import Foundation
import RealmSwift

typealias DBObject = Object

class ExchangeRatesDB: Object {
    @Persisted var timestamp: Date = Date(timeIntervalSince1970: 0)
    @Persisted var base: String
    @Persisted var rates = Map<String, Double>()
    
    convenience init(timestamp: Date, base: String, rates: [String: Double]) {
        self.init()
        self.timestamp = timestamp
        self.base = base
        rates.forEach { (key, value) in
            self.rates[key] = value
        }
    }
    
    convenience init(_ exchange: ExchangeRatesAPI) {
        self.init()
        self.timestamp = exchange.timestamp
        self.base = exchange.base
        exchange.rates.forEach { (key, value) in
            self.rates[key] = value
        }
    }
}
