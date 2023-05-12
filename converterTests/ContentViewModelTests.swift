//
//  ContentViewModelTests.swift
//  converterTests
//
//  Created by Frqnck  on 12/05/2023.
//

import XCTest
import SwiftUI
@testable import converter

final class ContentViewModelTests: XCTestCase {
    
    func testGetKeysOrdered() throws {
        let mockData: ExchangeRates = try! JSONDecoder().decode(ExchangeRates.self, from: ExchangeMock.smallList!)
        let viewModel = ContentViewModel()
        
        let sortedKey = viewModel.getKeys(mockData)
        XCTAssertEqual(sortedKey.first!, "AED")
        XCTAssertEqual(sortedKey.last!, "ZWL")
    }
    
    func testDateFormatted() throws {
        let dateToCheck = Date()
        let viewModel = ContentViewModel()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        XCTAssertEqual(viewModel.dateFormat(dateToCheck), formatter.string(from: dateToCheck))
    }
    
    func testConvertion() throws {
        let to = 2.0
        let amount = 10.0
        let toDollars = 0.5
        
        let viewModel = ContentViewModel()
        let converted = viewModel.convert(to, amount: amount, toDollars: toDollars)
        let result = (amount / toDollars) * to
        XCTAssertEqual(String(format: "%.2f", result), converted)
    }
    
    func testConvertionNoDividedZero() throws {
        let to = 2.0
        let amount = 10.0
        let toDollars = 0.0
        
        let viewModel = ContentViewModel()
        let converted = viewModel.convert(to, amount: amount, toDollars: toDollars)
        let result = "-"
        XCTAssertEqual(result, converted)
    }
}
