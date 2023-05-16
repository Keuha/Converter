//
//  Date.swift
//  converter
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation

fileprivate var dateFormatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy HH:mm"
    return formatter
}()

extension Date {
    var minuteSince : Double {
        return (Date().timeIntervalSince1970 - self.timeIntervalSince1970) / 60
    }
    
    var formattedToString : String {
        return dateFormatter.string(from: self)
    }
}
