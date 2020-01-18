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
    
//    farm = 66;
//    id = 49401721457;
//    isfamily = 0;
//    isfriend = 0;
//    ispublic = 1;
//    owner = "54718757@N00";
//    secret = 22b7c0b519;
//    server = 65535;
//    title = "IMG_20200117_103331";
    
}
