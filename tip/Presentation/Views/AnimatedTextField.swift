//
//  AnimatedTextField.swift
//  tip
//
//  Created by Michael Fröhlich on 08.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

@IBDesignable
class AnimatedTextField: UITextField {
    
    private var borderBottomView: DashedView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        styleView()
    }
    
    // MARK: Setup
    private func initialSetup() {
        
        delegate = self
        
        textAlignment = .right
        
        borderBottomView = DashedView(frame: CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 2.0))
        borderBottomView.dashLength = 15.0
        borderBottomView.spaceLength = 10.0
        addSubview(borderBottomView)
        
    }
    
    private func styleView() {
        super.layoutSubviews()
        borderStyle = .none
        

        
    }

    
    private func animateBorderBottomDashed() {
        UIView.animate(withDuration: 0.2, animations: {
            self.borderBottomView.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 2.0)
            self.borderBottomView.spaceLength = 10.0
        })
    }
    
    private func animateBorderBottomSolid() {
        UIView.animate(withDuration: 0.2, animations: {
            self.borderBottomView.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 4.0)
            self.borderBottomView.spaceLength = 0.0
        })
    }
    
    private func animateFontSize(multipier: CGFloat) {
        // TODO
    }

    private func animateAlignment(alignment: NSTextAlignment) {
        UIView.animate(withDuration: 0.2, animations: {
            self.textAlignment = alignment
        })
    }
    
    private func configTextField() {
        
    }
    
    // MARK: User Interaction
    fileprivate func didSelectTextField() {
        animateBorderBottomSolid()
        animateAlignment(alignment: .left)
        animateFontSize(multipier: 1.2)
    }
    
    fileprivate func didDeselectTextField() {
        animateBorderBottomDashed()
        animateAlignment(alignment: .right)
         animateFontSize(multipier: 1.0)
    }
}

extension AnimatedTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didSelectTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didDeselectTextField()
    }

}

