//
//  ProfileViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit

final class ProfilViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Profile"
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
