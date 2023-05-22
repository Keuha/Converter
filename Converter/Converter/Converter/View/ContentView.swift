//
//  ContentView.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import SwiftUI
import ConverterUI

struct ContentView: View {
    @State private var amountToConvert : Double = 1.0
    @State private var currencyName = "USD"
    @ObservedObject var exchangeRates = ExchangeRatesService(DefaultStorage(),
                                                             network: ServiceAPI<ExchangeRatesAPI>(.latest))
    
    private var viewModel = ContentViewModel()
    
    var body: some View {
        content
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .padding()
        .background(Color("background"))
        .onAppear {
           reload()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    @ViewBuilder private var content: some View {
        // switch display based on data lifecycle
        // no business logic, just reacting to event
        switch exchangeRates.ratesExchangeData {
            case .loading(let last, _):
                if let lastValue = last {
                    makeContent(lastValue)
                } else {
                    LoadingView()
                }
            case .loaded(let rates):
                 makeContent(rates)
            case .error(let error):
                errorView(error)
           default:
                LoadingView()
        }
    }
    
    private func errorView(_ error: Error) -> some View {
        ErrorView(action: reload, error: error)
    }
    
    private func makeContent(_ rates: ExchangeRates) -> some View {
        let keys = viewModel.getKeys(rates)
        return VStack {
            AmountSelectionView(keys: keys, amountToConvert: $amountToConvert, currencyName: $currencyName)
            LastViewedText(date: rates.timestamp)
            List(keys, id: \.self) { key in
                CurrencyRow(key: key,
                            amount: viewModel.convert(rates.rates[key] ?? 0,
                                                    amount: amountToConvert,
                                                    toReference: rates.rates[currencyName] ?? 0))
            }.refreshable {
                reload()
            }
        }
    }
    
    private func reload() {
        Task {
            await exchangeRates.loadIfNeeded()
        }
    }
}

struct ContentViewModel {
    func getKeys(_ rates: ExchangeRates) -> [String] {
        return rates.rates.map { $0.key }.sorted(by: <)
    }
    
    func convert(_ to: Double, amount: Double, toReference: Double) -> String {
        guard toReference > 0.0 else {
            return "-"
        }
        let fromOldToReference = amount / toReference
        let fromReferenceToNew = fromOldToReference * to
        return String(format: "%.2f", fromReferenceToNew)
    }
}
