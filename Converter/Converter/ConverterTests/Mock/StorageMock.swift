//
//  StorageMock.swift
//  converterTests
//
//  Created by Frqnck  on 21/05/2023.
//

import Foundation
import RealmSwift
@testable import Converter

enum StorageMockError: Error {
    case something
}

class StorageMock: Storage {
    private (set) var valueToBeSaved: DateBaseObject? = nil
    var valueToBeLoaded: DateBaseObject? = nil
    var saveHasBeenCalled = false
    var loadHasBeenCalled = false
    
    func save<Value: Model>(value: Value) {
        saveHasBeenCalled = true
        valueToBeSaved = value.toDataBaseObject()
    }
    
    func load<Value: DateBaseObject>() -> Value? {
        loadHasBeenCalled = true
        return valueToBeLoaded as? Value
    }
}
