//
//  TipPrototyp.swift
//  tip
//
//  Created by Michael Fröhlich on 10.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

struct TipPrototyp {
    
    static let symbolKey = "symbol"
    static let tipKey = "tip"
    
    let symbol: Character
    let tip: Float
    
    init(symbol: Character, tip: Float) {
        self.symbol = symbol
        self.tip = abs(tip)
    }
    
    init?(dict: Dictionary<String, String>) {

        guard dict.keys.contains(TipPrototyp.symbolKey) && dict.keys.contains(TipPrototyp.tipKey) else {
            return nil
        }
        guard let symbol = dict[TipPrototyp.symbolKey]?[0] else {
            return nil
        }
        guard let tip = Float(dict[TipPrototyp.tipKey]!) else {
            return nil
        }
        
        self.init(symbol: symbol, tip: tip)
    }
    
    func zip() -> Dictionary<String, String> {
        return [
            TipPrototyp.symbolKey: String(symbol),
            TipPrototyp.tipKey: "\(tip)"
        ]
    }
    
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
