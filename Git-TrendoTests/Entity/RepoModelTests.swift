//
//  RepoModelTests.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import XCTest

final class RepoModelTests: XCTestCase {

    func testRepoModel_forInit_InitializesSuccessfully_succeeds() {
        // Given
        lazy var repos: [Repo] = {
            let repos = MockDataGenerator().mockRepoData()
            return repos
        }()

        // When
        let sut = repos.first // sut: System Under Test

        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.id, 283868754 )
        XCTAssertEqual(sut?.name, "CrazyChickenDev")
        XCTAssertEqual(sut?.description, ":pen::art:A nicer look at my GitHub profile and repository stats with data visualizations of my top languages and stars. Sort through your top repos by number of stars, forks, and size.")
        XCTAssertNil(sut?.language)
        XCTAssertNotNil(sut?.owner)
        XCTAssertEqual(sut?.starsCount, 9)
    }
}
