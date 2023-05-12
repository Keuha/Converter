//
//  Storage.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation

enum StorageKeys: String {
    case exchangeRates = "ExchangeRates"
}

protocol Storage {
    func load<Value: Codable>(forKey key: StorageKeys) throws -> Value?
    func save(forKey key: StorageKeys, value: Codable) throws
}

struct UserDefaultStorage: Storage {
    
    func save(forKey key: StorageKeys, value: Codable) throws {
        try UserDefaults.standard.set(JSONEncoder().encode(value), forKey: key.rawValue)
    }
    
    func load<Value: Codable>(forKey key: StorageKeys) throws -> Value? {
        guard let raw = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
            return nil
        }
        return try JSONDecoder().decode(Value.self, from: raw)
        
    }
}
