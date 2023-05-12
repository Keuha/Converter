//
//  DateExtensionsTests.swift
//  converterTests
//
//  Created by Frqnck  on 12/05/2023.
//

import XCTest
@testable import converter

final class DateExtensionsTests: XCTestCase {
    
    func testFromEpochZero() throws {
        let minuteFromEpoch = Date().timeIntervalSince1970 / 60
        let dateZero = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(dateZero.minuteSince, Int(minuteFromEpoch))
    }
}
