//
//  MovementDirectionHandler.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 02/08/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

class MovementDirectionHandler {
}

extension MovementDirectionHandler {
    
    static func isValid(move: MoveState, movementDirection: MovementDirection, color: Color) -> Bool {
        switch movementDirection {
        case .forward:
            switch color {
            case .white:
                return isRankIncremented(for: move)
            case .black:
                return isRankDecremented(for: move)
            }
        case .any:
            return true
        }
    }
}

extension MovementDirectionHandler {
    
    private static func isRankIncremented(for move: MoveState) -> Bool {
        return move.fromSquare.rankIndex.rawValue < move.toSquare.rankIndex.rawValue
    }
    
    private static func isRankDecremented(for move: MoveState) -> Bool {
        return move.fromSquare.rankIndex.rawValue > move.toSquare.rankIndex.rawValue
    }
}
