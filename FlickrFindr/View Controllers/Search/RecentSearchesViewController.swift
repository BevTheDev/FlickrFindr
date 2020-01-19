//
//  RecentSearchesViewController.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

protocol RecentSearchDelegate: class {
    
    func didSelectSearchTerm(searchTerm: String)
}

extension Constants {
    
    struct RecentSearches {
        
        static let sectionHeader = "Recent Searches"
        static let cellReuseId = "SearchCell"
    }
}

class RecentSearchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: RecentSearchDelegate?
    var recentSearches: [String] = []
    
    // MARK: - Init
    
    init(delegate: RecentSearchDelegate) {
        
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, deprecated)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.RecentSearches.cellReuseId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        recentSearches = UserDefaultsManager.getRecentSearches().reversed()
        tableView.reloadData()
        
        if recentSearches.isEmpty {
            view.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        else {
            view.heightAnchor.constraint(equalToConstant: tableView.contentSize.height + 10).isActive = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }

    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return Constants.RecentSearches.sectionHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.RecentSearches.cellReuseId) ?? UITableViewCell()
        
        cell.textLabel?.text = recentSearches[indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.didSelectSearchTerm(searchTerm: recentSearches[indexPath.row])
    }
}
