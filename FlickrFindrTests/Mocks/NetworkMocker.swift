//
//  NetworkMocker.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import OHHTTPStubs

@testable import FlickrFindr

class NetworkMocker {
    
    // MARK: - Add/Remove All Stubs
    
    static func stubAllRequestsWithFailure() {
        let stubAllBlock: HTTPStubsTestBlock = { _ -> Bool in
            return true
        }
        
        let standardResponseBlock: HTTPStubsResponseBlock = { _ -> HTTPStubsResponse in
             return HTTPStubsResponse(jsonObject: ["stub": "This request has been stubbed"], statusCode: 500, headers: nil)
        }
        
        HTTPStubs.stubRequests(passingTest: stubAllBlock, withStubResponse: standardResponseBlock)
    }
    
    static func removeAllStubs() {
        
        HTTPStubs.removeAllStubs()
    }
    
    // MARK: - Default Stubs
    
    static func addDefaultStubs() {
        
        stubAllRequestsWithFailure()

        stubRecentUploadsRequest(withPageNum: 1)
        stubRecentUploadsRequest(withPageNum: 2)
        stubSearchRequest()
        stubSearchRequestWithNoResults()
        stubFullScreenImageRequest()
    }
    
    // MARK: - Stubs
    
    static func stub(
        forPath path: String,
        query: String? = nil,
        httpMethod: HTTPMethod = .get,
        responseFileName: String,
        responseStatus: Int = 200,
        responseTime: TimeInterval = 0
        ) {
        
        let stubSignature = RequestSignature(path: path, method: httpMethod, query: query)
        
        let testBlock = compareRequestSignatures(stubSignature)
        
        let responseStub: HTTPStubsResponseBlock = { _ in
            
            let response = HTTPStubsResponse(
                fileAtPath: attemptToGetFilePath(withFilename: responseFileName),
                statusCode: Int32(responseStatus),
                headers: [:]
            )
            
            response.responseTime = responseTime
            return response
        }
        
        HTTPStubs.stubRequests(passingTest: testBlock, withStubResponse: responseStub)
    }
    
    // MARK: - Helpers
    
    static private func attemptToGetFilePath(withFilename filename: String) -> String {
        
        guard let filePath = OHPathForFileInBundle(filename, Bundle(for: self)) else {
            fatalError("File with filename not found: \(filename)")
        }
        
        return filePath
    }
    
    static private func compareRequestSignatures(_ stubSignature: RequestSignature) -> HTTPStubsTestBlock {
        
        return { request in
            
            let requestSignature = RequestSignature(request: request)
            
            return requestSignature == stubSignature
        }
    }
}
