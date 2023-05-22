//
//  Service.swift
//  converter
//
//  Created by Frqnck  on 20/05/2023.
//

import Foundation

protocol Service {
    init(_ storage: Storage, network: Networking)
    func loadIfNeeded() async
}
