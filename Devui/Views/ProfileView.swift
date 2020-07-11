//
//  ProfileView.swift
//  Devui
//
//  Created by Emilio Schepis on 11/07/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            if let imageURL = viewModel.profileImage {
                NetworkImage(url: imageURL)
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 64, height: 64, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.primary, lineWidth: 2))
            }
            if let username = viewModel.username {
                Text(username)
                    .font(.title)
            }
            Button(action: viewModel.signOut) {
                Text("authentication_sign_out")
            }
            .padding(.top)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
