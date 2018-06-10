//
//  ResultLabel.swift
//  tip
//
//  Created by Michael Fröhlich on 10.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class ResultLabel: UILabel {
    
    private var borderBottomView: DashedView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    private func initialSetup() {
        borderBottomView = DashedView(frame: CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 2.0))
        borderBottomView.dashLength = 15.0
        borderBottomView.spaceLength = 0.0
        addSubview(borderBottomView)
        
        borderBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        let borderBottomViewHeightConstraint = NSLayoutConstraint(item: borderBottomView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 4.0)
        let borderBottomViewBottomConstraint = NSLayoutConstraint(item: borderBottomView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: borderBottomView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: borderBottomView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        self.addConstraint(borderBottomViewHeightConstraint)
        self.addConstraint(borderBottomViewBottomConstraint)
        self.addConstraint(leadingConstraint)
        self.addConstraint(trailingConstraint)
    }
}
