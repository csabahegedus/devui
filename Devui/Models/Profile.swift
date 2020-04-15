//
//  Profile.swift
//  Devui
//
//  Created by Emilio Schepis on 14/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation

struct Profile: Identifiable, Decodable {
    
    let id: Int
    let username: String
    let name: String
    let summary: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case summary
        case profileImage = "profile_image"
    }
    
    static let example = Profile(id: 0,
                                 username: "emilioschepis",
                                 name: "Emilio Schepis",
                                 summary: "Hi! I'm Emilio, a 23yo software engineer from Italy.",
                                 profileImage: "https://via.placeholder.com/512")
}
