//
//  ContentViewModelTests.swift
//  converterTests
//
//  Created by Frqnck  on 20/05/2023.
//

import XCTest
import SwiftUI
@testable import Converter

final class ContentViewModelTests: XCTestCase {
    
    func testGetKeysOrdered() throws {
        let fakeData = DataConverter.translateExchangeModelType(data: ExchangeFakes.data!)
        let viewModel = ContentViewModel()
        
        let sortedKey = viewModel.getKeys(fakeData)
        XCTAssertEqual(sortedKey.first!, "AED")
        XCTAssertEqual(sortedKey.last!, "ZWL")
    }
    
    func testConvertionAnyCurrency() throws {
        let to = 2.0
        let amount = 10.0
        let toReference = 0.5
        
        let viewModel = ContentViewModel()
        let converted = viewModel.convert(to, amount: amount, toReference: toReference)
        let result = (amount / toReference) * to
        XCTAssertEqual(String(format: "%.2f", result), converted)
    }
    
    func testConvertionAnyCurrencyHigherTo() throws {
        let to = 12.0
        let amount = 10.0
        let toReference = 0.5
        
        let viewModel = ContentViewModel()
        let converted = viewModel.convert(to, amount: amount, toReference: toReference)
        let result = (amount / toReference) * to
        XCTAssertEqual(String(format: "%.2f", result), converted)
    }
    
    func testConvertionAnyCurrencyAllEqual() throws {
        let to = 1.0
        let amount = 1.0
        let toReference = 1.0
        
        let viewModel = ContentViewModel()
        let converted = viewModel.convert(to, amount: amount, toReference: toReference)
        //Should equal 1
        XCTAssertEqual(String(format: "%.2f", 1.0), converted)
    }
    
    func testConvertionNoDividedZero() throws {
        let to = 2.0
        let amount = 10.0
        let toReference = 0.0
        
        let viewModel = ContentViewModel()
        let converted = viewModel.convert(to, amount: amount, toReference: toReference)
        let result = "-"
        XCTAssertEqual(result, converted)
    }
}
