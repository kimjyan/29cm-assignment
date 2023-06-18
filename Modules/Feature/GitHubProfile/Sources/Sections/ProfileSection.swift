//
//  ProfileSection.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/18.
//

import RxDataSources
import CoreNetwork

struct ProfileSection {
    var items: [GitHubRepoItem]
}

extension ProfileSection: SectionModelType {
    typealias Item = GitHubRepoItem
    
    init(original: ProfileSection, items: [GitHubRepoItem]) {
        self = original
        self.items = items
    }
}
