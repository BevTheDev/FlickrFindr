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
    @IBOutlet weak var titleBackdrop: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var unavailableLabel: UILabel!
    
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
    
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
        
        setUpUI()
        addTitleShadow()
        unavailableLabel.isHidden = true
        
        titleLabel.text = photo.title
        titleBackdrop.isHidden = photo.title.isEmpty
        
        loadImage(forPhoto: photo)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    func addTitleShadow() {
        
        titleBackdrop.layer.masksToBounds = false
        titleBackdrop.layer.shadowOffset = CGSize(width: 0, height: -5)
        titleBackdrop.layer.shadowRadius = 3
        titleBackdrop.layer.shadowOpacity = 1
    }
    
    func loadImage(forPhoto photo: Photo) {
        
        let imageUrl = photo.imageUrl(forSize: .fullscreen)
        
        showActivitySpinner(fromView: imageView)
        
        print("Loading fullscreen image: \(imageUrl)")
        imageView.loadWebImage(fromUrl: imageUrl) { success in
            
            self.hideActivitySpinner()
            
            if !success {
                self.unavailableLabel.isHidden = false
            }
        }
    }
    
    // MARK: - Rotation Handling
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        setUpUI()
    }
    
    func setUpUI() {
        
        if UIDevice.current.orientation.isPortrait {
            
            imageTopConstraint.constant = 134
            imageBottomConstraint.constant = 90
            imageLeadingConstraint.constant = 0
            imageTrailingConstraint.constant = 0
        }
        else {
            
            imageTopConstraint.constant = 0
            imageBottomConstraint.constant = 0
            imageLeadingConstraint.constant = 55
            imageTrailingConstraint.constant = 55
        }
        
        view.layoutIfNeeded()
    }
    
    // MARK: - IBActions
    
    @IBAction func closeTapped() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapImage() {
        
        let newTitleAlpha: CGFloat =  self.titleLabel.alpha == 0 ? 1 : 0
        let newBackdropAlpha: CGFloat =  self.titleBackdrop.alpha == 0 ? 0.6 : 0
        
        UIView.animate(withDuration: 0.5) {
            
            self.titleLabel.alpha = newTitleAlpha
            self.titleBackdrop.alpha = newBackdropAlpha
        }
    }
}
