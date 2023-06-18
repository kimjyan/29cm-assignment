//
//  GitHubAPI.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/15.
//

import Foundation
import Moya

public enum GitHubAPI {
    /// user
    case authenticatedUser
    case userStarredRepos(owners: String, parameters: [String: Any])
}

extension GitHubAPI: Moya.TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .authenticatedUser:
            return "/user"
        case .userStarredRepos(let owners, _):
            return "/users/\(owners)/starred"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .authenticatedUser,
                .userStarredRepos:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Moya.Task {
        switch self {
        case .authenticatedUser:
            return .requestPlain
        case .userStarredRepos(_, let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
