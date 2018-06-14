//
//  UDTipRepository.swift
//  tip
//
//  Created by Michael Fröhlich on 10.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

class UDTipRepository {

    fileprivate let savedTipPrototypsKey = "tipPrototyps"
    fileprivate let defaults = UserDefaults.standard
    
    fileprivate func store(tipProtoypes: [TipPrototyp]) {
        let dictTipPrototypes = tipProtoypes.map( { $0.toDict() })
        defaults.set(dictTipPrototypes, forKey: savedTipPrototypsKey)
    }
    
}

extension UDTipRepository: TipPrototypRepository {
    
    func get() -> [TipPrototyp] {
        guard let results = defaults.array(forKey: savedTipPrototypsKey), results.count > 0 else {
            reset()
            return get()
        }

        var tipPrototyps: [TipPrototyp] = []
        for element in results {
            if let dict = element as? Dictionary<String, String>,
                let tipPrototyp = TipPrototyp(dict: dict) {
                tipPrototyps.append(tipPrototyp)
            }
        }
        
        tipPrototyps.sort(by: { $0.tip < $1.tip })
        
        return tipPrototyps
    }
    
    func store(tipPrototyp: TipPrototyp) {
        var oldTipPrototyps = get()
        
        if let _ = oldTipPrototyps.index(where: { $0.id == tipPrototyp.id }) {
            update(tipPrototyp: tipPrototyp)
            return
        }
        
        oldTipPrototyps.append(tipPrototyp)
        store(tipProtoypes: oldTipPrototyps)
    }
    
    func remove(tipPrototyp: TipPrototyp) {
        let oldTipPrototyps = get()
        
        var newTipPrototyps: [TipPrototyp] = []
        for currentTipPrototyp in oldTipPrototyps {
            if tipPrototyp.id == currentTipPrototyp.id {
                continue
            }
            
            newTipPrototyps.append(currentTipPrototyp)
        }
        
        store(tipProtoypes: newTipPrototyps)
    }
    
    func update(tipPrototyp: TipPrototyp) {
        let oldTipPrototyps = get()
        
        var newTipPrototyps: [TipPrototyp] = []
        for currentTipPrototyp in oldTipPrototyps {
            if tipPrototyp.id == currentTipPrototyp.id {
                newTipPrototyps.append(tipPrototyp)
            } else {
                newTipPrototyps.append(currentTipPrototyp)
            }
        }
        
        store(tipProtoypes: newTipPrototyps)
    }
    
    func reset() {
        store(tipProtoypes: [
                TipPrototyp(symbol: "🤮", tip: 0.00),
                TipPrototyp(symbol: "😟", tip: 0.05),
                TipPrototyp(symbol: "🙄", tip: 0.10),
                TipPrototyp(symbol: "🙂", tip: 0.15),
                TipPrototyp(symbol: "😁", tip: 0.20),
                TipPrototyp(symbol: "🤩", tip: 0.25)
            ])
    }
    
    
    
}
