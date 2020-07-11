//
//  ArticlesView.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ArticlesView: View {
    var body: some View {
        NavigationView {
            ArticlesListView()
                .navigationBarTitle("articles_title")
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
