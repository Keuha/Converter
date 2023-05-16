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
                    self.storage.save(value: rates)
                default: return
            }
        }
    }
    private var storage: Storage
    private var networking: Networking
    
    required init(_ storage: Storage, network: Networking) {
        self.storage = storage
        self.networking = network
        guard let initalValues: ExchangeRatesDB = storage.load() else {
            ratesExchangeData = .notRequested
            return
        }
        ratesExchangeData = .loaded(ExchangeRates(initalValues))
    }
    
    private func load() {
        ratesExchangeData = .loading(ratesExchangeData.value, networking.task().sink(
            receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case let .failure(error):
                        self.ratesExchangeData = .error(error)
                }
            },
            receiveValue: { value in
                self.ratesExchangeData = .loaded(ExchangeRates(value))
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
