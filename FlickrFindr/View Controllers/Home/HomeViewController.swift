//
//  HomeViewController.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
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
            
            if let photo = responsePhotoPage.photos.first {
                
                let fullImageUrl = photo.imageUrl(forSize: .fullscreen)
                let thumbUrl = photo.imageUrl(forSize: .thumbnail)
                
                WebService.getPhotoImage(fromUrlString: fullImageUrl) { response in
                    
                    guard case .success(let image) = response else {
                        
                        print("Image load failed")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
                
                WebService.getPhotoImage(fromUrlString: thumbUrl) { response in
                    
                    guard case .success(let image) = response else {
                        
                        print("Image load failed")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = image
                    }
                }
            }
        }
    }
}
