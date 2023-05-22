//
//  ErrorView.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import SwiftUI

public struct ErrorView: View {
    let action : ()->()
    let error: Error
    
    public init(action: @escaping () -> Void, error: Error) {
        self.action = action
        self.error = error
    }
    
    public var body : some View {
        VStack {
            Spacer()
            Text(error.localizedDescription)
                .font(.headline)
                .padding()
            Spacer()
            Button(action: action) {
                Text("retry ?")
            }
            Spacer()
        }
        .accessibilityLabel("CurrencyRow")
    }
}
