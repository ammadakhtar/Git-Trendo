//
//  TrendingRepositoryTests.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import XCTest

class TrendingRepositoryTests: XCTestCase {
    
    func testFetchTrendingRepositories_whenSuccessfullyFetchesTrendingRepos_reposArrayShouldHaveCountEqualToTwentySix_succeeds() {
        let config = NetworkConfigurableMock()
        let expectation = self.expectation(description: "Download trending repos")
        let bundle = Bundle(for: Self.self)
        let responseData: Data?
        var trendingRepos: TrendingRepo?
        if let url = bundle.url(forResource: "sampleData", withExtension: "json") {
            responseData = try? Data(contentsOf: url)
            let networkService = DefaultNetworkService(config: config, sessionManager: NetworkSessionManagerMock(response: nil,
                                                                                                                 data: responseData,
                                                                                                                 error: nil))
            let sut = DefaultDataTransferService(with: networkService)
            // given
            expectation.expectedFulfillmentCount = 1
            let repository = TrendingRepositories(dataTransferService: sut)

            // when
            _ = repository.fetchTrendingRepositories(page: 0, loadFromCache: false) { result in
                trendingRepos = (try? result.get())
                expectation.fulfill()
            }

            // then
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertEqual(trendingRepos?.totalCount, 2026)
            XCTAssertEqual(trendingRepos?.reposArray.count, 26)
        }
    }
}
