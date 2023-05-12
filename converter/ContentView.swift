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
    @ObservedObject var exchangeRates = ExchangeRatesService(storage: UserDefaultStorage())
    
    private var viewModel = ContentViewModel()
    
    var body: some View {
        content
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(Color("background"))
        .onAppear {
            exchangeRates.loadIfNeeded()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    @ViewBuilder private var content: some View {
        switch exchangeRates.ratesExchangeData {
            case .loading(let last, _):
                if let lastValue = last {
                    makeContent(lastValue)
                } else {
                    loadingView
                }
            case .loaded(let rates):
                 makeContent(rates)
            case .error(let error):
                errorView(error)
           default:
                loadingView
        }
    }
    
    @ViewBuilder private var loadingView: some View {
        VStack {
            Spacer()
            Text("Loading ...")
                .font(.headline)
                .padding()
            Spacer()
        }
    }
    
    private func errorView(_ error: Error) -> some View {
        VStack {
            Spacer()
            Text(error.localizedDescription)
                .font(.headline)
                .padding()
            Spacer()
            Button(action: exchangeRates.loadIfNeeded) {
                Text("retry ?")
            }
            Spacer()
        }
    }
    
    private func makeContent(_ rates: ExchangeRates) -> some View {
        let keys = viewModel.getKeys(rates)
        return VStack {
            selectionPart(keys)
            lastUpdated(rates.timestamp)
                .padding()
            List(keys, id: \.self) { key in
                LabeledContent(key) {
                    Text(viewModel.convert(rates.rates[key] ?? 0,
                                            amount: amountToConvert,
                                            toDollars: rates.rates[currencyName] ?? 0))
                }
            }.refreshable {
                exchangeRates.loadIfNeeded()
            }
        }
    }
    
    private func selectionPart(_ keys : [String]) -> some View {
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
                ForEach(keys, id: \.self) {
                    Text($0)
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1.0)))
            .padding()
        }.padding()
    }
    
    private func lastUpdated(_ date: Date) -> some View {
        Text("Last updated : \(viewModel.dateFormat(date))").padding()
    }
}

struct ContentViewModel {
    private var dateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
    
    func getKeys(_ rates: ExchangeRates) -> [String] {
        return rates.rates.map { $0.key }.sorted(by: <)
    }
    
    func dateFormat(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func convert(_ to: Double, amount: Double, toDollars: Double) -> String {
        guard toDollars > 0.0 else {
            return "-"
        }
        let fromNewToDollars = amount / toDollars
        let fromDollarsToNew = fromNewToDollars * to
        return String(format: "%.2f", fromDollarsToNew)
    }
}
