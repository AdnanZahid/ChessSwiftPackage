//
//  Piece.swift
//  ChessSwift
//
//  Created by Adnan Zahid on 30/07/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

enum MovementStrategy: RawRepresentable {
    case diagonal
    case straight
    case lShaped
    
    var rawValue: [AdvancementState] {
        switch self {
        case .diagonal:
            return [AdvancementState(fileAdvancement: 1, rankAdvancement: 1),
                    AdvancementState(fileAdvancement: 1, rankAdvancement: -1),
                    AdvancementState(fileAdvancement: -1, rankAdvancement: 1),
                    AdvancementState(fileAdvancement: -1, rankAdvancement: -1)]
        case .straight:
            return [AdvancementState(fileAdvancement: 1, rankAdvancement: 0),
                    AdvancementState(fileAdvancement: 0, rankAdvancement: 1),
                    AdvancementState(fileAdvancement: -1, rankAdvancement: 0),
                    AdvancementState(fileAdvancement: 0, rankAdvancement: -1)]
        case .lShaped:
            return [AdvancementState(fileAdvancement: 1, rankAdvancement: 2),
                    AdvancementState(fileAdvancement: 2, rankAdvancement: 1),
                    AdvancementState(fileAdvancement: -1, rankAdvancement: 2),
                    AdvancementState(fileAdvancement: -2, rankAdvancement: 1),
                    AdvancementState(fileAdvancement: 1, rankAdvancement: -2),
                    AdvancementState(fileAdvancement: 2, rankAdvancement: -1),
                    AdvancementState(fileAdvancement: -1, rankAdvancement: -2),
                    AdvancementState(fileAdvancement: -2, rankAdvancement: -1)]
        }
    }
    
    init?(rawValue: [AdvancementState]) {
        return nil
    }
}

enum MovementType {
    case step
    case slide
    case slideFrom(fileIndex: FileIndex? = nil, rankIndex: RankIndex? = nil, forNumberOfFiles: Int = 0, forNumberOfRanks: Int = 0)
    case hop
}

enum MovementDirection {
    case forward
    case any
}

enum EligibleForPromotion {
    case yes(rankIndex: RankIndex, promotionOptions: [Piece])
    case no
}

enum Color {
    case white
    case black
}

typealias PieceTuple = (value: Int,
    movementStrategies: [MovementStrategy],
    captureStrategies: [MovementStrategy],
    movementTypes: [MovementType],
    movementDirection: MovementDirection,
    allowedToBeCaptured: Bool,
    eligibleForPromotion: EligibleForPromotion,
    color: Color,
    symbol: String)

enum Piece: RawRepresentable {
    private enum PieceConstants {
        static let kingCastlingSteps = 2
        static let pawnFirstMoveSteps = 2
    }
    
    case whiteBishop
    case whiteKing
    case whiteKnight
    case whitePawn
    case whiteQueen
    case whiteRook
    
    case blackBishop
    case blackKing
    case blackKnight
    case blackPawn
    case blackQueen
    case blackRook
    
