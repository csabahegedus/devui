//
//  Loggers.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import os.log

enum Loggers {
    static let identifier = Bundle.main.bundleIdentifier!
    
    static let auth = OSLog(subsystem: identifier, category: "Auth")
    static let cache = OSLog(subsystem: identifier, category: "Cache")
    static let network = OSLog(subsystem: identifier, category: "Network")
}
