//
//  UserDefaultsManager.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation

extension Constants {
    struct UserDefaults {
        static let recentsKey = "SavedRecentSearches"
        static let maxSaved = 5
    }
}

class UserDefaultsManager {
    
    static func saveNewSearchTerm(term: String) {
        
        var searches = getRecentSearches()
        
        searches.removeAll { savedTerm -> Bool in
            return savedTerm.lowercased() == term.lowercased()
        }
        
        if searches.count >= Constants.UserDefaults.maxSaved {
            searches.removeFirst()
        }
        
        searches.append(term)
        print("Saving: \(searches)")
        
        UserDefaults.standard.set(searches, forKey: Constants.UserDefaults.recentsKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getRecentSearches() -> [String] {
        
        let searches = (UserDefaults.standard.value(forKey: Constants.UserDefaults.recentsKey) as? [String]) ?? []
        print("Loading: \(searches)")
        return searches
    }
}