    var rawValue: PieceTuple {
        switch self {
            
            // White
            
        case .whiteBishop: return PieceTuple(value: Constants.Values.bishop,
                                             movementStrategies: [.diagonal],
                                             captureStrategies: [.diagonal],
                                             movementTypes: [.slide],
                                             movementDirection: .any,
                                             allowedToBeCaptured: true,
                                             eligibleForPromotion: .no,
                                             color: .white,
                                             symbol: "b")
            
        case .whiteKing: return PieceTuple(value: Constants.Values.king,
                                           movementStrategies: [.diagonal, .straight],
                                           captureStrategies: [.diagonal, .straight],
                                           movementTypes: [.step,
                                                           .slideFrom(fileIndex: ._A, forNumberOfFiles: PieceConstants.kingCastlingSteps)],
                                           movementDirection: .any,
                                           allowedToBeCaptured: false,
                                           eligibleForPromotion: .no,
                                           color: .white,
                                           symbol: "k")
            
        case .whiteKnight: return PieceTuple(value: Constants.Values.knight,
                                             movementStrategies: [.lShaped],
                                             captureStrategies: [.lShaped],
                                             movementTypes: [.hop],
                                             movementDirection: .any,
                                             allowedToBeCaptured: true,
                                             eligibleForPromotion: .no,
                                             color: .white,
                                             symbol: "n")
            
        case .whitePawn: return PieceTuple(value: Constants.Values.pawn,
                                           movementStrategies: [.straight],
                                           captureStrategies: [.diagonal],
                                           movementTypes: [.step, .slideFrom(rankIndex: ._2, forNumberOfRanks: PieceConstants.pawnFirstMoveSteps)],
                                           movementDirection: .forward,
                                           allowedToBeCaptured: true,
                                           eligibleForPromotion: .yes(rankIndex: ._8, promotionOptions: [.whiteKnight, .whiteBishop, .whiteRook, .whiteQueen]),
                                           color: .white,
                                           symbol: "p")
            
        case .whiteQueen: return PieceTuple(value: Constants.Values.queen,
                                            movementStrategies: [.diagonal, .straight],
                                            captureStrategies: [.diagonal, .straight],
                                            movementTypes: [.slide],
                                            movementDirection: .any,
                                            allowedToBeCaptured: true,
                                            eligibleForPromotion: .no,
                                            color: .white,
                                            symbol: "q")
            
        case .whiteRook: return PieceTuple(value: Constants.Values.rook,
                                           movementStrategies: [.straight],
                                           captureStrategies: [.straight],
                                           movementTypes: [.slide],
                                           movementDirection: .any,
                                           allowedToBeCaptured: true,
                                           eligibleForPromotion: .no,
                                           color: .white,
                                           symbol: "r")
            
            // Black
            
        case .blackBishop: return PieceTuple(value: Constants.Values.bishop,
                                             movementStrategies: [.diagonal],
                                             captureStrategies: [.diagonal],
                                             movementTypes: [.slide],
                                             movementDirection: .any,
                                             allowedToBeCaptured: true,
                                             eligibleForPromotion: .no,
                                             color: .black,
                                             symbol: "B")
            
        case .blackKing: return PieceTuple(value: Constants.Values.king,
                                           movementStrategies: [.diagonal, .straight],
                                           captureStrategies: [.diagonal, .straight],
                                           movementTypes: [.step,
                                                           .slideFrom(fileIndex: ._H, forNumberOfFiles: PieceConstants.kingCastlingSteps)],
                                           movementDirection: .any,
                                           allowedToBeCaptured: false,
                                           eligibleForPromotion: .no,
                                           color: .black,
                                           symbol: "K")
            
        case .blackKnight: return PieceTuple(value: Constants.Values.knight,
                                             movementStrategies: [.lShaped],
                                             captureStrategies: [.lShaped],
                                             movementTypes: [.hop],
                                             movementDirection: .any,
                                             allowedToBeCaptured: true,
                                             eligibleForPromotion: .no,
                                             color: .black,
                                             symbol: "N")
            
        case .blackPawn: return PieceTuple(value: Constants.Values.pawn,
                                           movementStrategies: [.straight],
                                           captureStrategies: [.diagonal],
                                           movementTypes: [.step, .slideFrom(rankIndex: ._7, forNumberOfRanks: PieceConstants.pawnFirstMoveSteps)],
                                           movementDirection: .forward,
                                           allowedToBeCaptured: true,
                                           eligibleForPromotion: .yes(rankIndex: ._1, promotionOptions: [.blackKnight, .blackBishop, .blackRook, .blackQueen]),
                                           color: .black,
                                           symbol: "P")
            
        case .blackQueen: return PieceTuple(value: Constants.Values.queen,
                                            movementStrategies: [.diagonal, .straight],
                                            captureStrategies: [.diagonal, .straight],
                                            movementTypes: [.slide],
                                            movementDirection: .any,
                                            allowedToBeCaptured: true,
                                            eligibleForPromotion: .no,
                                            color: .black,
                                            symbol: "Q")
            
        case .blackRook: return PieceTuple(value: Constants.Values.rook,
                                           movementStrategies: [.straight],
                                           captureStrategies: [.straight],
                                           movementTypes: [.slide],
                                           movementDirection: .any,
                                           allowedToBeCaptured: true,
                                           eligibleForPromotion: .no,
                                           color: .black,
                                           symbol: "R")
        }
    }
    
    init?(rawValue: PieceTuple) {
        return nil
    }
}
