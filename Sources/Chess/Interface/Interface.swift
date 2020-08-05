//
//  Interface.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 30/07/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

protocol InputHandlerDelegate: class {
    func didTakeInput(_ move: MoveState)
    func getMoves(forPieceOn squareState: SquareState) -> [MoveState]
}

protocol InputHandler {
    var inputHandlerDelegate: InputHandlerDelegate? { get set }
    func input()
}

extension InputHandler {
    func input() {}
}

protocol OutputHandler: InputHandler {
    var isGUIViewAvailable: Bool { get }
    func setup(boardState: BoardState)
    func output(move: MoveState, boardState: BoardState)
    func cancelMove()
}

protocol MoveHandler {
    static func move(_ move: MoveState, boardState: BoardState) -> Bool
}
