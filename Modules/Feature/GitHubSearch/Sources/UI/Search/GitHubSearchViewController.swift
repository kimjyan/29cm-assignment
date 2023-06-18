//
//  GitHubSearchViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import ReactorKit
import RxSwift
import RxDataSources
import CoreNetwork
import CoreContainer

public final class GitHubSearchViewController: UIViewController, View {
    public typealias Reactor = GitHubSearchReactor
    
    public var disposeBag = DisposeBag()
    private let authService = coreContainer.resolve(AuthServiceType.self)!
    
    private struct Constants {
        static let repoCellIdentifier = "SearchRepoCell"
    }
    
    private let searchBar = UISearchBar()
    
    private let searchResultCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchRepoCell.self, forCellWithReuseIdentifier: Constants.repoCellIdentifier)
        return collectionView
    }()
    
    private let dataSource: RxCollectionViewSectionedReloadDataSource<SearchRepoSection>
    
    public init(reactor: Reactor) {
        defer { self.reactor = reactor}
        dataSource = type(of: self).dataSourceFactory()
        super.init(nibName: nil, bundle: nil)
        title = "List"
        view.backgroundColor = .white
    }
    
    private static func dataSourceFactory() -> RxCollectionViewSectionedReloadDataSource<SearchRepoSection> {
        return .init(configureCell: { dataSource, collecvionView, indexPath, item in
            let cell = collecvionView.dequeueReusableCell(withReuseIdentifier: Constants.repoCellIdentifier, for: indexPath) as? SearchRepoCell
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(reactor: GitHubSearchReactor) {
        searchBar.rx.text.orEmpty
            .skip(1)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .map { Reactor.Action.search($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.sections)
            .bind(to: searchResultCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func setUpView() {
        view.addSubview(searchBar)
        view.addSubview(searchResultCollectionView)
    }
    
    private func setUpConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func touchedLogin() {
        authService.authorize()
            .subscribe(onNext: {})
            .disposed(by: disposeBag)
    }
}
