//
//  TrendingRepositories.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

final class TrendingRepositories: TrendingRepositoryProtocol {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }

    // MARK: - TrendingRepositoryProtocol

    func fetchTrendingRepositories(query: TrendingRepoQuery,
                                   loadFromCache: Bool,
                                   completion: @escaping (Result<TrendingRepos, Error>) -> Void) -> Cancellable? {
        let task = FetchTrendingRepositoriesTask()
        let requestDTO = TrendingRequestDTO(query: query.query)

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
