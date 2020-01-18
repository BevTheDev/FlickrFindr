//
//  Photo.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

class PhotosResponse: Decodable {
    
    let photoPage: PhotoPage
    
    private enum CodingKeys : String, CodingKey {
        case photoPage = "photos"
    }
}

class PhotoPage: Decodable {
    
    let pageNumber: Int
    let photos: [Photo]
    
    private enum CodingKeys : String, CodingKey {
        case pageNumber = "page"
        case photos = "photo"
    }
}

class Photo: Decodable {
    
    let id: String
    let title: String
    let farm: Int
    let secret: String
    let server: String
    
    enum PhotoSize: String {
        case fullscreen = "z"
        case thumbnail = "t"
    }
    
    func imageUrl(forSize size: PhotoSize) -> String {
        //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{o-secret}_o.(jpg|gif|png)
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size.rawValue).png"
    }
}
