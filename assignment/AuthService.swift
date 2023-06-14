//
//  AuthService.swift
//  moya
//
//  Created by 쎄부킴 on 2023/06/13.
//


import SafariServices
import URLNavigator

import RxSwift
import UIKit
import Alamofire
import KeychainSwift


protocol AuthServiceType {
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

final class AuthService: AuthServiceType {
    fileprivate let clientID = "d6d8607707c651415c15"
    fileprivate let clientSecret = "b617c4921b42ec4e59268e09a91d686ab0fd6904"
    
    fileprivate var currentViewController: UIViewController?
    fileprivate let callbackSubject = PublishSubject<String>()
    
    private(set) var currentAccessToken: AccessToken?
    
    fileprivate let keychain = KeychainSwift()
    
    private let navigator: NavigatorProtocol
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        currentAccessToken = loadAccessToken()
    }
    
    func authorize() -> RxSwift.Observable<Void> {
        let urlString = "https://github.com/login/oauth/authorize"
        let scope = "repo gist user"
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "scope", value: scope),
        ]
        let safariViewController = SFSafariViewController(url: components.url!)
        let navigationController = UINavigationController(rootViewController: safariViewController)
        navigationController.isNavigationBarHidden = true
        navigator.present(navigationController, wrap: nil, from: nil, animated: true, completion: nil)
        self.currentViewController = navigationController
        
        return callbackSubject
            .flatMap(accessToken)
            .do(onNext: { [weak self] accessToken in
                self?.saveAccessToken(accessToken)
                self?.currentAccessToken = accessToken
            })
            .map { _ in}
    }
    
    func callback(code: String) {
        callbackSubject.onNext(code)
        currentViewController?.dismiss(animated: true)
        currentViewController = nil
    }
    
    func logout() {
        currentAccessToken = nil
        deleteAccessToken()
    }
    
    fileprivate func accessToken(code: String) -> Single<AccessToken> {
        let urlString = "https://github.com/login/oauth/access_token"
        let parameters: Parameters = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code
        ]
        
        return Single.create { observer in
            let headers: HTTPHeaders = ["Accept": "application/json"]
            let request = Alamofire
                .request(urlString, method: .post, parameters: parameters, headers: headers)
                .responseData { response in
                    switch response.result {
                    case let .success(jsonData):
                        do {
                            let accessToken = try JSONDecoder().decode(AccessToken.self, from: jsonData)
                            observer(.success(accessToken))
                        } catch let error {
                            observer(.error(error))
                        }
                    case let .failure(error):
                        observer(.error(error))
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    fileprivate func saveAccessToken(_ accessToken: AccessToken) {
        keychain.set(accessToken.accessToken, forKey: "access_token")
        keychain.set(accessToken.tokenType, forKey: "token_type")
        keychain.set(accessToken.scope, forKey: "scope")
    }
    
    fileprivate func loadAccessToken() -> AccessToken? {
        guard let accessToken = keychain.get("access_token"),
              let tokenType = keychain.get("token_type"),
              let scope = keychain.get("scope") else { return nil }
        return AccessToken(accessToken: accessToken, tokenType: tokenType, scope: scope)
    }
    
    fileprivate func deleteAccessToken() {
        keychain.delete("access_token")
        keychain.delete("token_type")
        keychain.delete("scope")
    }
}
