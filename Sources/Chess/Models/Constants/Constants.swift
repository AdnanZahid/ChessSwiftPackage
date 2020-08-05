//
//  Constants.swxft
//  ChessSwift
//
//  Created by Adnan Zahid on 31/07/2020.
//  Copyright © 2020 Adnan Zahid. All rights reserved.
//

import Foundation

enum Constants {
    
    static let ranks = 8
    static let files = 8
    
    enum Values {
        static let empty  = 0
        static let pawn   = 100
        static let knight = 300
        static let bishop = 305
        static let rook   = 500
        static let queen  = 900
        static let king   = 2000
    }
    
    private static let x = Constants.Values.empty
    private static let p = Constants.Values.pawn
    private static let n = Constants.Values.knight
    private static let b = Constants.Values.bishop
    private static let r = Constants.Values.rook
    private static let q = Constants.Values.queen
    private static let k = Constants.Values.king
    
    private static let P = -p
    private static let N = -n
    private static let B = -b
    private static let R = -r
    private static let Q = -q
    private static let K = -k
    
    enum ChessBoardConfiguration {
        
        typealias ConfigurationType = [[Int]]
        
        static let standard: [[Int]] = [
            
            [R, N, B, Q, K, B, N, R],
            [P, P, P, P, P, P, P, P],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [p, p, p, p, p, p, p, p],
            [r, n, b, q, k, b, n, r],
        ].reversed() // Reversing for viewing convenience
        
        static let empty: [[Int]] = [
            
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
            [x, x, x, x, x, x, x, x],
        ]
    }
}
