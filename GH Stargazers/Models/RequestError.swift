//
//  RequestError.swift
//  GH Stargazers
//
//  Created by Emanuel Carnevale on 14/10/2020.
//

import Foundation

struct RequestError: Decodable {
    let message: String
    let documentationURL: URL
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case documentationURL = "documentation_url"
    }
}
