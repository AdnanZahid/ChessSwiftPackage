//
//  Controller.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 30/07/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

class Controller {
    
    var gameState: GameState
    let outputHandler: OutputHandler
    var inputHandler: InputHandler
    
    init(view: OutputHandler) {
        let boardState = BoardState()
        let whitePlayer = PlayerState(isAI: false, color: .white, piecesList: [])
        let blackPlayer = PlayerState(isAI: false, color: .black, piecesList: [])
        gameState = GameState(boardState: boardState, whitePlayer: whitePlayer, blackPlayer: blackPlayer, currentPlayer: whitePlayer)
        inputHandler = view
        outputHandler = view
        BoardHandler.setup(boardState: boardState, configuration: Constants.ChessBoardConfiguration.standard)
        outputHandler.setup(boardState: boardState)
        selectQueueAndRun(.global(qos: .default)) { self.runEngine() }
    }
    
    func runEngine() {
        //        inputHandler = AIHandler()
        inputHandler.inputHandlerDelegate = self
        inputHandler.input()
    }
    
    func selectQueueAndRun(_ queue: DispatchQueue, action: @escaping () -> ()) {
        if !outputHandler.isGUIViewAvailable {
            action()
        } else {
            queue.async {
                action()
            }
        }
    }
}

extension Controller: InputHandlerDelegate {
    
    func didTakeInput(_ move: MoveState) {
        if GameHandler.move(move, gameState: gameState) {
            changeTurn()
            selectQueueAndRun(.main) { [unowned self] in self.outputHandler.output(move: move, boardState: self.gameState.boardState) }
        } else {
            selectQueueAndRun(.main) { [unowned self] in self.outputHandler.cancelMove() }
        }
        selectQueueAndRun(.global(qos: .default)) { self.runEngine() }
    }
    
    func getMoves(forPieceOn squareState: SquareState) -> [MoveState] {
        return MoveGenerationHandler.getMoves(forPieceOn: squareState, boardState: gameState.boardState)
    }
    
    private func changeTurn() {
        gameState.currentPlayer = gameState.currentPlayer.color == gameState.whitePlayer.color ? gameState.blackPlayer : gameState.whitePlayer
    }
}
