//
//  MainTabBarViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import RxSwift
import CoreNetwork
import CoreContainer
import GitHubSearch
import GitHubProfile

public final class MainTabBarViewController: UITabBarController {
    private let disposeBag = DisposeBag()
    private let authService = coreContainer.resolve(AuthServiceType.self)!
    
    private let loginBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "로그인"
        return item
    }()
    
    private let logoutBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "로그아웃"
        return item
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        let viewControllers = [
            makeGitHubSearchViewController(),
            makeGitHubProfileViewController()
        ]
        
        self.viewControllers = viewControllers
        title = "GitHub"
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if authService.currentAccessToken == nil {
            navigationItem.rightBarButtonItem = loginBarButton
        } else {
            navigationItem.rightBarButtonItem = logoutBarButton
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        loginBarButton.rx
            .tap
            .asSignal()
            .withUnretained(self)
            .emit(onNext: { owner, _ in
                owner.authService.authorize()
                    .subscribe(onNext: { _ in
                        owner.navigationItem.rightBarButtonItem = owner.logoutBarButton
                    })
                    .disposed(by: owner.disposeBag)
            })
            .disposed(by: disposeBag)
        
        logoutBarButton.rx
            .tap
            .asSignal()
            .emit(onNext: { [weak self] _ in
                self?.authService.logout()
                self?.navigationItem.rightBarButtonItem = self?.loginBarButton
            })
            .disposed(by: disposeBag)
    }
    
    private func makeGitHubSearchViewController() -> UIViewController {
        let reactor = GitHubSearchReactor()
        return GitHubSearchViewController(reactor: reactor)
    }
    
    private func makeGitHubProfileViewController() -> UIViewController {
        let reactor = GitHubProfileReactor()
        return GitHubProfileViewController(reactor: reactor)
    }
}
