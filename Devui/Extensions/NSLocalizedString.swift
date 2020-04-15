//
//  NSLocalizedString.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation

func NSLocalizedString(_ key: String, arguments: CVarArg...) -> String {
    String(format: NSLocalizedString(key, comment: ""), arguments)
}
