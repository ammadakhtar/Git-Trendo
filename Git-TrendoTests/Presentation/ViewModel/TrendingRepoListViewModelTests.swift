//
//  TrendingRepoListViewModelTests.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import XCTest

final class FetchTrendingRepositoriesUseCaseMock: FetchTrendingRepositoryUseCaseProtocol {
    var expectation: XCTestExpectation?
    var error: Error?
    func execute(requestvalue: FetchTrendingRepositoryUseCaseRequestValue, loadFromCache: Bool, completion: @escaping (Result<TrendingRepo, Error>) -> Void) -> Cancellable? {
        let trendingRepos = TrendingRepoListViewModelTests().trendingRepos
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(trendingRepos))
        }
        expectation?.fulfill()
        return nil
    }
}

final class TrendingRepoListViewModelTests: XCTestCase {
    lazy var trendingRepos: TrendingRepo = {
        let trendingRepos = MockDataGenerator().mockTrendingRepoData()
        return trendingRepos!
    }()

    private enum SearchTrendingReposUseCaseError: Error {
        case someError
    }

    func test_whenFetchTrendingRepositoriesUseCaseRetrievesFirstPage_thenViewModelContainsOnlyFirstPage() {
        // given
        let fetchTrendningRepositoriesUseCaseMock = FetchTrendingRepositoriesUseCaseMock()
        fetchTrendningRepositoriesUseCaseMock.expectation = self.expectation(description: "Fetch Trending Repositories for first page")
        let viewModel = TrendingRepoListViewModel(trendingRepositioriesUsecase: fetchTrendningRepositoriesUseCaseMock)

        // when
        viewModel.viewDidLoad()

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.hasMorePages)
    }

    func test_whenFetchTrendingRepositoriesUseCaseRetrievesFirstPage_thenViewModelContainsTwoPages() {
        // given
        let fetchTrendningRepositoriesUseCaseMock = FetchTrendingRepositoriesUseCaseMock()
        fetchTrendningRepositoriesUseCaseMock.expectation = self.expectation(description: "Fetch Trending Repositories for first page")
        let viewModel = TrendingRepoListViewModel(trendingRepositioriesUsecase: fetchTrendningRepositoriesUseCaseMock)

        // when
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 5, handler: nil)


        fetchTrendningRepositoriesUseCaseMock.expectation = self.expectation(description: "Fetch Trending Repositories for second page")
        viewModel.didLoadNextPage()

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertTrue(viewModel.hasMorePages)
    }

    func test_whenFetchTrendingRepositoriesUseCaseReturnsError_thenViewModelContainsError() {
        // given
        let fetchTrendningRepositoriesUseCaseMock = FetchTrendingRepositoriesUseCaseMock()
        fetchTrendningRepositoriesUseCaseMock.expectation = self.expectation(description: "contain errors")
        fetchTrendningRepositoriesUseCaseMock.error = SearchTrendingReposUseCaseError.someError
        let viewModel = TrendingRepoListViewModel(trendingRepositioriesUsecase: fetchTrendningRepositoriesUseCaseMock)
        // when
        viewModel.viewDidLoad()

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
}
