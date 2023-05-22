//
//  LastViewed.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import SwiftUI
import ConverterUtility

public struct LastViewedText: View {
    let date: Date

    public init(date: Date) {
        self.date = date
    }
    
    public var body: some View {
        Text("Last updated : \(date.formattedToString)")
            .padding()
            .accessibilityLabel("LastViewedText")
    }
}
