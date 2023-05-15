//
//  Currency.swift
//  converter
//
//  Created by Frqnck  on 15/05/2023.
//

import Foundation

enum Currency {
    static func getFullName(fromCode code: String) -> String? {
        return Locale.current.localizedString(forCurrencyCode: code)
    }
}
