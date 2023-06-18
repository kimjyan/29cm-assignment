//
//  ProfileSection.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/18.
//

import RxDataSources

struct ProfileSection {
    var items: [RepoItem]
}

extension ProfileSection: SectionModelType {
    typealias Itme = RepoItem
    
    init(original: ProfileSection, items: [RepoItem]) {
        self = original
        self.items = items
    }
}
