//
//  PhotosResponse.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

class PhotosResponse: Decodable {
    
    let photoPage: PhotoPage
    
    private enum CodingKeys : String, CodingKey {
        case photoPage = "photos"
    }
}
