//
//  UISearchBar+Convenience.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func setCancelEnabled(_ enabled: Bool) {
        
        guard let cancelButton = value(forKey: "cancelButton") as? UIButton else {
            return
        }
        
        cancelButton.isEnabled = enabled
    }
}
