//
//  Follower.swift
//  Devui
//
//  Created by Emilio Schepis on 11/07/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation

struct Follower: Identifiable, Decodable {
    
    let id: Int
    let username: String
    let name: String
    let path: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case path
        case profileImage = "profile_image"
    }
    
    static let example = Follower(id: 11,
                                  username: "notemilioschepis",
                                  name: "Not Emilio Schepis",
                                  path: "/notemilioschepis",
                                  profileImage: "https://via.placeholder.com/512")
}
