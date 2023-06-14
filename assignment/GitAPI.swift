//
//  GitAPI.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/15.
//

import Foundation
import Moya

enum GitAPI {
    case authenticatedUser
}

extension GitAPI: Moya.TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .authenticatedUser:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
