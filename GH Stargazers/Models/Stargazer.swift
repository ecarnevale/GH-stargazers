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
//    let nodeId: String
    let avatarURL: URL
//    let gravatarId: String
//    let url: URL
//    let htmlURL: URL
//    let followersURL: URL
//    let followingURL: URL
//    let gistsURL: URL
//    let starredURL: URL
//    let subscriptionsURL: URL
//    let organizationsURL: URL
//    let reposURL: URL
//    let eventsURL: URL
//    let receivedEventsURL: URL
//    let type: String
//    let siteAdmin: Bool
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
//        case nodeId = "node_id"
        case avatarURL = "avatar_url"
//        case gravatarId = "gravatar_id"
//        case url = "url"
//        case htmlURL = "html_url"
//        case followersURL = "followers_url"
//        case followingURL = "following_url"
//        case gistsURL = "gists_url"
//        case starredURL = "starred_url"
//        case subscriptionsURL = "subscriptions_url"
//        case organizationsURL = "organizations_url"
//        case reposURL = "repos_url"
//        case eventsURL = "events_url"
//        case receivedEventsURL = "received_events_url"
//        case type = "type"
//        case siteAdmin = "site_admin"
    }
}
