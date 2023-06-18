//
//  AccessToken.swift
//  moyaAPP
//
//  Created by 쎄부킴 on 2023/06/14.
//

public struct AccessToken: Codable {
    public let tokenType: String
    public let accessToken: String
    public let scope: String
    
    public init(accessToken: String, tokenType: String, scope: String) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.scope = scope
    }
    
    private enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case scope = "scope"
    }
}
