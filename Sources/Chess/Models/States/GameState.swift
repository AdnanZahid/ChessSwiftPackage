//
//  GameState.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 30/07/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

struct GameState {
    let boardState: BoardState
    let whitePlayer: PlayerState
    let blackPlayer: PlayerState
    var currentPlayer: PlayerState
}
