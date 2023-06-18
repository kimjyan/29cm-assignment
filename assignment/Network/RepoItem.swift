//
//  RepoItem.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/18.
//

import Foundation

// MARK: - Repos
struct Repos: Codable {
    let items: [RepoItem]
}

// MARK: - ReposItem
struct RepoItem: Codable {
    let id: Int
    let fullName: String
    let description: String?
    let topics: [String]
    let star: Int
    let fork: Int
    let language: String?
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, description, topics, language
        case fullName = "full_name"
        case star = "stargazers_count"
        case fork = "forks_count"
        case updatedAt = "updated_at"
    }
}

