//
//  SearchRepoSection.swift
//  GitHubSearch
//
//  Created by 쎄부킴 on 2023/06/18.
//

import RxDataSources
import CoreNetwork

struct SearchRepoSection {
    var items: [GitHubRepoItem]
}

extension SearchRepoSection: SectionModelType {
    typealias Item = GitHubRepoItem
    
    init(original: SearchRepoSection, items: [GitHubRepoItem]) {
        self = original
        self.items = items
    }
}

