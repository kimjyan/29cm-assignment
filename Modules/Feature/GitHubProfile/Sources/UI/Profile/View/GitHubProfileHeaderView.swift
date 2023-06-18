//
//  GitHubProfileHeaderView.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/17.
//

import UIKit
import SnapKit
import Kingfisher
import CoreNetwork
import CoreView
import RxSwift

final class GitHubProfileHeaderView: UIView {
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private let idNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "id"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black29cm
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray29cm
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "company"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black29cm
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "location"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black29cm
        return label
    }()
    
    private let companyLocationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black29cm
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "팔로잉"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray29cm
        return label
    }()
    
    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black29cm
        return label
    }()
    
    private let followerLabel: UILabel = {
        let label = UILabel()
        label.text = "팔로워"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray29cm
        return label
    }()
    
    private let followerCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black29cm
        return label
    }()
    
    private let followStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(avatarImageView)
        addSubview(idNameStackView)
        idNameStackView.addArrangedSubview(idLabel)
        idNameStackView.addArrangedSubview(nameLabel)
        addSubview(companyLocationStackView)
        companyLocationStackView.addArrangedSubview(companyLabel)
        companyLocationStackView.addArrangedSubview(locationLabel)
        addSubview(emailLabel)
        addSubview(followStackView)
        followStackView.addArrangedSubview(followerLabel)
        followStackView.addArrangedSubview(followerCountLabel)
        followStackView.addArrangedSubview(followingLabel)
        followStackView.addArrangedSubview(followingCountLabel)
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(companyLocationStackView)
        contentStackView.addArrangedSubview(emailLabel)
        contentStackView.addArrangedSubview(followStackView)
    }
    
    private func setUpConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(16)
            make.size.equalTo(100)
        }
        
        idNameStackView.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(8)
            make.leading.equalTo(avatarImageView.snp.leading)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(with user: AuthenticatedUser?) {
        if let url = URL(string: user?.avatarURL ?? "") {
            avatarImageView.kf.setImage(with: url)
        }
        idLabel.text = user?.login
        nameLabel.text = user?.name
        emailLabel.text = user?.email
        companyLabel.text = user?.company
        locationLabel.text = user?.location
        followerCountLabel.text = String(user?.followers ?? 0)
        followingCountLabel.text = String(user?.following ?? 0)
    }
}

extension Reactive where Base: GitHubProfileHeaderView {
    var configure: Binder<AuthenticatedUser?> {
        return Binder(self.base) { (base, value) in
            base.configure(with: value)
        }
    }
}
