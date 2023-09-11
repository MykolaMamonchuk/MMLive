//
//  UserML.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import Foundation

struct UserML: Codable {
    var id: Int?
    var username: String?
    var userAvatar: String?
    var userGitHubURL: String?

    enum CodingKeys: String, CodingKey {
        case id, username = "login", userAvatar = "avatar_url", userGitHubURL = "html_url"
    }
}
