//
//  Photo.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

// MARK: - Enums

enum PageType: String {
    case recentPhotos = "flickr.photos.getRecent"
    case search = "flickr.photos.search"
}

enum PhotoSize: String {
    case fullscreen = "z"
    case thumbnail = "q"
}

// MARK: - Decodable Photo Models

class PhotosResponse: Decodable {
    
    let photoPage: PhotoPage
    
    private enum CodingKeys : String, CodingKey {
        case photoPage = "photos"
    }
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

class Photo: Decodable {
    
    let id: String
    let title: String
    let farm: Int
    let secret: String
    let server: String
    
    func imageUrl(forSize size: PhotoSize) -> String {
        //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{o-secret}_o.(jpg|gif|png)
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size.rawValue).png"
    }
}
