//
//  HomeViewController.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit
import Foundation

typealias CollectionHandler = UICollectionViewDataSource & UICollectionViewDelegate

class HomeViewController: UIViewController, CollectionHandler, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photoPage: PhotoPage? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: ThumbnailCell.nibName, bundle: Bundle.main), forCellWithReuseIdentifier: ThumbnailCell.nibName)
        
        loadRecentPhotos()
    }
    
    // MARK: - Photo Loading
    
    func loadRecentPhotos() {
        
        WebService.getPhotoPage() { response in
            
            guard case .success(let responsePhotoPage) = response else {
                
                print("Failed to load photo page")
                self.photoPage = nil
                return
            }
            
            self.photoPage = responsePhotoPage
        }
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoPage?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ThumbnailCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.nibName, for: indexPath) as? ThumbnailCell ?? ThumbnailCell()
        
        let photo = photoPage?.photos[indexPath.row]
        let title = photo?.title ?? ""
        let thumbUrl = photo?.imageUrl(forSize: .thumbnail) ?? ""
        
        cell.setUp(withTitle: title, thumbUrl: thumbUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding = CGFloat(10)
        let numColumns = CGFloat(2)

        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + padding)) / numColumns

        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let photo = photoPage?.photos[indexPath.row] else {
            return
        }
        
        let fullScreenViewer = FullScreenImageViewController(withPhoto: photo)
        fullScreenViewer.modalPresentationStyle = .fullScreen
        
        present(fullScreenViewer, animated: true, completion: nil)
    }
}
