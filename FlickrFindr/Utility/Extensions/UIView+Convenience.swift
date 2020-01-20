//
//  UIView+Convenience.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinEdges(to otherView: UIView) {
        
        leadingAnchor.constraint(equalTo: otherView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: otherView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: otherView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: otherView.bottomAnchor).isActive = true
    }
    
    func center(in otherView: UIView) {
        
        centerXAnchor.constraint(equalTo: otherView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: otherView.centerYAnchor).isActive = true
    }
}
