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
                 completion: @escaping (Result<TrendingRepo, Error>) -> Void) -> Cancellable?
    }

final class FetchTrendingRepositoryUseCase: FetchTrendingRepositoryUseCaseProtocol {

    // MARK: - Vairables
    
    private let trendingRepository: TrendingRepositoryProtocol

    // MARK: - Init

    init(repository: TrendingRepositoryProtocol) {
        trendingRepository = repository
    }

    // MARK: - FetchTrendingRepositoryUseCaseProtocol

    /// Function to load trending Repos using `TrendingRepository`
    ///
    /// - Parameter requestvalue:
    ///     `FetchTrendingRepositoryUseCaseRequestValue`.
    /// - Parameter loadFromCache:
    ///     `Bool`
    /// - Parameter completion:
    ///     `Result<Result<TrendingRepo, Error>`
    ///
    /// - Returns:
    /// An optional value of `Cancellable` to cancel a task
    func execute(requestvalue: FetchTrendingRepositoryUseCaseRequestValue,
                 loadFromCache: Bool,
                 completion: @escaping (Result<TrendingRepo, Error>) -> Void) -> Cancellable? {
        return trendingRepository.fetchTrendingRepositories(page: requestvalue.page, loadFromCache: loadFromCache) { result in
            completion(result)
        }
    }
}

struct FetchTrendingRepositoryUseCaseRequestValue {
    let page: Int
}
