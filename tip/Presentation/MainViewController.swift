//
//  ViewController.swift
//  tip
//
//  Created by Michael Fröhlich on 08.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var expenseTextField: AnimatedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureExpenseTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        expenseTextField.becomeFirstResponder()
        super.viewWillAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    private func configureExpenseTextField() {
        expenseTextField.textAlignment = .right
        expenseTextField.font = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        expenseTextField.enablesReturnKeyAutomatically = true
        expenseTextField.keyboardType = .decimalPad
    }


}

