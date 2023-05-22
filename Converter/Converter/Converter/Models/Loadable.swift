//
//  Loadable.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation
import Combine

enum CustomError: Error {
    case userCancelled
}

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

    @MainActor mutating func setIsLoading(_ cancelToken: Cancellable) {
        self = .loading(value, cancelToken)
    }

    @MainActor mutating func setError(_ error: Error) {
        self = .error(error)
    }

    @MainActor mutating func setValue(_ value: Value) {
        self = .loaded(value)
    }

    mutating func cancelLoading() {
        switch self {
        case let .loading(last, cancelToken):
            cancelToken.cancel()
            if let last = last {
                self = .loaded(last)
            } else {
                self = .error(CustomError.userCancelled)
            }
        default:
            break
        }
    }
}
