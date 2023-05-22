//
//  Storage.swift
//  converter
//
//  Created by Frqnck  on 21/05/2023.
//

import Foundation
import RealmSwift

protocol Storage {
    func load<Value: Object> () -> Value?
    func save<Value: Model>(value: Value)
}
