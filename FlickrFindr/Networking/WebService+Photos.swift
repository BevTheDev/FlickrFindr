//
//  WebService+Photos.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation
import UIKit

extension WebService {
    
    static func getPhotoPage(completion: @escaping (WebResponse<PhotoPage>) -> Void) {
        
        let urlString = WebService.urlString(forMethod: .recentPhotos)
        
        print("Sending request: \(urlString)")
        
        WebService.sendRequest(urlString: urlString, method: .get) { response in
            
            switch response {
            case .success(let data):
                do {
                    let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
                    completion(.success(photosResponse.photoPage))
                }
                catch {
                    completion(.failure("Parse error"))
                }
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    static func getPhotoImage(fromUrlString urlString: String, completion: @escaping (WebResponse<UIImage>) -> Void) {
        
        WebService.sendRequest(urlString: urlString, method: .get) { response in
            
            switch response {
            case .success(let data):
                
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
                else {
                    completion(.failure("Failed to retrieve image"))
                }
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
}
