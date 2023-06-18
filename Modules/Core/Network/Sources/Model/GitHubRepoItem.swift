//
//  GitHubRepoItem.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/18.
//

import Foundation

// MARK: - Repos
public struct GitHubRepos: Codable {
    public let items: [GitHubRepoItem]
}

// MARK: - ReposItem
public struct GitHubRepoItem: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    public let starredCount: Int
    public let owner: Owner
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "full_name"
        case description
        case starredCount = "stargazers_count"
        case owner
    }
}

public struct Owner: Codable {
    public let name: String
    public let avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"
    }
}

