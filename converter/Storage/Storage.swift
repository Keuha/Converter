//
//  Storage.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation
import RealmSwift 
fileprivate let realm = try! Realm()

protocol Storage {
    func load<Value: Object> () -> Value?
    func save<Value: Model>(value: Value)
}

struct DefaultStorage: Storage {
    func save<Value: Model>(value: Value)  {
        realm.writeAsync {
            realm.add(value.toDB())
        }
    }
    
    func load<Value: Object>() -> Value? {
        return realm.objects(Value.self).first
    }
}
