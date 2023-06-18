//
//  GitHubSearchReactor.swift
//  GitHubSearch
//
//  Created by 쎄부킴 on 2023/06/18.
//

import ReactorKit
import RxSwift
import CoreNetwork
import CoreView
import CoreContainer

public final class GitHubSearchReactor: Reactor {
    public let initialState = State()
    
    public enum Action {
        case search(String)
        case setStar(Bool, id: Int)
    }
    
    public enum Mutation {
        case setViewState(ViewState)
        case setItems([GitHubRepoItem])
        case setStar(Bool, id: Int)
    }
    
    public struct State {
        @Pulse var viewState: ViewState = .pending

        var user: AuthenticatedUser?

        var page: Int = 0
        var items: [GitHubRepoItem] = []

        var sections: [SearchRepoSection] = []
    }

    private let network = coreContainer.resolve(NetworkProvider<GitHubAPI>.self)!
    
    public init() {}
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .search:
            return .just(.setItems([]))
        case .setStar:
            return .just(.setStar(false, id: 0))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setViewState(let viewState):
            state.viewState = viewState
        case .setItems(let items):
            state.sections = [SearchRepoSection(items: items)]
        case .setStar(_, id: let id):
            break
        }
        return state
    }
}
