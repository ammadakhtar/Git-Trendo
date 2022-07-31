//
//  GitTrendoUITests.swift
//  Git-TrendoUITests
//
//  Created by Ammad Akhtar on 31/07/2022.
//

import XCTest

class GitTrendoUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testActionButtonState_whenSongIsNotPlaying_whenTapped_thenButtonStateShouldChangeToPaused_passes() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let repoCell = tablesQuery.cells[AccessibilityIdentifier.reopCellIdentifier].firstMatch
        _ = repoCell.waitForExistence(timeout: 20.0)

        XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.ownerLabelIdentifier].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.repoTitleLabelIdentifier].exists)

        if repoCell.exists {
            repoCell.tap()

            let descriptionLabel = repoCell.otherElements[AccessibilityIdentifier.repoDescriptionLabelIdentifier]
            _ = descriptionLabel.waitForExistence(timeout: 5.0)

            XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.repoDescriptionLabelIdentifier].exists)
            XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.repoStarCountLabel].exists)
            XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.repoLanguageLabelIdentifier].exists)
        }
    }
}
