//
//  AuthViewModel.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Combine
import Resolver

class AuthViewModel: ObservableObject {
    
    @LazyInjected private var authService: AuthService
    @Published var apiKey = ""
    @Published var buttonEnabled = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $apiKey
            .map(validateAPIKey(_:))
            .assign(to: \.buttonEnabled, on: self)
            .store(in: &cancellables)
    }
    
    func signIn() {
        authService.saveAPIKey(apiKey)
        
    }
    
    func validateAPIKey(_ apiKey: String) -> Bool {
        return !apiKey
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
    }
}
