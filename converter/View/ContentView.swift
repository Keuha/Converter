//
//  ContentView.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var amountToConvert : Double = 1.0
    @State private var currencyName = "USD"
    @ObservedObject var exchangeRates = ExchangeRatesService(UserDefaultStorage(),
                                                             network: ServiceAPI<ExchangeRates>(.latest))
    
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
            exchangeRates.loadIfNeeded()
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
        ErrorView(action: exchangeRates.loadIfNeeded, error: error)
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
                exchangeRates.loadIfNeeded()
            }
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
