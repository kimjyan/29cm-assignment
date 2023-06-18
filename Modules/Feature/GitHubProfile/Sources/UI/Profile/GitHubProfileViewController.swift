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
    
    private let dataSource: RxCollectionViewSectionedReloadDataSource<ProfileSection>
    
    public var disposeBag = DisposeBag()
    
    public init(reactor: Reactor) {
        defer { self.reactor = reactor }
        dataSource = type(of: self).dataSourceFactory()
        super.init(nibName: nil, bundle: nil)
        title = "Profile"
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func dataSourceFactory() -> RxCollectionViewSectionedReloadDataSource<ProfileSection> {
        return .init(configureCell: { dataSource, collecvionView, indexPath, item in
            let cell = collecvionView.dequeueReusableCell(withReuseIdentifier: Constants.repoCellIdentifier, for: indexPath) as? GitHubRepoCell
            guard let cell = cell else { return UICollectionViewCell() }
            cell.configure(with: item)
            return cell
        })
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
        
        reactor.state
            .map(\.sections)
            .bind(to: starredCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(profileHeaderView)
        view.addSubview(starredCollectionView)
        starredCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func setUpConstraints() {
        profileHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        starredCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension GitHubProfileViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
}
