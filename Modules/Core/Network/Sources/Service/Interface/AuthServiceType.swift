//
//  AuthServiceType.swift
//  CoreNetwork
//
//  Created by 쎄부킴 on 2023/06/18.
//

import RxSwift

public protocol AuthServiceType {
    var currentAccessToken: AccessToken? { get }

    /// Start OAuth authorization process.
    ///
    /// - returns: An Observable of `AccessToken` instance.
    func authorize() -> Observable<Void>

    /// Call this method when redirected from OAuth process to request access token.
    ///
    /// - parameter code: `code` from redirected url.
    func callback(code: String)

    func logout()
}
