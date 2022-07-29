//
//  Repo.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

struct Repo {
    let id: Int
    let name: String
    let owner: Owner
    let description: String?
    let language: String?
    let starsCount: Int
}


struct Owner: Codable, Equatable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
}
