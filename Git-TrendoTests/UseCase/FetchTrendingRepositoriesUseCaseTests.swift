//
//  FetchTrendingRepositoriesUseCaseTests.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import XCTest

final class TrendingRepositoryMock: TrendingRepositoryProtocol {
    func fetchTrendingRepositories(page: Int, loadFromCache: Bool, completion: @escaping (Result<TrendingRepo, Error>) -> Void) -> Cancellable? {
        let repos = FetchTrendingRepositoriesUseCaseTests().trendingRepos
        let result: Result<TrendingRepo, Error> = .success(repos)
        completion(result)
        return nil
    }
}


final class FetchTrendingRepositoriesUseCaseTests: XCTestCase {
    lazy var trendingRepos: TrendingRepo = {
        let trendingRepos = MockDataGenerator().mockTrendingRepoData()
        return trendingRepos!
    }()

    func testFetchTrendingReposUseCase_whenSuccessfullyFetchesTrendingRepos_reposArrayShouldHaveCountEqualToTwentySix_succeeds() {
        // given
        let expectation = self.expectation(description: "Download trending repos")
        expectation.expectedFulfillmentCount = 1
        let mockedTrendingRepository = TrendingRepositoryMock()
        let useCase = FetchTrendingRepositoryUseCase(repository: mockedTrendingRepository)
        var trendingRepos: TrendingRepo?

        // when
        _ = useCase.execute(requestvalue: .init(page: 0), loadFromCache: false) { result in
            trendingRepos = (try? result.get())
            expectation.fulfill()
        }

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(trendingRepos?.totalCount, 2026)
        XCTAssertEqual(trendingRepos?.reposArray.count, 26)
    }
}
