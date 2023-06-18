//
//  GitHubProfileViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources
import CoreNetwork
import CoreContainer

public final class GitHubProfileViewController: UIViewController, View {
    public typealias Reactor = GitHubProfileReactor

    private struct Constants {
        static let repoCellIdentifier = "RepoCell"
    }
    
    private let profileHeaderView = GitHubProfileHeaderView()
    
    private let starredCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(GitHubRepoCell.self, forCellWithReuseIdentifier: Constants.repoCellIdentifier)
        return collectionView
    }()
    
    public var disposeBag = DisposeBag()
    
    public init(reactor: Reactor) {
        defer { self.reactor = reactor }

        super.init(nibName: nil, bundle: nil)
        title = "Profile"
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
    }

    public func bind(reactor: GitHubProfileReactor) {
        reactor.action.onNext(.initial)
        reactor.state
            .map(\.user)
            .bind(to: profileHeaderView.rx.configure)
            .disposed(by: disposeBag)
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(profileHeaderView)
    }
    
    private func setUpConstraints() {
        profileHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
