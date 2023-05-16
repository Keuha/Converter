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
        Text("Last updated : \(date.formattedToString)").padding()
    }
    
}

class AmountSelectionViewModel {
    
}
