//
//  AdvancementState.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 01/08/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

struct AdvancementState {
    let fileAdvancement: Int
    let rankAdvancement: Int
}

extension AdvancementState: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.fileAdvancement == rhs.fileAdvancement && lhs.rankAdvancement == rhs.rankAdvancement
    }
    
    static func * (advancement: AdvancementState, multiplier: Int) -> AdvancementState {
        return AdvancementState(fileAdvancement: advancement.fileAdvancement * multiplier, rankAdvancement: advancement.rankAdvancement * multiplier)
    }
}
