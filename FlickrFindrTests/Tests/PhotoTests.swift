//
//  PhotoTests.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/20/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import XCTest

@testable import FlickrFindr

class PhotoTests: BaseTestCase {

    func testUrlGeneration() {
        
        guard let photo = ModelFactory.generatePhoto() else {
            XCTFail("Failed to generate photo")
            return
        }
        
        let thumbUrl = photo.imageUrl(forSize: .thumbnail)
        XCTAssertEqual(thumbUrl, "https://farm11.staticflickr.com/444/123_secret123_q.jpg")
        
        let fullscreenUrl = photo.imageUrl(forSize: .fullscreen)
        XCTAssertEqual(fullscreenUrl, "https://farm11.staticflickr.com/444/123_secret123_z.jpg")
    }
}
