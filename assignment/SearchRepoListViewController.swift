//
//  SearchRepoListViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit

final class SearchRepoListViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SearchRepoListViewController"
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "List"
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        titleLabel.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
