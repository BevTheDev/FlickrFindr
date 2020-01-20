//
//  BaseTestCase.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import XCTest

@testable import FlickrFindr

class BaseTestCase: XCTestCase {

    // MARK: - SetUp / TearDown

    override func setUp() {
        
        super.setUp()
        
        NetworkMocker.addDefaultStubs()
    }
    
    override func tearDown() {
        
        NetworkMocker.removeAllStubs()
        
        super.tearDown()
    }
}
