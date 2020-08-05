//
//  MovementStrategyHandler.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 02/08/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

class MovementStrategyHandler {
    enum Constants {
        static let oneStep = 1
        static let twoSteps = 2
    }
}

extension MovementStrategyHandler {
    
    static func isValid(move: MoveState, movementStrategies: [MovementStrategy]) -> Bool {
        return movementStrategies.first { strategy in
            switch strategy {
            case .straight:
                return isOnlyFileOrOnlyRankAdvanced(for: move)
            case .diagonal:
                return isEqualFileAndRankBothAdvanced(for: move)
            case .lShaped:
                return isLShapedAdvanced(for: move)
            }
            } != nil
    }
}

extension MovementStrategyHandler {
    
    private static func isOnlyFileOrOnlyRankAdvanced(for move: MoveState) -> Bool {
        return isFileAdvanced(for: move) != isRankAdvanced(for: move)
    }
    
    private static func isEqualFileAndRankBothAdvanced(for move: MoveState) -> Bool {
        let advancement = getAdvancement(for: move)
        return abs(advancement.fileAdvancement) == abs(advancement.rankAdvancement)
    }
    
    private static func isLShapedAdvanced(for move: MoveState) -> Bool {
        return isMove(move, advancedFor: AdvancementState(fileAdvancement: Constants.oneStep, rankAdvancement: Constants.twoSteps))
            || isMove(move, advancedFor: AdvancementState(fileAdvancement: Constants.twoSteps, rankAdvancement: Constants.oneStep))
    }
    
    private static func isMove(_ move: MoveState, advancedFor targetAdvancement: AdvancementState) -> Bool {
        let advancement = getAdvancement(for: move)
        return abs(advancement.fileAdvancement) == targetAdvancement.fileAdvancement && abs(advancement.rankAdvancement) == targetAdvancement.rankAdvancement
    }
    
    private static func isFileAdvanced(for move: MoveState) -> Bool {
        return move.fromSquare.fileIndex != move.toSquare.fileIndex
    }
    
    private static func isRankAdvanced(for move: MoveState) -> Bool {
        return move.fromSquare.rankIndex != move.toSquare.rankIndex
    }
    
    private static func getAdvancement(for move: MoveState) -> AdvancementState {
        return AdvancementState(fileAdvancement: move.toSquare.fileIndex - move.fromSquare.fileIndex, rankAdvancement: move.toSquare.rankIndex - move.fromSquare.rankIndex)
    }
}
