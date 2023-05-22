//
//  exchangeRatesService.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation
import Combine

enum errr: Error {
    case test
}

class ExchangeRatesService: Service, ObservableObject {
    @Published private (set) var ratesExchangeData: Loadable<ExchangeRates> = .notRequested {
        didSet {
            switch ratesExchangeData {
                case .loaded(let rates):
                    self.storage.save(value: rates)
                default: return
            }
        }
    }
    private let storage: Storage
    private let networking: Networking
    
    required init(_ storage: Storage, network: Networking) {
        self.storage = storage
        self.networking = network
        guard let initalValues: ExchangeRatesDB = storage.load() else {
            return
        }
        self.ratesExchangeData = .loaded(ExchangeRates(initalValues))
    }
    
    private func load() async {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                self.ratesExchangeData.setIsLoading(self.networking.task().sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case let .failure(error):
                            DispatchQueue.main.async {
                                self.ratesExchangeData.setError(error)
                                continuation.resume()
                            }
                        }
                    },
                    receiveValue: { (value: ExchangeRatesAPI) in
                        DispatchQueue.main.async {
                            self.ratesExchangeData.setValue(ExchangeRates(value))
                            continuation.resume()
                        }
                    }
                ))
            }
        }
    }
    
    func loadIfNeeded() async {
        switch ratesExchangeData {
            case .loaded(let loadedValue):
            if loadedValue.timestamp.minuteSince > MIN_BEFORE_REFRESH {
                    return await self.load()
                }
            case .notRequested:
                return await self.load()
            default:
                return
        }
    }
}
