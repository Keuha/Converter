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
        let _ = converter.ExchangeRatesService(storage: stub)
        
        XCTAssertEqual(stub.keyUsedToLoad, .exchangeRates) // look for previously stored values
        XCTAssertNil(stub.keyUsedToSave) // nothing needs to be saved at init
    }
    
    func testShouldLoadMockFromStorage() throws {
        let stub = StorageStub()
        stub.valueToBeLoaded = ExchangeMock.data // value to be return on load
        
        let object = converter.ExchangeRatesService(storage: stub)
        let mockData: ExchangeRates = try! JSONDecoder().decode(ExchangeRates.self, from: ExchangeMock.data!)
        
        switch object.ratesExchangeData {
            case .loaded(let rates):
                XCTAssertEqual(rates, mockData)
            default:
                XCTAssert(false, "values should be fetch from Storage but wasn't")
        }
    }
    
    func testShouldHaveValueNotRequested() throws {
        let stub = StorageStub()
        let object = converter.ExchangeRatesService(storage: stub)
        
        switch object.ratesExchangeData {
            case .notRequested:
                XCTAssertTrue(true)
            default:
                XCTAssert(false, "values should be .notRequested, something went wrong")
        }
    }
    
    func testShouldTriggerNewValueFetch() throws {
        let stub = StorageStub()
        let session = CustomURLSession.create(.latest, data: ExchangeMock.data!)
        InjectedValues[\.urlSession] = session
        let object = converter.ExchangeRatesService(storage: stub)
                    
        switch object.ratesExchangeData {
            case .notRequested:
                XCTAssertTrue(true)
            default:
                XCTAssert(false, "values should be .notRequested, something went wrong")
        }
        object.loadIfNeeded()
        switch object.ratesExchangeData {
            case .notRequested:
                XCTAssert(false, "values should have change its loadable state")
            default:
                XCTAssertTrue(true)
        }
    }
}
