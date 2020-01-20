//
//  HomeViewControllerTests.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import XCTest

@testable import FlickrFindr

class HomeViewControllerTests: BaseTestCase {
    
    func testInitialPhotoLoad() {
        
        let testVC = MockHomeVC()
        let pageUpdateExpectation = expectation(description: "photoPages property should update")
        testVC.pageUpdateExpectation = pageUpdateExpectation
        
        testVC.triggerOpeningLifecycle()
        
        wait(for: [pageUpdateExpectation], timeout: 1)
        
        XCTAssertEqual(testVC.photoPages.count, 1)
        XCTAssertEqual(testVC.photos.count, 25)
        XCTAssertEqual(testVC.photos.first?.title, "Recent Uploads Page 1 Photo")
        XCTAssertEqual(testVC.showingLabel.text, "Recent Uploads")
    }
    
    func testSearch() {
        
        let testVC = MockHomeVC()
        let pageUpdateExpectation = expectation(description: "photoPages property should update")
        pageUpdateExpectation.expectedFulfillmentCount = 2
        testVC.pageUpdateExpectation = pageUpdateExpectation
        
        testVC.loadView()
        testVC.searchBar.text = "test1"
        testVC.performSearch()
        
        wait(for: [pageUpdateExpectation], timeout: 1)
        
        XCTAssertEqual(testVC.photoPages.count, 1)
        XCTAssertEqual(testVC.photos.count, 9)
        XCTAssertEqual(testVC.photos.first?.title, "Search photo")
        XCTAssertEqual(testVC.showingLabel.text, "Results for: \"test1\"")
    }
    
    func testPaging() {
        
        let testVC = MockHomeVC()
        let pageLoadExpectation = expectation(description: "Wait for first page to load")
        testVC.pageUpdateExpectation = pageLoadExpectation
        
        testVC.triggerOpeningLifecycle()
        
        wait(for: [pageLoadExpectation], timeout: 1)
        
        let nextPageLoadExpectation = expectation(description: "Second page should append")
        testVC.pageUpdateExpectation = nextPageLoadExpectation
        
        _ = testVC.collectionView(testVC.collectionView, cellForItemAt: IndexPath(item: 24, section: 0))
        
        wait(for: [nextPageLoadExpectation], timeout: 1)
        
        XCTAssertEqual(testVC.photoPages.count, 2)
        XCTAssertEqual(testVC.photos.count, 50)
        XCTAssertEqual(testVC.photos[25].title, "Recent Uploads Page 2 Photo")
    }
    
    func testSearchCancelButtonClicked() {
        
        let testVC = MockSearchHomeVC()
        testVC.loadView()
        testVC.searchBar.text = "test1"
        
        let performSearchExpectation = expectation(description: "performSearch should be called")
        testVC.performSearchExpectation = performSearchExpectation
        
        testVC.searchBarCancelButtonClicked(testVC.searchBar)
        
        wait(for: [performSearchExpectation], timeout: 1)
        
        XCTAssertEqual(testVC.searchBar.text, "")
    }
    
    func testSearchButtonClicked() {
        
        let testVC = MockSearchHomeVC()
        testVC.loadView()
        testVC.searchBar.text = "test1"
        
        let performSearchExpectation = expectation(description: "performSearch should be called")
        testVC.performSearchExpectation = performSearchExpectation
        
        testVC.searchBarSearchButtonClicked(testVC.searchBar)
        
        wait(for: [performSearchExpectation], timeout: 1)
        
        XCTAssertEqual(testVC.searchBar.text, "test1")
    }
    
    func testDidSelectSearchTerm() {
        
        let testVC = MockSearchHomeVC()
        testVC.loadView()
        testVC.searchBar.text = ""
        
        let performSearchExpectation = expectation(description: "performSearch should be called")
        testVC.performSearchExpectation = performSearchExpectation
        
        testVC.didSelectSearchTerm(searchTerm: "test1")
        
        wait(for: [performSearchExpectation], timeout: 1)
        
        XCTAssertEqual(testVC.searchBar.text, "test1")
    }
    
    func testClearsOnFailure() {
        
        let testVC = MockHomeVC()
        let pageUpdateExpectation = expectation(description: "photoPages property should update")
        testVC.pageUpdateExpectation = pageUpdateExpectation
        
        testVC.loadView()
        testVC.searchBar.text = "bad request"
        testVC.performSearch()
        
        wait(for: [pageUpdateExpectation], timeout: 1)
        
        XCTAssertEqual(testVC.photoPages.count, 0)
        XCTAssertEqual(testVC.photos.count, 0)
        XCTAssertEqual(testVC.showingLabel.text, "Results for: \"bad request\"")
        
        waitThenContinue(after: 0.1)
        XCTAssertFalse(testVC.noResultsLabel.isHidden)
    }
    
    func testShowsNoResults() {
        
        let testVC = MockHomeVC()
        let pageUpdateExpectation = expectation(description: "photoPages property should update")
        pageUpdateExpectation.expectedFulfillmentCount = 2
        testVC.pageUpdateExpectation = pageUpdateExpectation
        
        testVC.loadView()
        testVC.searchBar.text = "noResults"
        testVC.performSearch()
        
        wait(for: [pageUpdateExpectation], timeout: 1)
        
        XCTAssertEqual(testVC.photoPages.count, 1)
        XCTAssertEqual(testVC.photos.count, 0)
        XCTAssertEqual(testVC.showingLabel.text, "Results for: \"noResults\"")
        
        waitThenContinue(after: 0.1)
        XCTAssertFalse(testVC.noResultsLabel.isHidden)
    }
    
    // MARK: - Mocks
    
    class MockHomeVC: HomeViewController {
        
        var pageUpdateExpectation: XCTestExpectation?
        
        init() {
            super.init(nibName: "HomeViewController", bundle: Bundle.main)
        }
        
        @available(*, deprecated)
        required init?(coder aDecoder: NSCoder) { fatalError() }
        
        override var photoPages: [PhotoPage] {
            didSet {
                pageUpdateExpectation?.fulfill()
            }
        }
    }
    
    class MockSearchHomeVC: MockHomeVC {
        
        var performSearchExpectation: XCTestExpectation?
        
        override func performSearch() {
            performSearchExpectation?.fulfill()
        }
    }
}
