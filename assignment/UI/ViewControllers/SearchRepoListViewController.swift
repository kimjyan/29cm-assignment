//
//  SearchRepoListViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import RxSwift

final class SearchRepoListViewController: UIViewController {
    fileprivate let disposeBag = DisposeBag()
    fileprivate let authService: AuthServiceType
    
    fileprivate let titleView = UIView()
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    fileprivate let rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    init(authService: AuthServiceType) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        title = "List"
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightButton.addTarget(self, action: #selector(touchedLogin), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNavigationTitle() {
        titleLabel.text = title
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(rightButton)
        resizeNavigationTitle()

        navigationItem.titleView = titleView
    }
    
    private func resizeNavigationTitle() {
        guard let navigationController = navigationController else { return }

        let size = navigationController.navigationBar.bounds.size
        guard size != .zero else { return }

        let titleSize = CGSize(width: size.width - 100, height: size.height)
        titleView.frame = CGRect(origin: .zero, size: titleSize)
        titleLabel.frame = CGRect(x: 0, y: 0, width: titleSize.width, height: titleSize.height)
        rightButton.frame = CGRect(x: titleSize.width - 32, y: 0, width: 64, height: 32)
    }
    
    @objc func touchedLogin() {
        authService.authorize()
            .subscribe(onNext: {})
            .disposed(by: disposeBag)
    }
}
