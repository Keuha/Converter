//
//  ExchangeRatesService.swift
//  converterTests
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation
import XCTest
import SwiftUI
@testable import converter

final class ExchangeRatesService: XCTestCase {
    
    func testShouldLoadFromStorage() throws {
        let stub = StorageStub()
        let _ = converter.ExchangeRatesService(stub, network: NetWorkingStub(.latest))
        
        XCTAssertTrue(stub.loadHasBeenCalled)
    }
    
    func testShouldLoadMockFromStorage() throws {
        let stub = StorageStub()
        stub.valueToBeLoaded = DataConverter.translateExchangeDBType(data: ExchangeMock.data!)
        
        let object = converter.ExchangeRatesService(stub, network: NetWorkingStub())
        let mockData = DataConverter.translateExchangeModelType(data: ExchangeMock.data!)
        
        switch object.ratesExchangeData {
            case .loaded(let rates):
                XCTAssertEqual(rates, mockData)
            default:
                XCTAssert(false, "values should be fetch from Storage but wasn't")
        }
    }
    
    func testShouldHaveValueNotRequested() throws {
        let stub = StorageStub()
        let object = converter.ExchangeRatesService(stub, network: NetWorkingStub())
        
        switch object.ratesExchangeData {
            case .notRequested:
                XCTAssertTrue(true)
            default:
                XCTAssert(false, "values should be .notRequested, something went wrong")
        }
    }
    
    func testShouldTriggerNewValueFetch() throws {
        let storageStub = StorageStub()
        let networkStub = NetWorkingStub()
        let expectation = self.expectation(description: #function)

        networkStub.valueToReturn = ExchangeMock.smallList!
        let object = converter.ExchangeRatesService(storageStub, network:networkStub)
        // create comparaison data before sink to avoid unneeded waiting time
        let mockData = DataConverter.translateExchangeModelType(data: ExchangeMock.smallList!)
        let cancellable = object.$ratesExchangeData.sink { loadable in
            switch loadable {
                case .loaded(let values):
                    XCTAssertEqual(values, mockData)
                    expectation.fulfill()
                default:
                    break
            }
        }
        object.loadIfNeeded()
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
    
    func testShouldTriggerNewValueFetchAndFail() throws {
        let storageStub = StorageStub()
        let networkStub = NetWorkingStub()
        let expectation = self.expectation(description: #function)

        networkStub.error = true

        let object = converter.ExchangeRatesService(storageStub, network:networkStub)
        let cancellable = object.$ratesExchangeData.sink { loadable in
            switch loadable {
                case .error(_):
                    XCTAssertTrue(true)
                    expectation.fulfill()
                default:
                    break
            }
        }
        object.loadIfNeeded()
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
    
    func testShouldReturnValueFromStorageBecauseTimeIsLessThan30Min() throws {
        let expectation = self.expectation(description: #function)
        let (object, mockData) = prepareExchangeRateService(minutesOld: 29)
        // object should be inited with the 29 min old object, thus should not fetch new value
        switch object.ratesExchangeData {
            case .loaded(let values):
                XCTAssertEqual(values.timestamp.timeIntervalSince1970, mockData.timestamp.timeIntervalSince1970)
                values.rates.forEach { (key, _) in
                    XCTAssertEqual(values.rates[key], mockData.rates[key])
                }
            default:
                XCTAssertTrue(false, "data should have been loaded")
        }
        object.loadIfNeeded()
        let cancellable = object.$ratesExchangeData.sink { loadable in
            switch loadable {
                case .loaded(let values):
                    XCTAssertEqual(values.timestamp.timeIntervalSince1970, mockData.timestamp.timeIntervalSince1970)
                    values.rates.forEach { (key, _) in
                        XCTAssertEqual(values.rates[key], mockData.rates[key])
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
        
        let (object, mockData) = prepareExchangeRateService(minutesOld: 31)
        // object should be inited with the 31 min old object, thus should fetch new value
        let cancellable = object.$ratesExchangeData.sink { loadable in
            switch loadable {
                case .loaded(let values):
                    if values.timestamp != mockData.timestamp { // if value is not the stored one
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
        object.loadIfNeeded()
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
    
    private func prepareExchangeRateService(minutesOld: Int) -> (converter.ExchangeRatesService, ExchangeRates) {
        let storageStub = StorageStub()
        let networkStub = NetWorkingStub()
        
        // store a Mock from minutesOld min ago in storage
        var mockData = DataConverter.translateExchangeModelType(data: ExchangeMock.smallList!)
        let nowMinus29Min = Calendar.current.date(byAdding: .minute, value: -minutesOld, to: Date())!
        mockData.timestamp = nowMinus29Min
        storageStub.valueToBeLoaded = ExchangeRatesDB(timestamp: mockData.timestamp,
                                                      base: mockData.base,
                                                      rates: mockData.rates)
        let object = converter.ExchangeRatesService(storageStub, network:networkStub)
        return (object, mockData)
    }
}
