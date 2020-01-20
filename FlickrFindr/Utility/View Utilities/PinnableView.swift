//
//  PinnableView.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

class PinnableView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, deprecated)
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
