//
//  WebService+Photos.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

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
}
