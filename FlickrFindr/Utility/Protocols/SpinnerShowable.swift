//
//  SpinnerShowable.swift
//  FlickrFindr
//
//  Created by Beverly Massengill on 1/19/20.
//  Copyright © 2020 BevTheDev. All rights reserved.
//

import UIKit

protocol SpinnerShowable {
    
    var spinnerView: SpinnerView { get set }
}

extension SpinnerShowable where Self: UIViewController {
    
    func showActivitySpinner(fromView: UIView) {
        
        fromView.addSubview(spinnerView)
        spinnerView.pinEdges(to: fromView)
    }
    
    func hideActivitySpinner() {
        
        spinnerView.removeFromSuperview()
    }
}
