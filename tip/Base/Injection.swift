//
//  Injection.swift
//  tip
//
//  Created by Michael Fröhlich on 08.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

class Injection {

    static let tipRepository: TipPrototypRepository = UDTipRepository()
    static let settingsRepository: SettingsRepository = DefaultSettingsRepository()
}
