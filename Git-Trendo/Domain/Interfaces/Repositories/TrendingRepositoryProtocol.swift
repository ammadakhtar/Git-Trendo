//
//  TrendingRepositoryProtocol.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

protocol TrendingRepositoryProtocol: AnyObject {
    @discardableResult
    func fetchTrendingRepositories(query: TrendingRepoQuery, loadFromCache: Bool, completion: @escaping (Result<TrendingRepos, Error>) -> Void) -> Cancellable?
}
