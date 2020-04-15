//
//  AuthService.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Combine
import Resolver
import os.log

class AuthService: ObservableObject {
    
    @Published var apiKey: String?
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.apiKey = defaults.string(forKey: Keys.defaultsApiKey)
        
        os_log(.info, log: Loggers.auth, "Loaded API key: %{PRIVATE}@", self.apiKey ?? "nil")
    }
    
    func saveAPIKey(_ apiKey: String) {
        os_log(.info, log: Loggers.auth, "Saved API key: %{PRIVATE}@", apiKey)
        
        self.defaults.set(apiKey, forKey: Keys.defaultsApiKey)
        self.apiKey = apiKey
    }
    
    func removeAPIKey() {
        os_log(.info, log: Loggers.auth, "Removed API key")
        
        self.defaults.removeObject(forKey: Keys.defaultsApiKey)
        self.apiKey = nil
    }
}
