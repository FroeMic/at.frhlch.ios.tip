//
//  CardView.swift
//  tip
//
//  Created by Michael Fröhlich on 10.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBInspectable
    var shadowRadius: CGFloat = 3.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 0.1 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize = CGSize(width: 0, height: 3.0) {
        didSet {
            updateView()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    func updateView()  {
        backgroundColor = .white
        
        layer.cornerRadius = 10.0
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
    }
    
}
