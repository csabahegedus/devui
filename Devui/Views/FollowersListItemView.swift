//
//  FollowersListItemView.swift
//  Devui
//
//  Created by Emilio Schepis on 11/07/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct FollowersListItemView: View {
    
    let follower: Follower
    
    init (_ follower: Follower) {
        self.follower = follower
    }
    
    var body: some View {
        HStack {
            if let image = follower.profileImage, let imageURL = URL(string: image)! {
                NetworkImage(url: imageURL)
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 32, height: 32, alignment: .center)
                    .clipShape(Circle())
                    .accessibility(hidden: true)
            }
            
            Text(follower.name)
                .font(.headline)
            
            Spacer()
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}

struct FollowersListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersListItemView(.example)
    }
}
