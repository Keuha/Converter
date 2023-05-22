//
//  AmountSelectionView.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import SwiftUI
import ConverterUtility

public struct AmountSelectionView: View {
    let keys: [String]
    @Binding var amountToConvert: Double
    @Binding var currencyName: String
    
    public init(keys: [String], amountToConvert: Binding<Double>, currencyName: Binding<String>) {
        self.keys = keys
        self._amountToConvert = amountToConvert
        self._currencyName = currencyName
    }
    
    public var body: some View {
        HStack {
            TextField("", value: $amountToConvert, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1.0)))
                .padding()
                .accessibilityIdentifier("AmountSelectionViewTextField")
                .onSubmit {
                    hideKeyboard()
                }
            Spacer()
            Picker("Please select a Currency", selection: $currencyName) {
                ForEach(keys, id: \.self) { key in
                    Text(key)
                }
            }
            .accessibilityIdentifier("AmountSelectionViewPicker")
            .pickerStyle(.menu)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1.0)))
            .padding()
        }
    }
}
