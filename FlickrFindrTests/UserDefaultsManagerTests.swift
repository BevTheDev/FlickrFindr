//
//  UserDefaultsManagerTests.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import XCTest

@testable import FlickrFindr

class UserDefaultsManagerTests: XCTestCase {

    override func setUp() {
        
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.recentsKey)
        UserDefaults.standard.synchronize()
    }

    func testSaveAndGet() {
        
        UserDefaultsManager.saveNewSearchTerm(term: "test1")
        
        let result = UserDefaultsManager.getRecentSearches()
        
        XCTAssertEqual(result, ["test1"])
    }

    func testSaveMultiple() {
        
        UserDefaultsManager.saveNewSearchTerm(term: "test1")
        UserDefaultsManager.saveNewSearchTerm(term: "test2")
        UserDefaultsManager.saveNewSearchTerm(term: "test3")
        
        let result = UserDefaultsManager.getRecentSearches()
        
        XCTAssertEqual(result, ["test1", "test2", "test3"])
    }

    func testSaveHandlesDuplicates() {
        
        UserDefaultsManager.saveNewSearchTerm(term: "test1")
        UserDefaultsManager.saveNewSearchTerm(term: "test2")
        UserDefaultsManager.saveNewSearchTerm(term: "test3")
        UserDefaultsManager.saveNewSearchTerm(term: "test2")
        
        let result = UserDefaultsManager.getRecentSearches()
        
        XCTAssertEqual(result, ["test1", "test3", "test2"])
    }

    func testSaveMax() {
        
        UserDefaultsManager.saveNewSearchTerm(term: "test1")
        UserDefaultsManager.saveNewSearchTerm(term: "test2")
        UserDefaultsManager.saveNewSearchTerm(term: "test3")
        UserDefaultsManager.saveNewSearchTerm(term: "test4")
        UserDefaultsManager.saveNewSearchTerm(term: "test5")
        UserDefaultsManager.saveNewSearchTerm(term: "test6")
        
        let result = UserDefaultsManager.getRecentSearches()
        
        XCTAssertEqual(result, ["test2", "test3", "test4", "test5", "test6"])
    }
}
