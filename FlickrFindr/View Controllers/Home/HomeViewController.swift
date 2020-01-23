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
                if self.photos.isEmpty {
                    self.collectionView.reloadData()
                }
                else {
                    let totalPhotos = self.photos.count
                    let lastPagePhotos = self.photoPages.last?.photos.count ?? 0
                    
                    let startIndex = totalPhotos - lastPagePhotos
                    let endIndex = totalPhotos - 1
                    
                    let indexPaths = Array(startIndex...endIndex).map { IndexPath(item: $0, section: 0) }
                    self.collectionView.insertItems(at: indexPaths)
                }
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
    
    // MARK: CollectionView Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewPadding: CGFloat = 20

        let collectionViewPortraitWidth: CGFloat = min(view.frame.width, view.frame.height) - collectionViewPadding
        
        let numColumns: CGFloat = floor(collectionViewPortraitWidth / 150)
        let cellPadding: CGFloat = 10 * (numColumns - 1)

        let itemSize = (collectionViewPortraitWidth - cellPadding) / numColumns

        return CGSize(width: itemSize, height: itemSize)
    }
    
    // MARK: CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photo = photos[indexPath.row]
        
        let fullScreenViewer = FullScreenImageViewController(withPhoto: photo)
        fullScreenViewer.modalPresentationStyle = .fullScreen
        
        present(fullScreenViewer, animated: true, completion: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        searchBar.resignFirstResponder()
        updateCancelButtonStatus()
    }
    
    // MARK: - Search
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        addChild(recentSearchVC)
        stackView.insertArrangedSubview(recentSearchVC.view, at: 0)
        recentSearchVC.beginAppearanceTransition(true, animated: false)
        stackView.layoutIfNeeded()
        
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
    }
    
    // MARK: Search Logic
    
    func performSearch() {
        
        photoPages = []
        searchBar.resignFirstResponder()
        updateCancelButtonStatus()
        
        loadPhotos(forSearchTerm: searchBar.text)
        
        if let searchTerm = searchBar.text, !searchTerm.isEmpty {
            
            UserDefaultsManager.saveNewSearchTerm(term: searchTerm)
        }
    }
    
    // MARK: - Helpers
    
    func updateCancelButtonStatus() {
        
        if let searchTerm = searchBar.text, !searchTerm.isEmpty {
            // Keep the cancel button enabled during search mode
            searchBar.setCancelEnabled(true)
        }
        else {
            searchBar.setCancelEnabled(false)
        }
    }
}
