//
//  PieceFactory.swift
//  Chess
//
//  Created by Adnan Zahid on 8/9/16.
//  Copyright © 2016 Chess. All rights reserved.
//

class PieceFactory {
    
    static func getPiece(_ value: Int) -> Piece? {
        
        switch value {
            
        case Constants.Values.king:
            return .whiteKing
        case Constants.Values.queen:
            return .whiteQueen
        case Constants.Values.rook:
            return .whiteRook
        case Constants.Values.knight:
            return .whiteKnight
        case Constants.Values.bishop:
            return .whiteBishop
        case Constants.Values.pawn:
            return .whitePawn
            
        case -Constants.Values.king:
            return .blackKing
        case -Constants.Values.queen:
            return .blackQueen
        case -Constants.Values.rook:
            return .blackRook
        case -Constants.Values.knight:
            return .blackKnight
        case -Constants.Values.bishop:
            return .blackBishop
        case -Constants.Values.pawn:
            return .blackPawn
            
        default:
            return nil
        }
    }
}
