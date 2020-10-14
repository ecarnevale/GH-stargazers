//
//  Stargazer.swift
//  GH Stargazers
//
//  Created by Emanuel Carnevale on 11/10/2020.
//

import Foundation

struct Stargazer: Decodable {
    let login: String
    let id: Int
    let avatarURL: URL
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatarURL = "avatar_url"
    }
}
