//
//  View.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
