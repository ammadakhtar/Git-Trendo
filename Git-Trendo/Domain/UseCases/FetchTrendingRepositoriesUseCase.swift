//
//  FetchTrendingRepositoriesUseCase.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

protocol FetchTrendingRepositoryUseCaseProtocol: AnyObject {
    func execute(requestvalue: FetchTrendingRepositoryUseCaseRequestValue,
                 loadFromCache: Bool,
                 completion: @escaping (Result<TrendingRepos, Error>) -> Void) -> Cancellable?
    }

final class FetchTrendingRepositoryUseCase: FetchTrendingRepositoryUseCaseProtocol {

    private let trendingRepository: TrendingRepositoryProtocol

    init(repository: TrendingRepositoryProtocol) {
        trendingRepository = repository
    }

    // MARK: - FetchTrendingRepositoryUseCaseProtocol

    func execute(requestvalue: FetchTrendingRepositoryUseCaseRequestValue,
                 loadFromCache: Bool,
                 completion: @escaping (Result<TrendingRepos, Error>) -> Void) -> Cancellable? {
        return trendingRepository.fetchTrendingRepositories(page: requestvalue.page, loadFromCache: loadFromCache) { result in
            completion(result)
        }
    }
}

struct FetchTrendingRepositoryUseCaseRequestValue {
    let page: Int
}
