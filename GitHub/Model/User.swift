//
//  User.swift
//  GitHub
//
//  Created by Adam Paluszewski on 13/09/2022.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    var htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
