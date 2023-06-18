//
//  GitHubRepoCell.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/18.
//

import UIKit
import SnapKit
import CoreView
import CoreNetwork

final class GitHubRepoCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        return view
    }()
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray29cm
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black29cm
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .gray29cm
        return label
    }()
    
    private let starButton: StarButton = {
        let button = StarButton()
        button.isSelected = true
        return button
    }()
    
    private let starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star")
        view.tintColor = .gray29cm
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray29cm
        return label
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
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black29cm.cgColor
        contentView.layer.cornerRadius = 20
        contentView.addSubview(imageView)
        contentView.addSubview(ownerNameLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(starButton)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(starCountLabel)
    }
    
    private func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(16)
            make.size.equalTo(24)
        }
        
        ownerNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.leading)
        }
        
        starButton.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalToSuperview()
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalTo(imageView.snp.leading)
        }
        
        starCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView)
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
        }
    }
    
    func configure(with item: GitHubRepoItem) {
        if let url = URL(string: item.owner.avatarURL) {
            imageView.kf.setImage(with: url)
        }
        ownerNameLabel.text = item.owner.name
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        starCountLabel.text = String(item.starredCount)
    }
}
