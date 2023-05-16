//
//  ExchangeRates.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation

struct ExchangeRatesAPI : Codable {
    var timestamp: Date
    var base: String
    var rates: [String: Double]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timeInterval = try container.decode(Double.self, forKey: .timestamp)
        timestamp = Date(timeIntervalSince1970: timeInterval)
        base = try container.decode(String.self, forKey: .base)
        rates = try container.decode([String: Double].self, forKey: .rates)
    }
}
