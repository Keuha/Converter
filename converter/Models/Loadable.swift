//
//  Loadable.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation
import Combine

enum Loadable<Value> {
    case notRequested
    case loading(Value?, Cancellable)
    case loaded(Value)
    case error(Error)
    
    var value: Value? {
        switch self {
            case let .loaded(value):
                return value
            case let .loading(last, _):
                return last
            default: return nil
        }
    }
}
