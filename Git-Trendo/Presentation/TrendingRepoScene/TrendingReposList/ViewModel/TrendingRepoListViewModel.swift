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

protocol TrendingReopsListViewModelInput: AnyObject {
    func viewDidLoad()
    func pullToRefresh()
    func retryForError()
    func didLoadNextPage()
    func didSelectItem(at index: Int)
}

protocol TrendingReopsListViewModelOutput: AnyObject {
    var screenTitle: String { get }
    var repos: Observable<[TrendingRepositoriesListItemViewModel]> { get }
    var loading: Observable<TrendingRepositoriesListViewModelLoading?> { get }
    var error: Observable<String> { get }
}

protocol TrendingRepoListViewModelInputOutput: TrendingReopsListViewModelInput, TrendingReopsListViewModelOutput {}

final class TrendingRepoListViewModel: TrendingRepoListViewModelInputOutput {

    // MARK: - Properties

    let trendingRepositoriesUseCase: FetchTrendingRepositoryUseCaseProtocol

    var reposArray = [Repo]()
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { repos.value.count < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    // MARK: - Init

    init(trendingRepositioriesUsecase: FetchTrendingRepositoryUseCaseProtocol) {
        self.trendingRepositoriesUseCase = trendingRepositioriesUsecase
    }

    // MARK: - TrendingReopsListViewModelOutput

    // If we want to support localised string we can assing screenTitle as NSLocalizedString("Trending", comment:"")
    // and have localization string files to support multiple languages
    let screenTitle = "Trending"

    let repos: Observable<[TrendingRepositoriesListItemViewModel]> = Observable([])
    let loading: Observable<TrendingRepositoriesListViewModelLoading?> = Observable(.none)
    let error: Observable<String> = Observable("")

    // if we had a UI Control to cancel a task we can using this. Adding this for now just as a scalability point of view
    // this is useful if we were performing a search and want to cancel it.
    private var trendingRepoLoadTask: Cancellable? { willSet { trendingRepoLoadTask?.cancel() } }

    // MARK: - TrendingRepoListViewModelInputOutput

    func viewDidLoad() {
        self.loading.value = .firstPage
        self.loadData()
    }

    /// function to support pagination if `hasMorePages` is true
    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        self.loading.value = .nextPage
        loadData()
    }

    func didSelectItem(at index: Int) {
        repos.value[index].isCollapsed.toggle()
        loading.value = .none
    }

    func pullToRefresh() {
        reloadData()
    }

    func retryForError() {
        reloadData()
    }

    // MARK: - Private Methods

    /// Loads data for `Trending Github Repositories`
    private func loadData() {
        trendingRepoLoadTask = trendingRepositoriesUseCase.execute(requestvalue: .init(page: nextPage), loadFromCache: loading.value == .firstPage ? false : true) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleData(data)
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = .none
            self.trendingRepoLoadTask = nil
        }
    }

    /// Handles error in case of failure
    ///
    /// - parameter error:
    ///  value of type `Error`
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
        NSLocalizedString("No internet connection", comment: "") :
        NSLocalizedString("Failed loading repositories", comment: "")
    }

    /// Handles data in case of success
    /// - parameter data:
    ///  value of type `TrendingRepo`
    private func handleData(_ data: TrendingRepo) {
        currentPage = nextPage
        totalPageCount = data.totalCount
        reposArray = data.reposArray
        repos.value.append(contentsOf: data.reposArray.map(TrendingRepositoriesListItemViewModel.init))
    }

    private func reloadData() {
        loading.value = .firstPage
        currentPage = 0
        totalPageCount = 1
        repos.value.removeAll()
        loadData()
    }
}
