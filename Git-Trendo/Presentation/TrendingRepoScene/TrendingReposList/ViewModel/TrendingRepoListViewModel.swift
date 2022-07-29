//
//  TrendingRepoListViewModel.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

enum TrendingRepositoriesListViewModelLoading {
    case firstPage
    case nextPage
}

protocol MoviesListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSelectItem(at index: Int)
}

protocol MoviesListViewModelOutput {
    var screenTitle: String { get }
    var repos: Observable<[TrendingRepositoriesListItemViewModel]> { get }
    var loading: Observable<TrendingRepositoriesListViewModelLoading?> { get }
    var error: Observable<String> { get }
}

final class TrendingRepoListViewModel: MoviesListViewModelInput, MoviesListViewModelOutput {

    // MARK: - Properties

    private let trendingRepositoriesUseCase: FetchTrendingRepositoryUseCaseProtocol

    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    // MARK: - Init

    init(trendingRepositioriesUsecase: FetchTrendingRepositoryUseCaseProtocol) {
        self.trendingRepositoriesUseCase = trendingRepositioriesUsecase
    }

    // MARK: - MoviesListViewModelOutput

    // If we want to support localised string we can assing screenTitle as NSLocalizedString("Trending", comment:"")
    // and have localization string files to support multiple languages
    let screenTitle = "Trending"

    let repos: Observable<[TrendingRepositoriesListItemViewModel]> = Observable([])
    let loading: Observable<TrendingRepositoriesListViewModelLoading?> = Observable(.none)
    let error: Observable<String> = Observable("")

    // if we had a UI Control to cancel a task we can using this. Adding this for now just as a scalability point of view
    // this is useful if we were performing a search and want to cancel it.
    private var trendingRepoLoadTask: Cancellable? { willSet { trendingRepoLoadTask?.cancel() } }

    // MARK: - MoviesListViewModelInput

    func viewDidLoad() {
        self.loading.value = .firstPage
        self.loadData()
    }

    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        self.loading.value = .nextPage
        loadData()
    }

    func didSelectItem(at index: Int) {
    }

    // MARK: - Private Methods

    private func loadData() {
        trendingRepoLoadTask = trendingRepositoriesUseCase.execute(requestvalue: .init(page: nextPage), loadFromCache: false) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleData(data)
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = .none
        }
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
        NSLocalizedString("No internet connection", comment: "") :
        NSLocalizedString("Failed loading movies", comment: "")
    }

    private func handleData(_ data: TrendingRepos) {
        currentPage = nextPage
        totalPageCount = data.totalCount
        repos.value = data.reposArray.map(TrendingRepositoriesListItemViewModel.init)
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        repos.value.removeAll()
    }
}