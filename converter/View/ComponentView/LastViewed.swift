//
//  LastViewed.swift
//  converter
//
//  Created by Frqnck  on 15/05/2023.
//

import SwiftUI

struct LastViewedText: View {
    var date: Date
    
    private let viewModel = AmountSelectionViewModel()
    
    var body: some View {
        Text("Last updated : \(viewModel.dateFormat(date))").padding()
    }
    
}

class AmountSelectionViewModel {
    private var dateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
    
    func dateFormat(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
