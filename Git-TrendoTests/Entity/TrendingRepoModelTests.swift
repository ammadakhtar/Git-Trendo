//
//  TrendingRepoModelTests.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import XCTest

final class TrendingRepoModelTests: XCTestCase {

    func testTrendingRepoModel_forInit_InitializesSuccessfully_succeeds() {
        // Given
        lazy var trendingRepos: TrendingRepo? = {
            let data = MockDataGenerator().mockTrendingRepoData()
            return data
        }()

        // When
        let sut = trendingRepos // sut: System Under Test

        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.totalCount, 2026 )
        XCTAssertEqual(sut?.reposArray.count, 26)
    }
}
