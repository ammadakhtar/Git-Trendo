//
//  TrendingRepositoryProtocol.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

protocol TrendingRepositoryProtocol: AnyObject {
    func fetchTrendingRepositories(page: Int,
                                   loadFromCache: Bool,
                                   completion: @escaping (Result<TrendingRepo, Error>) -> Void) -> Cancellable?
}
