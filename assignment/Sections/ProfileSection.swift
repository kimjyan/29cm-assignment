//
//  ProfileSection.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/18.
//

import RxDataSources

enum ProfileSection {
    case starred([ProfileSectionItem])
}

extension ProfileSection: SectionModelType {
    var items: [ProfileSectionItem] {
        switch self {
        case .starred(let items): return items
        }
    }
    
    init(original: ProfileSection, items: [ProfileSectionItem]) {
        switch original {
        case .starred: self = .starred(items)
        }
    }
}

enum ProfileSectionItem {
    case starred([RepoItem])
}
