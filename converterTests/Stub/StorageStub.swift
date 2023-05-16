//
//  StorageStub.swift
//  converterTests
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation
import RealmSwift
@testable import converter

enum StorageStubError: Error {
    case something
}

class StorageStub: Storage {
    private (set) var valueToBeSaved: DBObject? = nil
    var valueToBeLoaded: DBObject? = nil
    var saveHasBeenCalled = false
    var loadHasBeenCalled = false
    
    func save<Value: Model>(value: Value) {
        saveHasBeenCalled = true
        valueToBeSaved = value.toDB()
    }
    
    func load<Value: DBObject>() -> Value? {
        loadHasBeenCalled = true
        return valueToBeLoaded as? Value
    }
}
