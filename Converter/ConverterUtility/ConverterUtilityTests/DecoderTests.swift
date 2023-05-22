//
//  DecoderTests.swift
//  ConverterUtilityTests
//
//  Created by Frqnck  on 21/05/2023.
//

import XCTest
import Foundation
@testable import ConverterUtility

final class DecoderTests: XCTestCase {

    func testDecodingStrat() throws {
        let decoder = ConfiguredJSONDecoder
        let strat = decoder.dateDecodingStrategy
        switch strat {
            case .secondsSince1970:
                XCTAssertTrue(true)
            default:
                XCTAssertTrue(false, "strategy is not set to the correct one")
        }
    }
}
