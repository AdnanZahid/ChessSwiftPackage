//
//  Indices.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 30/07/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

enum RankIndex: Int {
    case _1   = 0
    case _2   = 1
    case _3   = 2
    case _4   = 3
    case _5   = 4
    case _6   = 5
    case _7   = 6
    case _8   = 7
    
    static func - (lhs: RankIndex, rhs: RankIndex) -> Int {
        return lhs.rawValue - rhs.rawValue
    }
    
    static func + (index: RankIndex, number: Int) -> RankIndex? {
        guard let rank = RankIndex(rawValue: index.rawValue + number) else { return nil }
        return rank
    }
    
    static func - (index: RankIndex, number: Int) -> RankIndex? {
        return index + (-1)
    }
}

enum FileIndex: Int {
    case _A   = 0
    case _B   = 1
    case _C   = 2
    case _D   = 3
    case _E   = 4
    case _F   = 5
    case _G   = 6
    case _H   = 7
    
    static func - (lhs: FileIndex, rhs: FileIndex) -> Int {
        return lhs.rawValue - rhs.rawValue
    }
    
    static func + (index: FileIndex, number: Int) -> FileIndex? {
        guard let index = FileIndex(rawValue: index.rawValue + number) else { return nil }
        return index
    }
    
    static func - (index: FileIndex, number: Int) -> FileIndex? {
        return index + (-1)
    }
}
