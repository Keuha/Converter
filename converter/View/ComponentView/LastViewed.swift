//
//  LastViewed.swift
//  converter
//
//  Created by Frqnck  on 15/05/2023.
//

import SwiftUI

struct LastViewedText: View {
    let date: Date

    var body: some View {
        Text("Last updated : \(date.formattedToString)").padding()
    }
    
}
