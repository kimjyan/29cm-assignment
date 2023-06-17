//
//  AccessToken.swift
//  moyaAPP
//
//  Created by 쎄부킴 on 2023/06/14.
//

struct AccessToken: Codable {
    var tokenType: String
    var accessToken: String
    var scope: String
    
    init(accessToken: String, tokenType: String, scope: String) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.scope = scope
    }
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case scope = "scope"
    }
}
