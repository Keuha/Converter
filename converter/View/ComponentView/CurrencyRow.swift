//
//  CurrencyRow.swift
//  converter
//
//  Created by Frqnck  on 15/05/2023.
//

import SwiftUI

struct CurrencyRow: View {
    var key: String
    var amount: String
    
    var body: some View {
        LabeledContent(key) {
            HStack {
                Text(Currency.getFullName(fromCode: key) ?? "").font(.caption2)
                Text(amount)
            }
        }
    }
}
