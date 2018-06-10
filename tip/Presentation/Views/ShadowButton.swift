//
//  ShadowButton.swift
//  tip
//
//  Created by Michael Fröhlich on 10.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class ShadowButton: UIButton {
    
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
    
    @IBInspectable
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            updateView()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    private func updateView()  {
        backgroundColor = .white
        clipsToBounds = false
        
        layer.cornerRadius = cornerRadius
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
    }
}
