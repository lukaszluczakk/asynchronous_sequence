//
//  AsynchronousSequenceUITests.swift
//  AsynchronousSequenceUITests
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import XCTest

class AsynchronousSequenceUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    func test_buildAppButton_ShouldGenerateBuildViewInformation() throws {
        app.buttons["BuildAppButton"].tap()
        let text = app.staticTexts.matching(identifier: "BuildInformationView_Text").firstMatch
        XCTAssertTrue(text.waitForExistence(timeout: 5))
    }
}
