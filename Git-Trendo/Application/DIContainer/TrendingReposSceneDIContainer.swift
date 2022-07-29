//
//  TrendingReposSceneDIContainer.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

final class TrendingReposSceneDIContainer {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Repository

    private func makeFetchTrendingRepositoryUseCaseProtocol() -> TrendingRepositoryProtocol {
        return TrendingRepositories(dataTransferService: dependencies.apiDataTransferService)
    }

    // MARK: - UseCases

    private func makeFetchTrendingRepositoryUseCases() -> FetchTrendingRepositoryUseCaseProtocol {
        return FetchTrendingRepositoryUseCase(repository: makeFetchTrendingRepositoryUseCaseProtocol())
    }

    // MARK: - ViewModel

    private func makeTrendingRepoListViewModel() -> TrendingRepoListViewModel {
        return TrendingRepoListViewModel(trendingRepositioriesUsecase: makeFetchTrendingRepositoryUseCases())
    }

    // MARK: - ViewController

    func makeTrendingRepoListViewController() -> TrendingRepoListViewController {
        return TrendingRepoListViewController(viewModel: makeTrendingRepoListViewModel())
    }
}
