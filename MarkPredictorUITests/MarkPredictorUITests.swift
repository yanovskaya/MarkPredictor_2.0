//
//  MarkPredictorUITests.swift
//  MarkPredictorUITests
//
//  Created by Елена Яновская on 05.05.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import XCTest

class MarkPredictorUITests: XCTestCase {
    
    private var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialStateIsCorrect() {
        let visitLabel = app.staticTexts["Процент посещенных занятий"]
        let testLabel = app.staticTexts["Оценка за контрольную работу"]
        let hwLabel = app.staticTexts["Оценка за домашнюю работу"]
        
        XCTAssertTrue(visitLabel.exists && testLabel.exists && hwLabel.exists)
    }
    
}
