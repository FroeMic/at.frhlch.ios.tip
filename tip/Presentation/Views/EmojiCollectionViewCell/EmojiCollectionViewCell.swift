//
//  EmjoiCollectionViewCell.swift
//  tip
//
//  Created by Michael Fröhlich on 08.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    // UI
    private let emojiLabel: UILabel = UILabel()
    private let cardView: CardView = CardView()
    
    private var isNotSelectedLabelMultiplier: CGFloat = UIDevice.isSmallDevice ? 0.8 : 0.65
    private var labelFontSize: CGFloat = UIDevice.isSmallDevice ? 38.0 : 56.0
    private var isNotSelectedCardMultiplier: CGFloat = UIDevice.isSmallDevice ? 0.90 : 0.8
    
    var shouldAnimateOnSelection: Bool = true
    
    // Model
    var tipPrototyp: TipPrototyp = TipPrototyp(symbol: "❓", tip: 0.00) {
        didSet {
            updateViewContent()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        
        setupCardView()
        setupLabel()
        updateSelectionState(initial: true)
    }
    
    private func setupCardView() {
        
        addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerY = NSLayoutConstraint(item: cardView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let centerX = NSLayoutConstraint(item: cardView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: cardView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let height = NSLayoutConstraint(item: cardView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
    
        addConstraint(centerY)
        addConstraint(centerX)
        addConstraint(width)
        addConstraint(height)
    }
    
    private func setupLabel() {
        
        emojiLabel.textAlignment = .center
        emojiLabel.font = UIFont.systemFont(ofSize: labelFontSize)
        
        addSubview(emojiLabel)
        
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let centerConstraint = NSLayoutConstraint(item: emojiLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: emojiLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: emojiLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        
        addConstraint(centerConstraint)
        addConstraint(leadingConstraint)
        addConstraint(trailingConstraint)
    }
    
    private func updateSelectionState(initial: Bool = false) {
        let animationDuration: TimeInterval = !initial && shouldAnimateOnSelection ? 0.2 : 0.0
        if isSelected {
            
            UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.emojiLabel.transform = .identity
                self.cardView.transform = .identity
                self.cardView.shadowRadius = 5.0
                self.cardView.shadowOpacity = 0.15
                self.cardView.shadowOffset = CGSize(width: 0, height: 5.0)
            })
            
            let label = UILabel(frame: self.bounds)
            label.center = CGPoint(x: bounds.width / 2.0, y: 10.0)
            label.textAlignment = .center
            label.text = "\(Int(tipPrototyp.tip * 100)) %"
            addSubview(label)
            
            UIView.animate(withDuration: animationDuration + 1.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                label.transform = label.transform.translatedBy(x: 0, y: -20.0)
                label.alpha = 0.0
            }, completion: { _ in
                label.removeFromSuperview()
            })
            
        } else {
            UIView.animate(withDuration: animationDuration, animations: {
                self.emojiLabel.transform = .identity
                self.cardView.transform = .identity
                self.emojiLabel.transform = self.emojiLabel.transform.scaledBy(x: self.isNotSelectedLabelMultiplier, y: self.isNotSelectedLabelMultiplier)
                self.cardView.transform = self.cardView.transform.scaledBy(x: self.isNotSelectedCardMultiplier, y: self.isNotSelectedCardMultiplier)
                self.cardView.shadowRadius = 3.0
                self.cardView.shadowOpacity = 0.1
                self.cardView.shadowOffset = CGSize(width: 0, height: 3.0)
            })
        }
    }
    
    private func updateViewContent() {
        emojiLabel.text = "\(tipPrototyp.symbol)"
    }
    
}
