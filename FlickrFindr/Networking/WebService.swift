//
//  WebService.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

enum WebResponse<T> {
    case success(T)
    case failure(String)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class WebService {
    
    // MARK: - Standard Request Function
    
    static func sendRequest(urlString: String, method: HTTPMethod, completion: @escaping (WebResponse<Data>) -> Void) {
    
        guard let url = URL(string: urlString) else {
            
            print("Error: rejecting bad url")
            completion(.failure("Bad URL"))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, _, error) in
            
            print("Request complete")
            
            if let error = error {
                
                print("Error: received response error: \(error.localizedDescription)")
                completion(.failure(error.localizedDescription))
                return
            }
            
            guard let data = data else {
                
                print("Error: response contained no data")
                completion(.failure("No data returned"))
                return
            }
            
            print("Received success response")
            completion(.success(data))
        }
        
        task.resume()
    }
}
