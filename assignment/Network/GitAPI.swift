//
//  GitAPI.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/15.
//

import Foundation
import Moya

enum GitAPI {
    /// user
    case authenticatedUser
    case userStarredRepos(owners: String, parameters: [String: Any])
}

extension GitAPI: Moya.TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .authenticatedUser:
            return "/user"
        case .userStarredRepos(let owners, _):
            return "/users/\(owners)/starred"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authenticatedUser,
                .userStarredRepos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
        case .authenticatedUser:
            return .requestPlain
        case .userStarredRepos(_, let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
