//
//  HomeViewController.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/17/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit
import Foundation

extension Constants {
    
    struct HomeScreen {
        
        static let showingRecent = "Recent Uploads"
        static let showingResults = "Results for: "
    }
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, RecentSearchDelegate, SpinnerShowable {
    
    // MARK: - Properties
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var showingLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    var spinnerView = SpinnerView()
    lazy var recentSearchVC = RecentSearchesViewController(delegate: self)
    
    var photoPages: [PhotoPage] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var photos: [Photo] {
        
        return photoPages.flatMap { return $0.photos }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: ThumbnailCell.nibName, bundle: Bundle.main), forCellWithReuseIdentifier: ThumbnailCell.nibName)
        
        stackView.setCustomSpacing(10, after: showingLabel)
        
        loadPhotos()
    }
    
    // MARK: - Photo Loading
    
    func loadPhotos(forSearchTerm searchTerm: String? = nil, page: Int = 1) {
        
        if page == 1 {
            showActivitySpinner(fromView: view)
        }
        
        let photoPageUrl: String
        
        if let searchTerm = searchTerm, !searchTerm.isEmpty {
            
            photoPageUrl = PhotoPage.searchUrl(forSearchTerm: searchTerm, pageNum: page)
            showingLabel.text = Constants.HomeScreen.showingResults + "\"\(searchTerm)\""
        }
        else {
            
            photoPageUrl = PhotoPage.recentsUrl(pageNum: page)
            showingLabel.text = Constants.HomeScreen.showingRecent
        }
        
        WebService.getPhotoPage(forUrl: photoPageUrl) { response in
            
            defer {
                DispatchQueue.main.async {
                    self.noResultsLabel.isHidden = !self.photos.isEmpty
                    self.hideActivitySpinner()
                }
            }
            
            guard case .success(let responsePhotoPage) = response else {
                
                print("Failed to load photo page")
                return
            }
            
            self.photoPages.append(responsePhotoPage)
        }
    }
    
    func loadNextPage() {
        
        guard let currentPage = photoPages.last,
            currentPage.pageNumber < currentPage.totalPages else {
                return
        }
        
        loadPhotos(forSearchTerm: searchBar.text, page: currentPage.pageNumber + 1)
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == photos.count - 1 {
            loadNextPage()
        }
        
        let cell: ThumbnailCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.nibName, for: indexPath) as? ThumbnailCell ?? ThumbnailCell()
        
        let photo = photos[indexPath.row]
        let title = photo.title
        let thumbUrl = photo.imageUrl(forSize: .thumbnail)
        
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
        
        let photo = photos[indexPath.row]
        
        let fullScreenViewer = FullScreenImageViewController(withPhoto: photo)
        fullScreenViewer.modalPresentationStyle = .fullScreen
        
        present(fullScreenViewer, animated: true, completion: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Search
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        addChild(recentSearchVC)
        recentSearchVC.beginAppearanceTransition(true, animated: false)
        stackView.insertArrangedSubview(recentSearchVC.view, at: 0)
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        stackView.removeArrangedSubview(recentSearchVC.view)
        recentSearchVC.endAppearanceTransition()
        recentSearchVC.removeFromParent()
        
        return true
    }
    
    // MARK: Search Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        performSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        performSearch()
    }
    
    func didSelectSearchTerm(searchTerm: String) {
        
        searchBar.text = searchTerm
        performSearch()
    }
    
    // MARK: Search Logic
    
    func performSearch() {
        
        photoPages = []
        searchBar.resignFirstResponder()
        
        loadPhotos(forSearchTerm: searchBar.text)
        
        if let searchTerm = searchBar.text, !searchTerm.isEmpty {
            
            UserDefaultsManager.saveNewSearchTerm(term: searchTerm)
            
            // Keep the cancel button enabled during search mode
            searchBar.setCancelEnabled(true)
        }
        else {
            searchBar.setCancelEnabled(false)
        }
    }
}
