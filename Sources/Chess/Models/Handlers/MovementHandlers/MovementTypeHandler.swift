//
//  MovementTypeHandler.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 02/08/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

class MovementTypeHandler {
}

extension MovementTypeHandler {
    
    static func isValid(move: MoveState, movementTypes: [MovementType], boardState: BoardState) -> Bool {
        return movementTypes.first { movementType in
            switch movementType {
            case .slide:
                return isPathClear(for: move, boardState: boardState)
            case .step:
                return isOneStepAdvanced(for: move)
            case .slideFrom(let fileIndex, let rankIndex, let forNumberOfFiles, let forNumberOfRanks):
                guard fileIndex == move.fromSquare.fileIndex
                    || rankIndex == move.fromSquare.rankIndex else {
                        return isOneStepAdvanced(for: move)
                }
                return isMove(move, advancedFor: AdvancementState(fileAdvancement: forNumberOfFiles, rankAdvancement: forNumberOfRanks))
                    && isPathClear(for: move, boardState: boardState)
            case .hop:
                return true
            }
            } != nil
    }
}

extension MovementTypeHandler {
    
    private static func isPathClear(for move: MoveState, boardState: BoardState) -> Bool {
        let advancement = getAdvancement(for: move)
        var positionToCheck = move.fromSquare
        let secondLastSquare = move.toSquare - getSingleAdvancement(for: advancement)
        while positionToCheck != secondLastSquare {
            positionToCheck = (positionToCheck + getSingleAdvancement(for: advancement))!
            if isSquareEmpty(positionToCheck, boardState: boardState) == false { return false }
        }
        return true
    }
    
    private static func isOneStepAdvanced(for move: MoveState) -> Bool {
        return getAdvancement(for: move) == getSingleAdvancement(for: move)
    }
    
    private static func getAdvancement(for move: MoveState) -> AdvancementState {
        return AdvancementState(fileAdvancement: move.toSquare.fileIndex - move.fromSquare.fileIndex, rankAdvancement: move.toSquare.rankIndex - move.fromSquare.rankIndex)
    }
    
    private static func getSingleAdvancement(for move: MoveState) -> AdvancementState {
        return getSingleAdvancement(for: getAdvancement(for: move))
    }
    
    private static func getSingleAdvancement(for advancement: AdvancementState) -> AdvancementState {
        var fileAdvancement = advancement.fileAdvancement
        var rankAdvancement = advancement.rankAdvancement
        fileAdvancement = fileAdvancement == 0 ? fileAdvancement : (fileAdvancement/abs(fileAdvancement))
        rankAdvancement = rankAdvancement == 0 ? rankAdvancement : (rankAdvancement/abs(rankAdvancement))
        return AdvancementState(fileAdvancement: fileAdvancement, rankAdvancement: rankAdvancement)
    }
    
    private static func isMove(_ move: MoveState, advancedFor targetAdvancement: AdvancementState) -> Bool {
        let advancement = getAdvancement(for: move)
        return abs(advancement.fileAdvancement) == targetAdvancement.fileAdvancement && abs(advancement.rankAdvancement) == targetAdvancement.rankAdvancement
    }
    
    private static func isSquareEmpty(_ squareState: SquareState, boardState: BoardState) -> Bool {
        return boardState.squares[squareState.rankIndex.rawValue][squareState.fileIndex.rawValue]?.piece == nil
    }
}
