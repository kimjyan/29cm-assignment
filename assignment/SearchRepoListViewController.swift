//
//  SearchRepoListViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit

final class SearchRepoListViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "List"
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
