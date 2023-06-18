//
//  URLNavigationMap.swift
//  moyaAPP
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import Swinject
import URLNavigator
import CoreNetwork

final class URLNavigatorMap {
    static func initialize() {
        let navigator = container.resolve(NavigatorProtocol.self)!
        let authService = container.resolve(AuthServiceType.self)!

        navigator.handle("assignment://login") { url, values, context in
            guard let code = url.queryParameters["code"] else { return false }
            authService.callback(code: code)
            return true
        }
    }
}

