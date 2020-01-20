//
//  FullScreenImageViewController.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/18/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController, SpinnerShowable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let photo: Photo
    var spinnerView = SpinnerView()
    
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
        
        showActivitySpinner(fromView: imageView)
        
        print("Fullscreen: \(imageUrl)")
        imageView.loadWebImage(fromUrl: imageUrl) {
            self.hideActivitySpinner()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func closeTapped() {
        
        dismiss(animated: true, completion: nil)
    }
}
