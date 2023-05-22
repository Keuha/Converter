//
//  ExchangeRatesRoute.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation

enum ExchangeRatesRoute {
    
    case latest
    
    var url : URL {
        switch self {
            case .latest:
                return URL(string: "https://openexchangerates.org/api/latest.json?app_id=\(API_KEY)")!
        }
    }
}
