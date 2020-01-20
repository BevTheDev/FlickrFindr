//
//  ModelFactory.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/20/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation
import XCTest

@testable import FlickrFindr

class ModelFactory {
    
    static func generatePhoto(withTitle title: String = "Test Title", file: StaticString = #file, line: UInt = #line) -> Photo? {
        
        let photoJson = Data("""
        {
            "id": "123",
            "owner": "ownerId",
            "secret": "secret123",
            "server": "444",
            "farm": 11,
            "title": "\(title)",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0
        }
        """.utf8)
        
        do {
            return try JSONDecoder().decode(Photo.self, from: photoJson)
        }
        catch {
            XCTFail("Photo parsing failed", file: file, line: line)
            return nil
        }
    }
}
