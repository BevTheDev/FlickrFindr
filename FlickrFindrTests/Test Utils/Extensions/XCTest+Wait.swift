//
//  XCTest+Wait.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/20/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func waitThenContinue(after timeInterval: TimeInterval) {
        
        let waitExpectation = expectation(description: "Waiting to resume tests.")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            waitExpectation.fulfill()
        }
        
        wait(for: [waitExpectation], timeout: timeInterval + 1)
    }
}
