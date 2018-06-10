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
    static let idKey = "id"
    
    let symbol: Character
    let tip: Float
    let id: String
    
    init(symbol: Character, tip: Float, id: String? = nil) {
        self.symbol = symbol
        self.tip = abs(tip)
        self.id = id ?? NSUUID().uuidString.lowercased()
    }
    
    init?(dict: Dictionary<String, String>) {

        guard dict.keys.contains(TipPrototyp.symbolKey),
            dict.keys.contains(TipPrototyp.tipKey),
            dict.keys.contains(TipPrototyp.idKey) else {
            return nil
        }
        guard let symbol = dict[TipPrototyp.symbolKey]?[0] else {
            return nil
        }
        guard let tip = Float(dict[TipPrototyp.tipKey]!) else {
            return nil
        }
        guard let id = dict[TipPrototyp.idKey] else {
            return nil
        }
        
        self.init(symbol: symbol, tip: tip, id: id)
    }
    
    func toDict() -> Dictionary<String, String> {
        return [
            TipPrototyp.symbolKey: String(symbol),
            TipPrototyp.tipKey: "\(tip)",
            TipPrototyp.idKey: id
        ]
    }
    
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
