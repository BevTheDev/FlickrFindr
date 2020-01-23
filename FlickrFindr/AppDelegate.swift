//
//  AppDelegate.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // The HomeVC will display a paged list of recent uploads. This works without the
        // stub, but occasionally returns some... rather awkward results :/
        // So this replaces the real network response with two pages of demo-safe images.
        // Only applies to the flickr.photos.getRecent method. flickr.photos.search provides
        // a safe option, so it uses real network responses.
        stubRecentUploads()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func stubRecentUploads() {
        
        NetworkMocker.stubRecentUploadsRequest(withPageNum: 1, responseTime: 0.5)
        NetworkMocker.stubRecentUploadsRequest(withPageNum: 2, responseTime: 0.5)
    }
}

