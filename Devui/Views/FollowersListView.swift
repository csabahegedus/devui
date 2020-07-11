//
//  FollowersListView.swift
//  Devui
//
//  Created by Emilio Schepis on 11/07/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct FollowersListView: View {
    
    @ObservedObject private var viewModel = FollowersListViewModel()
    
    func onFollowerAppear(_ follower: Follower) {
        if viewModel.followers.isLastItem(follower) {
            viewModel.loadMoreFollowers()
        }
    }
    
    var body: some View {
        List(viewModel.followers) { follower in
            FollowersListItemView(follower)
                .onAppear { self.onFollowerAppear(follower) }
        }
    }
}

struct FollowersListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersListView()
    }
}
