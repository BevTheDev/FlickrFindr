//
//  SpinnerView.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import Foundation
import UIKit

class SpinnerView: PinnableView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addBackdrop()
        addSpinner()
    }
    
    @available(*, deprecated)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - UI Setup
    
    func addBackdrop() {
        
        let backDropView = PinnableView(frame: bounds)
        backDropView.backgroundColor = .black
        backDropView.alpha = 0.4
        
        addSubview(backDropView)
        
        backDropView.pinEdges(to: self)
    }
    
    func addSpinner() {
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        
        addSubview(spinner)
        
        spinner.center(in: self)
        spinner.startAnimating()
    }
}
