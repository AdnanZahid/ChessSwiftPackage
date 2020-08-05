//
//  GameHandler.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 30/07/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

class GameHandler {
    
    static func move(_ move: MoveState, gameState: GameState) -> Bool {
        guard isCurrentPlayersMove(move, gameState: gameState),
            BoardHandler.move(move, boardState: gameState.boardState) else { return false }
        return true
    }
    
    private static func isCurrentPlayersMove(_ move: MoveState, gameState: GameState) -> Bool {
        return gameState.currentPlayer.color == getPiece(on: move.fromSquare, boardState: gameState.boardState)?.rawValue.color
    }
    
    private static func getPiece(on squareState: SquareState, boardState: BoardState) -> Piece? {
        return boardState.squares[safe: squareState.rankIndex.rawValue]?[safe: squareState.fileIndex.rawValue]??.piece
    }
}
