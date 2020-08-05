//
//  MoveGenerationHandler.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 02/08/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

class MoveGenerationHandler {
    
    static func getMoves(forPieceOn squareState: SquareState, boardState: BoardState) -> [MoveState] {
        guard let piece = getPiece(on: squareState, boardState: boardState) else { return [] }
        // If movement strategies and capture strategies are same, calculate only once
        // Otherwise calculate for each one of them
        guard piece.rawValue.movementStrategies == piece.rawValue.captureStrategies else {
            var moveStates: [MoveState] = []
            moveStates.append(contentsOf: getMoves(for: piece.rawValue.movementStrategies, squareState: squareState, boardState: boardState))
            moveStates.append(contentsOf: getMoves(for: piece.rawValue.captureStrategies, squareState: squareState, boardState: boardState))
            return moveStates
        }
        return getMoves(for: piece.rawValue.movementStrategies, squareState: squareState, boardState: boardState)
    }
    
    private static func getPiece(on squareState: SquareState, boardState: BoardState) -> Piece? {
        return boardState.squares[safe: squareState.rankIndex.rawValue]?[safe: squareState.fileIndex.rawValue]??.piece
    }
    
    private static func getMoves(for movementStrategies: [MovementStrategy], squareState: SquareState, boardState: BoardState) -> [MoveState] {
        return movementStrategies
            .map { $0.rawValue }
            .flatMap { $0 }
            .map { advancementState in
                return getMoves(on: squareState, for: advancementState, boardState: boardState)
        }
        .flatMap { $0 }
        .compactMap { $0 }
    }
    
    private static func getMoves(on squareState: SquareState, for advancementState: AdvancementState, boardState: BoardState) -> [MoveState] {
        var moveStates: [MoveState] = []
        var count = 1
        while let targetSquare = squareState + (advancementState * count) {
            let moveState = MoveState(fromSquare: squareState, toSquare: targetSquare)
            guard LegalMovesHandler.move(moveState, boardState: boardState) else { return moveStates }
            moveStates.append(moveState)
            count += 1
        }
        return moveStates
    }
}
