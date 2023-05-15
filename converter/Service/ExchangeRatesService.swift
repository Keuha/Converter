//
//  exchangeRatesService.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation
import Combine

enum errr: Error {
    case test
}

class ExchangeRatesService: Service, ObservableObject {
    @Published var ratesExchangeData: Loadable<ExchangeRates> = .notRequested {
        didSet {
            switch ratesExchangeData {
                case .loaded(let rates):
                    try? storage.save(forKey: .exchangeRates, value: rates)
                default: return
            }
        }
    }
    private var storage: Storage
    private var serviceAPI = ServiceAPI<ExchangeRates>(route: .latest)
    
    required init(_ storage: Storage) {
        self.storage = storage
        guard let initalValues : ExchangeRates = try? storage.load(forKey: .exchangeRates) else {
            ratesExchangeData = .notRequested
            return
        }
        ratesExchangeData = .loaded(initalValues)
    }
    
    private func load() {
        ratesExchangeData = .loading(ratesExchangeData.value, serviceAPI.dataTask.sink(
            receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case let .failure(error):
                        self.ratesExchangeData = .error(error)
                }
            },
            receiveValue: { value in
                self.ratesExchangeData = .loaded(value)
            }
        ))
    }
    
    func loadIfNeeded() {
        switch ratesExchangeData {
            case .loaded(let values):
                if values.timestamp.minuteSince > MIN_BEFORE_REFRESH {
                    self.load()
                }
            case .notRequested:
                self.load()
            default:
                return
        }
    }
}
