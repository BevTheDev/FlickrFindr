//
//  UIViewController+ViewLifecycle.swift
//  FlickrFindrTests
//
//  Created by Beverly Massengill on 1/20/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func triggerOpeningLifecycle() {
        
        loadView()
        viewDidLoad()
        viewWillAppear(false)
        viewDidAppear(false)
    }
}
