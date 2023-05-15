//
//  Service.swift
//  converter
//
//  Created by Frqnck  on 15/05/2023.
//

import Foundation

protocol Service {
    init(_ storage: Storage)
    func loadIfNeeded()
}
