//
//  RequestSignature.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

@testable import FlickrFindr

// MARK: - Request/Response Signatures

struct RequestSignature: Equatable {

    let path: String
    let method: HTTPMethod
    let query: String
    
    init(path: String, method: HTTPMethod, query: String) {
        
        self.path = path
        self.method = method
        self.query = query
    }
    
    init(request: URLRequest) {
        
        let path = request.url?.path ?? ""
        let method = HTTPMethod(rawValue: request.httpMethod ?? "") ?? .get
        let query = request.url?.query ?? ""
        
        self.init(path: path, method: method, query: query)
    }
    
    static func == (lhs: RequestSignature, rhs: RequestSignature) -> Bool {
        
        return lhs.path == rhs.path
            && lhs.method == rhs.method
            && lhs.query == rhs.query
    }
}
