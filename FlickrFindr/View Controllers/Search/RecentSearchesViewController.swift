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
    }
}

class RecentSearchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: RecentSearchDelegate?
    var recentSearches: [String] = ["Nature"]
    
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }

    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return Constants.RecentSearches.sectionHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        cell.textLabel?.text = recentSearches[indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.didSelectSearchTerm(searchTerm: recentSearches[indexPath.row])
    }
}
