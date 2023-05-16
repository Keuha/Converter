//
//  AmountSelectionView.swift
//  converter
//
//  Created by Frqnck  on 15/05/2023.
//

import SwiftUI

struct AmountSelectionView: View {
    let keys: [String]
    @Binding var amountToConvert: Double
    @Binding var currencyName: String
    
    var body: some View {
        HStack {
            TextField("", value: $amountToConvert, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1.0)))
                .padding()
                .onSubmit {
                    hideKeyboard()
                }
            Spacer()
            Picker("Please select a Currency", selection: $currencyName) {
                ForEach(keys, id: \.self) { key in
                    Text(key)
                }
            }
            .pickerStyle(.menu)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1.0)))
            .padding()
        }
    }
}
