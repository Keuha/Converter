//
//  Date.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation

extension Date {
    var minuteSince : Int {
        return Int(self.distance(to: Date()) / 60)
    }
}
