//
//  Photo.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

enum PhotoSize: String {
    
    case fullscreen = "z"
    case thumbnail = "q"
}

class Photo: Decodable {
    
    let id: String
    let title: String
    let farm: Int
    let secret: String
    let server: String
    
    func imageUrl(forSize size: PhotoSize) -> String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size.rawValue).jpg"
    }
}
