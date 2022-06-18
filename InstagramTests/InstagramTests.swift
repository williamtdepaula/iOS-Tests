//
//  InstagramTests.swift
//  InstagramTests
//
//  Created by William Tristão de Pauloa on 18/06/22.
//

import XCTest
@testable import Instagram

class InstagramTests: XCTestCase {

    func testFeedViewModel() throws {
        let viewModel = FeedViewModel()
        let indexPath = IndexPath(row: 0, section: 0)
        
        viewModel.clickedToLikeFeed(indexPath: indexPath)
        XCTAssertTrue(viewModel.feeds[indexPath.row].liked)
        
        viewModel.clickedToLikeFeed(indexPath: indexPath)
        XCTAssertFalse(viewModel.feeds[indexPath.row].liked)
    }

}
