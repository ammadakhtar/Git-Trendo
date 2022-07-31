//
//  MockDataGenerator.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import Foundation

final class MockDataGenerator {
    func mockRepoData() -> [Repo] {
        let bundle = Bundle(for: Self.self)
        if let url = bundle.url(forResource: "sampleData", withExtension: "json") {
            let data = try? Data(contentsOf: url)
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(TrendingResponseDTO.self, from: data!)
                let trendingRepos = result.toDomain()
                return trendingRepos.reposArray
            } catch let err {
                print(err)
            }
        }
        return []
    }

    func mockTrendingRepoData() -> TrendingRepo? {
        let bundle = Bundle(for: Self.self)
        if let url = bundle.url(forResource: "sampleData", withExtension: "json") {
            let data = try? Data(contentsOf: url)
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(TrendingResponseDTO.self, from: data!)
                return result.toDomain()
            } catch let err {
                print(err)
            }
        }
        return nil
    }
}
