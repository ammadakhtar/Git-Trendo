//
//  Repo+Stub.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 30/07/2022.
//

import Foundation

extension Repo {
    static func stub(
        id: Int = 1223344,
        name: String = "Clean Architecture",
        owner: Owner = Owner(id: 12, login: "ammadAkhtar", avatarUrl: "https://www.google.com"),
        description: String = "Example repo of how to use clean architecture with MVVM-C",
        language: String = "Python",
        starsCount: Int = 122) -> Self {
        Repo(
            id: id,
             name: name,
            owner: owner,
            description: description,
            language: language,
            starsCount: starsCount)
    }
}
