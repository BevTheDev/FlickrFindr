//
//  RecentSearchesViewControllerTests.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/20/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import XCTest

@testable import FlickrFindr

class RecentSearchesViewControllerTests: BaseTestCase {
    
    override func setUp() {
        
        super.setUp()
        
        let recents = ["test1", "test2", "test3"]
        UserDefaults.standard.set(recents, forKey: Constants.UserDefaults.recentsKey)
        UserDefaults.standard.synchronize()
    }

    func testRecentSearchesDisplay() {
        
        let homeView = HomeViewController()
        let testVC = homeView.recentSearchVC
        homeView.triggerOpeningLifecycle()
        
        _ = homeView.searchBarShouldBeginEditing(homeView.searchBar)
        
        homeView.view.layoutIfNeeded()
        waitThenContinue(after: 0.1)
        
        XCTAssertEqual(testVC.recentSearches, ["test3", "test2", "test1"])
        XCTAssertTrue(testVC.view.frame.height > 0)
    }

    func testRecentSearchesHideWhenEmpty() {
        
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.recentsKey)
        UserDefaults.standard.synchronize()
        
        let homeView = HomeViewController()
        let testVC = homeView.recentSearchVC
        homeView.triggerOpeningLifecycle()
        
        _ = homeView.searchBarShouldBeginEditing(homeView.searchBar)
        
        homeView.view.layoutIfNeeded()
        waitThenContinue(after: 0.1)
        
        XCTAssertEqual(testVC.recentSearches, [])
        XCTAssertEqual(testVC.view.frame.height, 0)
    }
    
    func testTermSelection() {
        
        let callbackExpectation = expectation(description: "Callback should be hit")
        let expectedTerm = "test2"
        
        let searchDelegate = MockRecentSearchDelegate(expectedTerm: expectedTerm, callbackExpectation: callbackExpectation)
        let testVC = RecentSearchesViewController(delegate: searchDelegate)
        testVC.triggerOpeningLifecycle()
        
        testVC.tableView(testVC.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        
        wait(for: [callbackExpectation], timeout: 1)
    }
    
    // MARK: - Mocks
    
    class MockRecentSearchDelegate: RecentSearchDelegate {
        
        var callbackExpectation: XCTestExpectation
        var expectedTerm: String
        
        init(expectedTerm: String, callbackExpectation: XCTestExpectation) {
            self.callbackExpectation = callbackExpectation
            self.expectedTerm = expectedTerm
        }
        
        func didSelectSearchTerm(searchTerm: String) {
            
            if expectedTerm == searchTerm {
                callbackExpectation.fulfill()
            }
        }
    }
}
