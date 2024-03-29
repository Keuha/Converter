//
//  Date.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation

fileprivate var dateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy HH:mm"
    return formatter
}()

public extension Date {
    var minuteSince : Double {
        return (Date().timeIntervalSince1970 - self.timeIntervalSince1970) / 60
    }
    
    var formattedToString : String {
        return dateFormatter.string(from: self)
    }
}
