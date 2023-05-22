//
//  Decoder.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation

public let ConfiguredJSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return decoder
}()
