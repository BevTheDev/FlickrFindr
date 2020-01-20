//
//  NetworkMocker+Photos.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import OHHTTPStubs

extension NetworkMocker {
    
    static func stubRecentUploadsRequest(withPageNum page: Int) {
        
        stub(forPath: "/services/rest",
             query: "method=flickr.photos.getRecent&api_key=1508443e49213ff84d566777dc211f2a&per_page=25&page=\(page)&format=json&nojsoncallback=1",
             responseFileName: "recent_uploads_page\(page)_success.json")
    }
    
    static func stubSearchRequest() {
        
        stub(forPath: "/services/rest",
        query: "method=flickr.photos.search&text=test1&api_key=1508443e49213ff84d566777dc211f2a&per_page=25&page=1&format=json&nojsoncallback=1",
        responseFileName: "search_success.json")
    }
    
    static func stubSearchRequestWithNoResults() {
        
        stub(forPath: "/services/rest",
        query: "method=flickr.photos.search&text=noResults&api_key=1508443e49213ff84d566777dc211f2a&per_page=25&page=1&format=json&nojsoncallback=1",
        responseFileName: "no_results.json")
    }
}
