//
//  UIImageView+ImageLoading.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/18/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadWebImage(fromUrl url: String, completion: (() -> Void)? = nil) {
        
        WebService.getPhotoImage(fromUrlString: url) { [weak self] response in
            
            guard let self = self else {
                return
            }
            
            guard case .success(let image) = response else {
                
                print("Image load failed")

                DispatchQueue.main.async {
                    self.image = nil
                    completion?()
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
                completion?()
            }
        }
    }
}
