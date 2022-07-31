//
//  TrendingRepoListViewControllerTests.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import XCTest

final class TrendingRepoListViewControllerTests: XCTestCase {

    class TrendingRepoListViewModelMock: TrendingRepoListViewModelInputOutput {
        func viewDidLoad() {}

        func pullToRefresh() {}

        func retryForError() {}

        func didLoadNextPage() {}

        func didSelectItem(at index: Int) {}

        var screenTitle: String {
            return "Test Title"
        }

        var repos: Observable<[TrendingRepositoriesListItemViewModel]> = Observable([])

        var loading: Observable<TrendingRepositoriesListViewModelLoading?> = Observable(.none)

        var error: Observable<String> = Observable("")

        let trendingRepositoriesUseCase: FetchTrendingRepositoryUseCaseProtocol = FetchTrendingRepositoriesUseCaseMock()
    }

    func testViewController_whoseTitleIsSet_ByViewModel_succeeds() {
        // Given
        let mockedViewModel = TrendingRepoListViewModelMock()
        let sut = TrendingRepoListViewController(viewModel: mockedViewModel)
        // Accessing the view causes it to load else it will return nil
        // When
        _ = sut.view
        // Then
        XCTAssertEqual(sut.title, mockedViewModel.screenTitle)
    }

    func testViewController_whenFetchesData_FromViewModel_numberOfRows_equalToTwnetySix_succeeds() {
        lazy var repos: [Repo] = {
            let repos = MockDataGenerator().mockRepoData()
            return repos
        }()

        // Given
        let mockedViewModel = TrendingRepoListViewModelMock()
        let sut = TrendingRepoListViewController(viewModel: mockedViewModel)

        // Accessing the view causes it to load else it will return nil
        // When
        _ = sut.view
        mockedViewModel.loading.value = .none
        mockedViewModel.repos.value.append(contentsOf: repos.map(TrendingRepositoriesListItemViewModel.init))
        sut.trendingRepoTableView.reloadData()

        let numberOfRows = sut.trendingRepoTableView.numberOfRows(inSection: 0)
        // Then
        XCTAssertEqual(numberOfRows, 26)
    }
}
