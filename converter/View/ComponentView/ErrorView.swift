//
//  ErrorView.swift
//  converter
//
//  Created by Frqnck  on 15/05/2023.
//

import SwiftUI

struct ErrorView: View {
    let action : ()->()
    let error: Error
    
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
