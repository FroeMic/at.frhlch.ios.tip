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
    private var borderBottomViewHeightConstraint: NSLayoutConstraint!
    private var borderBottomViewBottomConstraint: NSLayoutConstraint!
    
    @IBInspectable
    var prefix: String = ""
    
    private(set) var textWithoutPrefix: String?
    
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
        
        borderBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        borderBottomViewHeightConstraint = NSLayoutConstraint(item: borderBottomView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 2.0)
        borderBottomViewBottomConstraint = NSLayoutConstraint(item: borderBottomView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: borderBottomView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: borderBottomView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)

        
        self.addConstraint(borderBottomViewHeightConstraint)
        self.addConstraint(borderBottomViewBottomConstraint)
        self.addConstraint(leadingConstraint)
        self.addConstraint(trailingConstraint)
        
    }
    
    private func styleView() {
        borderStyle = .none
    }

    
    private func animateBorderBottomDashed() {
        UIView.animate(withDuration: 0.2, animations: {
            self.borderBottomViewHeightConstraint.constant = 2.0
            self.borderBottomViewBottomConstraint.constant = 0.0
            self.borderBottomView.spaceLength = 10.0
        })
    }
    
    private func animateBorderBottomSolid() {
        UIView.animate(withDuration: 1.2, animations: {
            self.borderBottomViewHeightConstraint.constant = 4.0
            self.borderBottomViewBottomConstraint.constant = 2.0
            self.borderBottomView.spaceLength = 0.0
        })
    }
    
    
    // MARK: User Interaction
    fileprivate func didSelectTextField() {
        animateBorderBottomSolid()
    }
    
    fileprivate func didDeselectTextField() {
        animateBorderBottomDashed()
    }
}

extension AnimatedTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didSelectTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didDeselectTextField()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let typeCasteToStringFirst = (textWithoutPrefix ?? "") as NSString
        var updatedLocation =  range.location - prefix.count - (prefix.count > 0 ? 1 : 0)
        updatedLocation = updatedLocation < 0 ? 0 : updatedLocation
        let updatedLength = (updatedLocation + range.length) > typeCasteToStringFirst.length ? typeCasteToStringFirst.length : range.length
        let updatedRange = NSRange(location: updatedLocation, length: updatedLength)
        textWithoutPrefix = typeCasteToStringFirst.replacingCharacters(in: updatedRange, with: string)
        
        let locationDifference = range.location - updatedRange.location
        let beginning: UITextPosition = textField.position(from: textField.beginningOfDocument, offset: locationDifference) ?? textField.beginningOfDocument
        let newCursorLocation = textField.position(from: beginning, offset: updatedRange.location + string.count)
        
        let replacementText = textWithoutPrefix ?? ""
        if replacementText == "" {
            textField.text = ""
        } else if prefix == "" {
            textField.text = replacementText
        } else {
            textField.text = "\(prefix) \(replacementText)"
        }
        
        if let newCursorLocation = newCursorLocation
        {
            textField.selectedTextRange = textField.textRange(from: newCursorLocation, to: newCursorLocation)
        }
        
        return false
    }

}

