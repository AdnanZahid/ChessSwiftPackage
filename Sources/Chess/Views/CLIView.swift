//
//  CLIView.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 30/07/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

class CLIView {
    
    private enum Constants {
        
        static let asciiDifferenceForFile = 65
        static let asciiDifferenceForRank = 49
        static let newLine = "\n"
        
        enum RankString: Character {
            case _1   = "1"
            case _2   = "2"
            case _3   = "3"
            case _4   = "4"
            case _5   = "5"
            case _6   = "6"
            case _7   = "7"
            case _8   = "8"
        }
        
        enum FileString: Character {
            case _A   = "A"
            case _B   = "B"
            case _C   = "C"
            case _D   = "D"
            case _E   = "E"
            case _F   = "F"
            case _G   = "G"
            case _H   = "H"
        }
    }
    
    var isGUIViewAvailable = false
    
    weak var inputHandlerDelegate: InputHandlerDelegate?
}

extension CLIView: InputHandler {
    
    func input() {
        
        guard let string = readLine(strippingNewline: true)?.capitalized else { return }
        let input = Array(string)
        let fromFile = input[0]
        let fromRank = input[1]
        let toFile = input[2]
        let toRank = input[3]
        
        if fromFile >= Constants.FileString._A.rawValue && fromFile <= Constants.FileString._H.rawValue
            && fromRank >= Constants.RankString._1.rawValue && fromRank <= Constants.RankString._8.rawValue
            && toFile >= Constants.FileString._A.rawValue && toFile <= Constants.FileString._H.rawValue
            && toRank >= Constants.RankString._1.rawValue && toRank <= Constants.RankString._8.rawValue {
            
            guard let fromFileAsciiValue = fromFile.asciiValue, let fromRankAsciiValue = fromRank.asciiValue,
                let toFileAsciiValue = toFile.asciiValue, let toRankAsciiValue = toRank.asciiValue,
                
                let fromFileIndex = FileIndex(rawValue: Int(fromFileAsciiValue) - Constants.asciiDifferenceForFile),
                let fromRankIndex = RankIndex(rawValue: Int(fromRankAsciiValue) - Constants.asciiDifferenceForRank),
                
                let toFileIndex = FileIndex(rawValue: Int(toFileAsciiValue) - Constants.asciiDifferenceForFile),
                let toRankIndex = RankIndex(rawValue: Int(toRankAsciiValue) - Constants.asciiDifferenceForRank)
                else { return }
            
            let move = MoveState(fromSquare: SquareState(fileIndex: fromFileIndex, rankIndex: fromRankIndex),
                                 toSquare: SquareState(fileIndex: toFileIndex, rankIndex: toRankIndex))
            
            inputHandlerDelegate?.didTakeInput(move)
        }
    }
}

extension CLIView: OutputHandler {
    
    func setup(boardState: BoardState) {
        // Was reversed earlier in the Constants.swift file for viewing convenience
        // Reversing a reverse will give us the accurate view
        Array(RankIndex._1.rawValue...RankIndex._8.rawValue).reversed().forEach { rank in
            Array(FileIndex._A.rawValue...FileIndex._H.rawValue).forEach { file in
                if let piece = boardState.squares[rank][file]?.piece {
                    print(piece.rawValue.symbol, separator: "", terminator: " ")
                } else {
                    print("x", separator: "", terminator: " ")
                }
            }
            print(Constants.newLine)
        }
    }
    
    func output(move: MoveState, boardState: BoardState) {
        setup(boardState: boardState)
    }
    
    func cancelMove() {
    }
}
