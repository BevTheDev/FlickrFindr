//
//  FullScreenImageViewController.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/18/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let photo: Photo
    
    // MARK: - Init
    
    init(withPhoto photo: Photo) {
        
        self.photo = photo
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, deprecated)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        titleLabel.text = photo.title
        
        let imageUrl = photo.imageUrl(forSize: .fullscreen)
        
        WebService.getPhotoImage(fromUrlString: imageUrl) { [weak self] response in
            
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
    
    // MARK: - IBActions
    
    @IBAction func closeTapped() {
        
        dismiss(animated: true, completion: nil)
    }
}
