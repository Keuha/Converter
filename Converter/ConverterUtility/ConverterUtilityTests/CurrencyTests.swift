//
//  CurrencyTests.swift
//  ConverterUtilityTests
//
//  Created by Frqnck  on 21/05/2023.
//

import XCTest
@testable import ConverterUtility

final class CurrencyTests: XCTestCase {

    func testCurrencyValideCode() throws {
        let code = "EUR"
        let fullname = Currency.getFullName(fromCode: code)
        XCTAssertNotNil(fullname)
    }
    
    func testCurrencyInalideCode() throws {
        let code = "EURRRR"
        let fullname = Currency.getFullName(fromCode: code)
        XCTAssertNil(fullname)
    }
}
