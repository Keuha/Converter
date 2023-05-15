//
//  ErrorView.swift
//  converter
//
//  Created by Frqnck  on 15/05/2023.
//

import SwiftUI

struct ErrorView: View {
    var action : ()->()
    var error: Error
    
    var body : some View {
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
    }
}
