//
//  Models.swift
//  converter
//
//  Created by Frqnck  on 16/05/2023.
//

import Foundation

protocol Model {
    func toDB() -> DBObject
}
