//
//  EmjoiCollectionViewCell.swift
//  tip
//
//  Created by Michael Fröhlich on 08.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class EmjoiCollectionViewCell: UICollectionViewCell {
    
    private let cardView = UIView()
    private let emojiTextField = UILabel()
    
    var emoji: String = "" {
        didSet {
            //
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        styleCard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        styleCard()
    }
    
    private func styleCard() {
        let backgroundFrame = calculateCardViewFrame(with: 0.8)
        cardView.frame = backgroundFrame
        cardView.backgroundColor = backgroundColor
        cardView.layer.cornerRadius = 10.0
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5.0)

    }
    
    private func styleLabel() {
        let backgroundFrame = calculateCardViewFrame(with: 0.8)
        cardView.frame = backgroundFrame
        cardView.backgroundColor = backgroundColor
        cardView.layer.cornerRadius = 10.0
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        
    }
    
    private func calculateCardViewFrame(with factor: CGFloat) -> CGRect {
        let height = frame.height * factor
        let width = frame.width * factor
        let y = frame.height * (1.0 - factor) * 0.5
        let x = frame.width * (1.0 - factor) * 0.5
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        styleCard()
    }
    
}
