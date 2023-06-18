//
//  ProfileViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import RxSwift

final class ProfilViewController: UIViewController {
    
    fileprivate let authService: AuthServiceType
    
    fileprivate lazy var network = NetworkProvider<GitAPI>(plugins: [AuthPlugin(authService: authService)])
    
    private let profileHeaderView = ProfileHeaderView()
    
    private let disposeBag = DisposeBag()
    
    init(authService: AuthServiceType) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        title = "Profile"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
        bindData()
    }
    
    private func bindData() {
        network.request(.authenticatedUser)
            .map(AuthenicatedUser.self)
            .subscribe(
                onSuccess: { [weak self] user in
                    self?.profileHeaderView.configure(with: user)
                },
                onFailure: { error in
                    print(error)
                })
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
