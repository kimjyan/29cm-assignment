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
    public let fullName: String
    public let description: String?
    public let topics: [String]
    public let star: Int
    public let fork: Int
    public let language: String?
    public let updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id, description, topics, language
        case fullName = "full_name"
        case star = "stargazers_count"
        case fork = "forks_count"
        case updatedAt = "updated_at"
    }
}

