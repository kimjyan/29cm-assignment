//
//  CoreContainer.swift
//  CoreContainer
//
//  Created by 쎄부킴 on 2023/06/18.
//

import URLNavigator
import Swinject
import CoreNetwork

public let coreContainer = Container(defaultObjectScope: .container) { container in
    container.register(NavigatorProtocol.self) { _ in
        Navigator()
    }

    container.register(AuthServiceType.self) { resolver in
        AuthService(
            navigator: resolver.resolve(NavigatorProtocol.self)!
        )
    }

    container.register(NetworkProvider<GitHubAPI>.self) { resolver in
        NetworkProvider<GitHubAPI>(
            plugins: [
                AuthPlugin(
                    authService: resolver.resolve(AuthServiceType.self)!
                )
            ]
        )
    }
}
