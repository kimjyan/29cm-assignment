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

public final class AuthService: AuthServiceType {
    private let clientID = "4e9ab13f61d594eef6f7"
    private let clientSecret = "48cb526482d34ab37f13b1eb796e353b4013d2c0"
    
    private var currentViewController: UIViewController?
    private let callbackSubject = PublishSubject<String>()
    
    public private(set) var currentAccessToken: AccessToken?
    
    private let keychain = KeychainSwift()
    
    private let navigator: NavigatorProtocol
    
    public init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        currentAccessToken = loadAccessToken()
    }
    
    public func authorize() -> RxSwift.Observable<Void> {
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
    
    public func callback(code: String) {
        callbackSubject.onNext(code)
        currentViewController?.dismiss(animated: true)
        currentViewController = nil
    }
    
    public func logout() {
        currentAccessToken = nil
        deleteAccessToken()
    }
    
    private func accessToken(code: String) -> Single<AccessToken> {
        let urlString = "https://github.com/login/oauth/access_token"
        let parameters: Parameters = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code
        ]

        return Single.create { observer in
            let headers: HTTPHeaders = ["Accept": "application/json"]
            let request = AF
                .request(urlString, method: .post, parameters: parameters, headers: headers)
                .responseData { response in
                    switch response.result {
                    case let .success(jsonData):
                        do {
                            let accessToken = try JSONDecoder().decode(AccessToken.self, from: jsonData)
                            observer(.success(accessToken))
                        } catch let error {
                            observer(.failure(error))
                        }
                    case let .failure(error):
                        observer(.failure(error))
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    private func saveAccessToken(_ accessToken: AccessToken) {
        keychain.set(accessToken.accessToken, forKey: "access_token")
        keychain.set(accessToken.tokenType, forKey: "token_type")
        keychain.set(accessToken.scope, forKey: "scope")
    }

    private func loadAccessToken() -> AccessToken? {
        guard let accessToken = keychain.get("access_token"),
                let tokenType = keychain.get("token_type"),
                let scope = keychain.get("scope") else { return nil }
        return AccessToken(accessToken: accessToken, tokenType: tokenType, scope: scope)
    }

    private func deleteAccessToken() {
        keychain.delete("access_token")
        keychain.delete("token_type")
        keychain.delete("scope")
    }
}
