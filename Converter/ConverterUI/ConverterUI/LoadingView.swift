//
//  LoadingView.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import SwiftUI

public struct LoadingView: View {
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            Spacer()
            Text("Loading ...")
                .font(.headline)
                .padding()
            Spacer()
        }
        .accessibilityLabel("LoadingView")
    }
}
