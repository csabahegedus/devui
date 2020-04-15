//
//  ArticlesListViewModel.swift
//  Devui
//
//  Created by Emilio Schepis on 13/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation
import Combine
import Resolver

class ArticlesListViewModel: ObservableObject {
    
    @LazyInjected private var devService: DEVService
    @Published var articles = [Article]()
    
    private var cancellables = Set<AnyCancellable>()
    private var completed = false
    private var currentPage = 1
    
    init() {
        loadArticles()
    }
    
    func loadArticles() {
        currentPage = 1
        
        devService.getArticles()
            .replaceError(with: [])
            .assign(to: \.articles, on: self)
            .store(in: &cancellables)
    }
    
    func loadMoreArticles() {
        guard !completed else { return }
        
        currentPage += 1
        
        devService.getArticles(page: currentPage)
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] articles in
                if articles.count < Constants.articlesPerPage {
                    self?.completed = true
                }
                
                self?.articles.append(contentsOf: articles)
            })
            .store(in: &cancellables)
    }
}
