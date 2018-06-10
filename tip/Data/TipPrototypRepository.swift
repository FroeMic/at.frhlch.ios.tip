//
//  TipPrototypeRepository.swift
//  tip
//
//  Created by Michael Fröhlich on 10.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

protocol TipPrototypRepository  {
    
    func get() -> [TipPrototyp]
    
    func store(tipPrototyp: TipPrototyp)
    
    func remove(tipPrototyp: TipPrototyp)
    
    func update(tipPrototyp: TipPrototyp)
    
    func reset()
}
