//
//  TrendingRepositories.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

final class TrendingRepositories: TrendingRepositoryProtocol {

    // MARK: - Variables
    
    private let dataTransferService: DataTransferService

    // MARK: - Init

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }

    // MARK: - TrendingRepositoryProtocol

    /// Function to load trending Repos using `FetchTrendingRepositoriesTask`
    ///
    /// - Parameter page:
    ///     `Int`.
    /// - Parameter loadFromCache:
    ///     `Bool`
    /// - Parameter completion:
    ///     `Result<Result<TrendingRepo, Error>`
    ///
    /// - Returns:
    /// An optional value of `Cancellable` to cancel a task
    func fetchTrendingRepositories(page: Int,
                                   loadFromCache: Bool,
                                   completion: @escaping (Result<TrendingRepo, Error>) -> Void) -> Cancellable? {
        let task = FetchTrendingRepositoriesTask()
        let requestDTO = TrendingRequestDTO(page: page, q: "language=+sort:stars")

        let endpoint = APIEndpoints.getTrendingRepositories(with: requestDTO)
        task.networkTask = dataTransferService.request(with: endpoint, loadFromCache: loadFromCache) { result in
            guard !task.isCancelled else { return }
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
