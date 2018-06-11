//
//  MarkModelTests.swift
//  MarkModelTests
//
//  Created by Елена Яновская on 02.05.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

@testable import MarkPredictor
import XCTest

final class MarkModelTests: XCTestCase {
    
    private var markModel: MarkModelWrapper!
    
    override func setUp() {
        super.setUp()
        markModel = MarkModelWrapper()
    }
    
    override func tearDown() {
        markModel = nil
        super.tearDown()
    }
    
    func testExamMarkIsValidNumber() {
        let visits = Int(arc4random_uniform(100))
        let homework = Int(arc4random_uniform(10))
        let test = Int(arc4random_uniform(10))
        let mark = markModel.predictMark(visits: visits, homework: homework, test: test)
        XCTAssertTrue(mark > 0 && mark < 11)
    }
    
}
