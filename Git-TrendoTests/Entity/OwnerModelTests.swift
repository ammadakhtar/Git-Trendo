//
//  OwnerModelTests.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import XCTest

final class OwnerModelTests: XCTestCase {

    func testOwnerModel_forInit_InitializesSuccessfully_succeeds() {
        // Given
        lazy var repos: [Repo] = {
            let repos = MockDataGenerator().mockRepoData()
            return repos
        }()

        // When
        let sut = repos.first?.owner // sut: System Under Test

        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.id, 38485110 )
        XCTAssertEqual(sut?.login, "CrazyChickenDev")
        XCTAssertEqual(sut?.avatarUrl, "https://avatars.githubusercontent.com/u/38485110?v=4")
    }
}
