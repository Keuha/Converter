//
//  Currency.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation

public enum Currency {
    public static func getFullName(fromCode code: String) -> String? {
        return Locale.current.localizedString(forCurrencyCode: code)
    }
}
