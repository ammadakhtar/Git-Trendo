//
//  TrendingRepositoriesListItemViewModel.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

// This item view model is to display data and does not contain any domain model to prevent views accessing it
struct TrendingRepositoriesListItemViewModel {
    let id: Int
    let name: String
    let owner: Owner
    let description: String?
    let language: String?
    let starsCount: Int
    var isCollapsed: Bool = true

    init(repo: Repo) {
        self.id = repo.id
        self.name = repo.name
        self.owner = repo.owner
        self.description = repo.description
        self.language = repo.language
        self.starsCount = repo.starsCount
    }
}
