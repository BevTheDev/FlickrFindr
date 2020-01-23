//
//  FullScreenImageTests.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/20/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import XCTest

@testable import FlickrFindr

class FullScreenImageTests: BaseTestCase {

    func testShowsPhoto() {
        
        guard let photo = ModelFactory.generatePhoto() else {
            XCTFail("Could not generate photo")
            return
        }
        
        let testVC = FullScreenImageViewController(withPhoto: photo)
        testVC.triggerOpeningLifecycle()
        
        waitThenContinue(after: 0.3)
        XCTAssertEqual(testVC.titleLabel.text, photo.title)
        XCTAssertFalse(testVC.titleBackdrop.isHidden)
        XCTAssertNotNil(testVC.imageView.image)
    }
    
    func testHidesEmptyTitleBackdrop() {
        
        guard let photo = ModelFactory.generatePhoto(withTitle: "") else {
            XCTFail("Could not generate photo")
            return
        }
        
        let testVC = FullScreenImageViewController(withPhoto: photo)
        testVC.triggerOpeningLifecycle()
        
        XCTAssertTrue(testVC.titleBackdrop.isHidden)
    }
    
    func testShowHideTitle() {
        
        guard let photo = ModelFactory.generatePhoto() else {
            XCTFail("Could not generate photo")
            return
        }
        
        let testVC = FullScreenImageViewController(withPhoto: photo)
        testVC.loadView()
        
        XCTAssertEqual(testVC.titleLabel.alpha, 1)
        XCTAssertEqual(Float(testVC.titleBackdrop.alpha), 0.6)
        
        testVC.didTapImage()
        waitThenContinue(after: 0.6)
        
        XCTAssertEqual(testVC.titleLabel.alpha, 0)
        XCTAssertEqual(testVC.titleBackdrop.alpha, 0)
        
        testVC.didTapImage()
        waitThenContinue(after: 0.6)
        
        XCTAssertEqual(testVC.titleLabel.alpha, 1)
        XCTAssertEqual(Float(testVC.titleBackdrop.alpha), 0.6)
    }
}
