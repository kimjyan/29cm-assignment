//
//  URLNavigationMap.swift
//  moyaAPP
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import URLNavigator

final class URLNavigatorMap {
    static func initialize(
        navigator: NavigatorProtocol,
        authService: AuthServiceType
    ) {
        navigator.handle("callback://login") { url, values, context in
            guard let code = url.queryParameters["code"] else { return false }
            authService.callback(code: code)
            return true
        }
    }
}

