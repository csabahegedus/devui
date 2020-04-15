//
//  ArticlesListView.swift
//  Devui
//
//  Created by Emilio Schepis on 13/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ArticlesListView: View {
    
    @ObservedObject private var viewModel = ArticlesListViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    func onArticleAppear(_ article: Article) {
        if viewModel.articles.isLastItem(article) {
            viewModel.loadMoreArticles()
        }
    }
    
    var body: some View {
        List(viewModel.articles) { article in
            ArticlesListItemView(article)
                .padding(.bottom)
                .onAppear { self.onArticleAppear(article) }
        }
    }
}

struct ArticlesListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListView()
    }
}
