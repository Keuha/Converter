//
//  ExchangeRatesService.swift
//  converterTests
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation
import XCTest
import SwiftUI
@testable import Converter

final class ExchangeRatesService: XCTestCase {
    
    func testShouldLoadFromStorage() throws {
        let mock = StorageMock()
        let _ = Converter.ExchangeRatesService(mock, network: NetWorkingMock(.latest))
        
        XCTAssertTrue(mock.loadHasBeenCalled)
    }
    
    func testShouldLoadMockFromStorage() throws {
        let mock = StorageMock()
        mock.valueToBeLoaded = DataConverter.translateExchangeDBType(data: ExchangeFakes.data!)
        
        let object = Converter.ExchangeRatesService(mock, network: NetWorkingMock())
        let fakeData = DataConverter.translateExchangeModelType(data: ExchangeFakes.data!)
        
        switch object.ratesExchangeData {
            case .loaded(let rates):
                XCTAssertEqual(rates, fakeData)
            default:
                XCTAssert(false, "values should be fetch from Storage but wasn't")
        }
    }
    
    func testShouldHaveValueNotRequested() throws {
        let mock = StorageMock()
        let object = Converter.ExchangeRatesService(mock, network: NetWorkingMock())
        
        switch object.ratesExchangeData {
            case .notRequested:
                XCTAssertTrue(true)
            default:
                XCTAssert(false, "values should be .notRequested, something went wrong")
        }
    }
    
    func testShouldTriggerNewValueFetch() throws {
        let storageMock = StorageMock()
        let networkMock = NetWorkingMock()
        let expectation = self.expectation(description: #function)

        networkMock.valueToReturn = ExchangeFakes.smallList!
        let object = Converter.ExchangeRatesService(storageMock, network: networkMock)
        // create comparaison data before sink to avoid unneeded waiting time
        let fakeData = DataConverter.translateExchangeModelType(data: ExchangeFakes.smallList!)
        let cancellable = object.$ratesExchangeData.sink { loadable in
            switch loadable {
                case .loaded(let values):
                    XCTAssertEqual(values, fakeData)
                    expectation.fulfill()
                default:
                    break
            }
        }
        Task {
            await object.loadIfNeeded()
        }
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
    
    func testShouldTriggerNewValueFetchAndFail() throws {
        let storageMock = StorageMock()
        let networkMock = NetWorkingMock()
        let expectation = self.expectation(description: #function)

        networkMock.error = true

        let object = Converter.ExchangeRatesService(storageMock, network: networkMock)
        let cancellable = object.$ratesExchangeData.sink { loadable in
            switch loadable {
                case .error(_):
                    XCTAssertTrue(true)
                    expectation.fulfill()
                default:
                    break
            }
        }
        Task {
            await object.loadIfNeeded()
        }
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
    
    func testShouldReturnValueFromStorageBecauseTimeIsLessThan30Min() throws {
        let expectation = self.expectation(description: #function)
        let (object, fakeData) = prepareExchangeRateService(minutesOld: 29)
        // object should be inited with the 29 min old object, thus should not fetch new value
        switch object.ratesExchangeData {
            case .loaded(let values):
                XCTAssertEqual(values.timestamp.timeIntervalSince1970, fakeData.timestamp.timeIntervalSince1970)
                values.rates.forEach { (key, _) in
                    XCTAssertEqual(values.rates[key], fakeData.rates[key])
                }
            default:
                XCTAssertTrue(false, "data should have been loaded")
        }
        Task {
            await object.loadIfNeeded()
        }
        let cancellable = object.$ratesExchangeData.sink { loadable in
            switch loadable {
                case .loaded(let values):
                    XCTAssertEqual(values.timestamp.timeIntervalSince1970, fakeData.timestamp.timeIntervalSince1970)
                    values.rates.forEach { (key, _) in
                        XCTAssertEqual(values.rates[key], fakeData.rates[key])
                    }
                    expectation.fulfill()
                case .loading(_, _):
                    XCTAssertTrue(false, "data should have been loaded from storage")
                case .error(_):
                    XCTAssertTrue(false, "data should exist")
                default:
                    break
            }
        }
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
    
    func testShoulFetchBecauseTimeIsMoreThan30Min() throws {
        let expectationLoading = self.expectation(description: #function)
        let expectationLoaded = self.expectation(description: #function)
        
        let (object, fakeData) = prepareExchangeRateService(minutesOld: 31)
        // object should be inited with the 31 min old object, thus should fetch new value
        let cancellable = object.$ratesExchangeData.sink { loadable in
            switch loadable {
                case .loaded(let values):
                    if values.timestamp != fakeData.timestamp { // if value is not the stored one
                        expectationLoaded.fulfill()
                    }
                case .loading(_, _):
                    expectationLoading.fulfill()
                case .error(_):
                    XCTAssertTrue(false, "data should exist")
                default:
                    break
            }
        }
        Task {
            await object.loadIfNeeded()
        }
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
    
    private func prepareExchangeRateService(minutesOld: Int) -> (Converter.ExchangeRatesService, ExchangeRates) {
        let storageMock = StorageMock()
        let networkMock = NetWorkingMock()
        
        // store a Mock from minutesOld min ago in storage
        var fakeData = DataConverter.translateExchangeModelType(data: ExchangeFakes.smallList!)
        let nowMinus29Min = Calendar.current.date(byAdding: .minute, value: -minutesOld, to: Date())!
        fakeData.timestamp = nowMinus29Min
        storageMock.valueToBeLoaded = ExchangeRatesDB(timestamp: fakeData.timestamp,
                                                      base: fakeData.base,
                                                      rates: fakeData.rates)
        let object = Converter.ExchangeRatesService(storageMock, network: networkMock)
        return (object, fakeData)
    }
}
