//
//  HomeViewController.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadRecentPhotos()
    }
    
    // MARK: - Photo Loading
    
    func loadRecentPhotos() {
        
        WebService.getPhotoPage() { response in
            
            guard case .success(let responsePhotoPage) = response else {
                
                print("Failed to load photo page")
                return
            }
            
            print(responsePhotoPage.photos.count)
            print(responsePhotoPage.photos.first?.title)
            print(responsePhotoPage.photos.first?.id)
        }
    }
}
