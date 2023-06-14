//
//  AuthPlugin.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/15.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
    fileprivate let authService: AuthServiceType
    
    init(authService: AuthServiceType) {
        self.authService = authService
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let accessToken = authService.currentAccessToken?.accessToken {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

