//
//  InstagramUITests.swift
//  InstagramUITests
//
//  Created by William Tristão de Pauloa on 18/06/22.
//

import XCTest
import Instagram

class InstagramUITests: XCTestCase {

    func testLikeButton() throws {
        let app = XCUIApplication()
        app.launch()
        
        let table = app.tables["table_feed"]

        let firstFeedButtonReact = table.buttons["button_react"].firstMatch
        
        firstFeedButtonReact.tap()
        
        let likedButton = table.cells.allElementsBoundByIndex[0].buttons["GOSTEI"]
        
        XCTAssertTrue(likedButton.exists)
    }
    
    func testScrollSlider() throws {
        let app = XCUIApplication()
        app.launch()
        
        let table = app.tables.allElementsBoundByIndex[0]
        let firstCell = table.cells.allElementsBoundByIndex[0]
        
        firstCell.swipeLeft()
        
        XCTAssertTrue(app.images["post3"].exists)
        
    }
}
