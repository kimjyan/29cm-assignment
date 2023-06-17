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
    
    fileprivate let disposeBag = DisposeBag()
    
    init(authService: AuthServiceType) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        title = "Profile"
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.request(.authenticatedUser)
            .map(AuthenicatedUser.self)
            .subscribe(onSuccess: { user in
                print(user)
            })
            .disposed(by: disposeBag)
    }
}
