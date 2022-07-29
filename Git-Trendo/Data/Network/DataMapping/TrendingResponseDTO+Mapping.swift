//
//  TrendingResponseDTO+Mapping.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

// MARK: - Data Transfer Object

struct TrendingResponseDTO: Decodable {
    let reposArray: [RepoDTO]
    let totalCount: Int

    private enum CodingKeys: String, CodingKey {
        case reposArray = "items"
        case totalCount = "total_count"
    }
}

extension TrendingResponseDTO {
    struct RepoDTO: Decodable {
        let id: Int
        let name: String
        let owner: OwnerDTO
        let description: String?
        let language: String?
        let starsCount: Int

        private enum CodingKeys: String, CodingKey {
            case id, name, owner, description, language
            case starsCount = "stargazers_count"
        }
    }
}

extension TrendingResponseDTO {
    struct OwnerDTO: Decodable {
        let id: Int
        let login: String
        let avatarUrl: String

        enum CodingKeys: String, CodingKey {
            case id, login
            case avatarUrl = "avatar_url"
        }
    }
}

// MARK: - Mappings to Domain

extension TrendingResponseDTO {
    func toDomain() -> TrendingRepos {
        return .init(totalCount: totalCount,
                     reposArray: reposArray.map { $0.toDomain()})
    }
}

extension TrendingResponseDTO.RepoDTO {
    func toDomain() -> Repo {
        return .init(id: id,
                     name: name,
                     owner: owner.toDomain(),
                     description: description,
                     language: language,
                     starsCount: starsCount)
    }
}

extension TrendingResponseDTO.OwnerDTO {
    func toDomain() -> Owner {
        return .init(id: id,
                     login: login,
                     avatarUrl: avatarUrl)
    }
}
