//
//  LegalMovesHandler.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 01/08/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

class LegalMovesHandler {
}

extension LegalMovesHandler: MoveHandler {
    
    static func move(_ move: MoveState, boardState: BoardState) -> Bool {
        guard !isZeroStepAdvanced(for: move) else { return false }
        return isValid(move: move, boardState: boardState)
    }
}

extension LegalMovesHandler {
    
    private static func isValid(move: MoveState, boardState: BoardState) -> Bool {
        let fromSquare = move.fromSquare
        let toSquare = move.toSquare
        let targetPiece = getPiece(on: toSquare, boardState: boardState)
        guard let movingPiece = getPiece(on: fromSquare, boardState: boardState),
            isPiece(movingPiece, allowedToCapture: targetPiece) else { return false }
        let moveOrCaptureStrategies = targetPiece == nil ? movingPiece.rawValue.movementStrategies : movingPiece.rawValue.captureStrategies
        guard MovementStrategyHandler.isValid(move: move, movementStrategies: moveOrCaptureStrategies),
            MovementTypeHandler.isValid(move: move, movementTypes: movingPiece.rawValue.movementTypes, boardState: boardState),
            MovementDirectionHandler.isValid(move: move, movementDirection: movingPiece.rawValue.movementDirection, color: movingPiece.rawValue.color) else { return false }
        return true
    }
    
    private static func isZeroStepAdvanced(for move: MoveState) -> Bool {
        return move.fromSquare == move.toSquare
    }
    
    static func getPiece(on squareState: SquareState, boardState: BoardState) -> Piece? {
        return boardState.squares[safe: squareState.rankIndex.rawValue]?[safe: squareState.fileIndex.rawValue]??.piece
    }
    
    private static func isPiece(_ movingPiece: Piece, allowedToCapture targetPiece: Piece?) -> Bool {
        guard targetPiece?.rawValue.allowedToBeCaptured ?? true else { return false }
        return targetPiece == nil || movingPiece.rawValue.color != targetPiece?.rawValue.color
    }
}
