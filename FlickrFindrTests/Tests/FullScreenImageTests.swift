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
        XCTAssertNotNil(testVC.imageView.image)
    }
}
