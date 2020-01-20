//
//  PhotoPage.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

enum PageType: String {
    
    case recentPhotos = "flickr.photos.getRecent"
    case search = "flickr.photos.search"
}

class PhotoPage: Decodable {
    
    let pageNumber: Int
    let totalPages: Int
    let photos: [Photo]
    
    private enum CodingKeys : String, CodingKey {
        case pageNumber = "page"
        case photos = "photo"
        case totalPages = "pages"
    }
    
    static func searchUrl(forSearchTerm searchTerm: String, pageNum: Int) -> String {

        let searchParam = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let method = "\(PageType.search.rawValue)&text=\(searchParam)"
        return pageUrl(withMethodParams: method, pageNum: pageNum)
    }
    
    static func recentsUrl(pageNum: Int) -> String {

        let method = PageType.recentPhotos.rawValue
        return pageUrl(withMethodParams: method, pageNum: pageNum)
    }
    
    private static func pageUrl(withMethodParams params: String, pageNum: Int) -> String {
        
        typealias Keys = Constants.Networking

        return "\(Keys.baseUrl)"
            + "?method=\(params)"
            + "&api_key=\(Keys.apiKey)"
            + "&per_page=\(Keys.maxPerPage)"
            + "&page=\(pageNum)"
            + "&format=json"
            + "&nojsoncallback=1"
    }
}
