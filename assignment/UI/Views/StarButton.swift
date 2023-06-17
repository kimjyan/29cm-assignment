//
//  StarButton.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/18.
//

import UIKit

final class StarButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        setImage(UIImage(systemName: "star"), for: .normal)
        setImage(UIImage(systemName: "star.fill"), for: .selected)
        imageView?.tintColor = .systemYellow
        contentMode = .scaleAspectFit
    }
}

