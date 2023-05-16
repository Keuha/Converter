//
//  Decoder.swift
//  converter
//
//  Created by Frqnck  on 16/05/2023.
//

import Foundation

let ConfiguredJSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return decoder
}()

let ConfiguredJSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .secondsSince1970
    return encoder
}()
