//
//  FollowersView.swift
//  Devui
//
//  Created by Emilio Schepis on 11/07/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct FollowersView: View {
    var body: some View {
        NavigationView {
            FollowersListView()
                .navigationBarTitle("followers_title")
        }
    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersView()
    }
}
