//
//  CurrencyRow.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import SwiftUI
import ConverterUtility

public struct CurrencyRow: View {
    let key: String
    let amount: String
    
    public init(key: String, amount: String) {
        self.key = key
        self.amount = amount
    }
    
    public var body: some View {
        LabeledContent(key) {
            HStack {
                Text(Currency.getFullName(fromCode: key) ?? "").font(.caption2)
                Text(amount)
            }
        }
        .accessibilityLabel("CurrencyRow")
    }
}
