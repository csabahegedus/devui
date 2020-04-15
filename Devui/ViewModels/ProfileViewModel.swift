//
//  ProfileViewModel.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Combine
import Resolver

class ProfileViewModel: ObservableObject {
    
    @LazyInjected private  var authService: AuthService
    @LazyInjected private var devService: DEVService
    @Published private var profile: Profile?
    @Published private var error: Error?
    @Published var loading: Bool = true
    @Published var profileImage: URL?
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        devService.getProfile()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] profile in
                    self?.loading = false
                    self?.profile = profile
            })
            .store(in: &cancellables)
        
        
        $profile
            .compactMap({ $0 })
            .compactMap({ URL(string: $0.profileImage) })
            .assign(to: \.profileImage, on: self)
            .store(in: &cancellables)
        
        $error
            .compactMap({ $0 })
            .map({ $0.localizedDescription })
            .assign(to: \.errorMessage, on: self)
            .store(in: &cancellables)
    }
    
    func signOut() {
        authService.removeAPIKey()
    }
}
