//
//  ThumbnailCell.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/18/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let nibName = "ThumbnailCell"
    
    // MARK: - Cell Setup
    
    func setUp(withTitle title: String, thumbUrl: String) {
        
        titleLabel.text = title
        
        WebService.getPhotoImage(fromUrlString: thumbUrl) { [weak self] response in
            
            guard let self = self else {
                return
            }
            
            guard case .success(let image) = response else {
                
                print("Image load failed")
                self.imageView.image = nil
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
