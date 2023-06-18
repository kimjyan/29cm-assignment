//
//  AuthenticatedUser.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/15.
//

import Foundation

// MARK: - AuthenticatedUser
public struct AuthenticatedUser: Codable {
    public let avatarURL: String
    public let bio, blog: String?
    public let businessPlus: Bool?
    public let collaborators: Int?
    public let company: String?
    public let createdAt: String
    public let diskUsage: Int?
    public let email: String?
    public let eventsURL: String
    public let followers: Int
    public let followersURL: String
    public let following: Int
    public let followingURL, gistsURL: String
    public let gravatarID: String?
    public let hireable: Bool?
    public let htmlURL: String
    public let id: Int
    public let ldapDN: String?
    public let location: String?
    public let login: String
    public let name: String?
    public let nodeID, organizationsURL: String
    public let ownedPrivateRepos: Int?
    public let plan: Plan?
    public let privateGists: Int?
    public let publicGists, publicRepos: Int
    public let receivedEventsURL, reposURL: String
    public let siteAdmin: Bool
    public let starredURL, subscriptionsURL: String
    public let suspendedAt: Date?
    public let totalPrivateRepos: Int?
    public let twitterUsername: String?
    public let twoFactorAuthentication: Bool?
    public let type: String
    public let updatedAt: String
    public let url: String

    private enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bio, blog
        case businessPlus = "business_plus"
        case collaborators, company
        case createdAt = "created_at"
        case diskUsage = "disk_usage"
        case email
        case eventsURL = "events_url"
        case followers
        case followersURL = "followers_url"
        case following
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case gravatarID = "gravatar_id"
        case hireable
        case htmlURL = "html_url"
        case id
        case ldapDN = "ldap_dn"
        case location, login, name
        case nodeID = "node_id"
        case organizationsURL = "organizations_url"
        case ownedPrivateRepos = "owned_private_repos"
        case plan
        case privateGists = "private_gists"
        case publicGists = "public_gists"
        case publicRepos = "public_repos"
        case receivedEventsURL = "received_events_url"
        case reposURL = "repos_url"
        case siteAdmin = "site_admin"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case suspendedAt = "suspended_at"
        case totalPrivateRepos = "total_private_repos"
        case twitterUsername = "twitter_username"
        case twoFactorAuthentication = "two_factor_authentication"
        case type
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - Plan
public struct Plan: Codable {
    public let collaborators: Int
    public let name: String
    public let privateRepos, space: Int

    private enum CodingKeys: String, CodingKey {
        case collaborators, name
        case privateRepos = "private_repos"
        case space
    }
}
