//
//  SettingsRepository.swift
//  tip
//
//  Created by Michael Fröhlich on 10.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

protocol SettingsRepository {
    
    var shouldAnimate: Bool {get}
    var shouldProvideHapticFeedback: Bool {get}
}
