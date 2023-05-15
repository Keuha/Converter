//
//  ExchangeRates.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation

struct ExchangeRates : Codable, Equatable {
    var timestamp: Date
    var base: String
    var rates: [String: Double]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timeInterval = try container.decode(TimeInterval.self, forKey: .timestamp)
        timestamp = Date(timeIntervalSince1970: timeInterval)
        base = try container.decode(String.self, forKey: .base)
        rates = try container.decode([String: Double].self, forKey: .rates)
    }
    
    static func == (lhs: ExchangeRates, rhs: ExchangeRates) -> Bool {
        lhs.rates == rhs.rates && lhs.timestamp == rhs.timestamp
    }
}
