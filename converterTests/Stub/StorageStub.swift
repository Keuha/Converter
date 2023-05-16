//
//  StorageStub.swift
//  converterTests
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation
@testable import converter

enum StorageStubError: Error {
    case something
}

class StorageStub: Storage {

    var keyUsedToSave: converter.StorageKeys?
    var keyUsedToLoad: converter.StorageKeys?
    
    private (set) var valueToBeSaved: Decodable? = nil
    var valueToBeLoaded: Data? = nil
    
    var loadShouldThrow = false
    var saveShouldThrow = false
    
    func load<WantedValue: Decodable>(forKey key: converter.StorageKeys) throws -> WantedValue? {
        keyUsedToLoad = key
        if loadShouldThrow {
            throw StorageStubError.something
        }
        guard let returnedValue = valueToBeLoaded else {
            return nil
        }
        let value = try ConfiguredJSONDecoder.decode(WantedValue.self, from: returnedValue)
        return value 
    }
    
    func save(forKey key: converter.StorageKeys, value: Codable) throws {
        keyUsedToSave = key
        if saveShouldThrow {
            throw  StorageStubError.something
        }
        valueToBeSaved = value
    }
}
