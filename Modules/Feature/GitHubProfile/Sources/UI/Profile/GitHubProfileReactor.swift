//
//  GitHubProfileReactor.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/18.
//

import ReactorKit
import RxSwift
import CoreNetwork
import CoreView
import CoreContainer

public final class GitHubProfileReactor: Reactor {
    public let initialState = State()
    
    public enum Action {
        case initial
        case loadStarredRepo
        case setStar(Bool, id: Int)
    }
    
    public enum Mutation {
        case setViewState(ViewState)
        case setUser(AuthenticatedUser?)
        case setItems([GitHubRepoItem])

        case setStar(Bool, id: Int)
    }
    
    public struct State {
        @Pulse var viewState: ViewState = .pending

        var user: AuthenticatedUser?

        var page: Int = 0
        var items: [GitHubRepoItem] = []

        var sections: [ProfileSection] = []
    }

    private let network = coreContainer.resolve(NetworkProvider<GitHubAPI>.self)!
    
    public init() {}
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initial:
            return mutateInitial()
        case .loadStarredRepo:
            return mutateLoadNext()
        case .setStar:
            return .just(.setStar(false, id: 0))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setUser(let user):
            state.user = user
            action.onNext(.loadStarredRepo)
        case .setViewState(let viewState):
            state.viewState = viewState
        case .setItems(let items):
            state.sections = [ProfileSection(items: items)]
        case .setStar(_, id: let id):
            break
        }
        return state
    }
}

private extension GitHubProfileReactor {
    func mutateInitial() -> Observable<Mutation> {
        network.request(.authenticatedUser)
            .map(AuthenticatedUser.self)
            .asObservable()
            .map { $0 }
            .catchAndReturn(nil)
            .flatMap { user -> Observable<Mutation> in
                if let user {
                    return .of(
                        .setUser(user),
                        .setViewState(.loading)
                    )
                } else {
                    return .of(
                        .setViewState(.empty)
                    )
                }
            }
    }

    func mutateLoadNext() -> Observable<Mutation> {
        guard let user = currentState.user else { return .empty() }
        let page = currentState.page

        return network.request(.userStarredRepos(owners: user.login,
                                          parameters: ["page": page]))
            .map([GitHubRepoItem].self)
            .asObservable()
            .map { $0 }
            .catchAndReturn([GitHubRepoItem]())
            .flatMap { repo -> Observable<Mutation> in
                if repo.isEmpty {
                    return .of(
                        .setViewState(.empty)
                    )
                } else {
                    return .of(
                        .setItems(repo)
                    )
                }
            }
    }
}
