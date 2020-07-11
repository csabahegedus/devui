//
//  FollowersListViewModel.swift
//  Devui
//
//  Created by Emilio Schepis on 11/07/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Combine
import Foundation
import Resolver

class FollowersListViewModel: ObservableObject {
    
    @LazyInjected private var devService: DEVService
    @Published var followers = [Follower]()
    
    private var cancellables = Set<AnyCancellable>()
    private var completed = false
    private var currentPage = 1
    
    init() {
        loadFollowers()
    }
    
    func loadFollowers() {
        currentPage = 1
        
        devService.getFollowers()
            .replaceError(with: [])
            .assign(to: \.followers, on: self)
            .store(in: &cancellables)
    }
    
    func loadMoreFollowers() {
        guard !completed else { return }
        
        currentPage += 1
        
        devService.getFollowers(page: currentPage)
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] followers in
                if followers.count < Constants.followersPerPage {
                    self?.completed = true
                }
                
                self?.followers.append(contentsOf: followers)
            })
            .store(in: &cancellables)
    }
}
