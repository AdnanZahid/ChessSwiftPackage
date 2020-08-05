//
//  MutableCollectionExtension.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 01/08/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

extension MutableCollection {
    subscript(safe index: Index?) -> Element? {
        get {
            guard let index = index else { return nil }
            return indices.contains(index) ? self[index] : nil
        }
        set(newValue) {
            guard let index = index else { return }
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
