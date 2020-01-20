//
//  PhotoPageTests.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/20/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import XCTest

@testable import FlickrFindr

class PhotoPageTests: BaseTestCase {

    func testRecentUploadsUrlGeneration() {
        
        let page1Url = PhotoPage.recentsUrl(pageNum: 1)
        XCTAssertEqual(page1Url, "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1508443e49213ff84d566777dc211f2a&per_page=25&page=1&format=json&nojsoncallback=1")
        
        let page2Url = PhotoPage.recentsUrl(pageNum: 2)
        XCTAssertEqual(page2Url, "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1508443e49213ff84d566777dc211f2a&per_page=25&page=2&format=json&nojsoncallback=1")
    }

    func testSearchUrlGeneration() {
        
        let page1Url = PhotoPage.searchUrl(forSearchTerm: "test1", pageNum: 1)
        XCTAssertEqual(page1Url, "https://www.flickr.com/services/rest/?method=flickr.photos.search&text=test1&api_key=1508443e49213ff84d566777dc211f2a&per_page=25&page=1&format=json&nojsoncallback=1")
        
        let page2Url = PhotoPage.searchUrl(forSearchTerm: "test1", pageNum: 2)
        XCTAssertEqual(page2Url, "https://www.flickr.com/services/rest/?method=flickr.photos.search&text=test1&api_key=1508443e49213ff84d566777dc211f2a&per_page=25&page=2&format=json&nojsoncallback=1")
        
        let paramEncodedUrl = PhotoPage.searchUrl(forSearchTerm: "term with spaces", pageNum: 1)
        XCTAssertEqual(paramEncodedUrl, "https://www.flickr.com/services/rest/?method=flickr.photos.search&text=term%20with%20spaces&api_key=1508443e49213ff84d566777dc211f2a&per_page=25&page=1&format=json&nojsoncallback=1")
    }
}
