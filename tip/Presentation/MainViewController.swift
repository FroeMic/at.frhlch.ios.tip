//
//  ViewController.swift
//  tip
//
//  Created by Michael Fröhlich on 08.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    fileprivate static let collectionViewReuseIdentifier = "EmjoiCollectionViewCell"

    @IBOutlet var expenseTextField: AnimatedTextField!
    @IBOutlet var emojiCollectionView: UICollectionView!
    
    private var tipPrototyps: [TipPrototyp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureExpenseTextField()
        configureEmojiCollectionView()
        configureCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        emojiCollectionView.register(EmjoiCollectionViewCell.self, forCellWithReuseIdentifier: MainViewController.collectionViewReuseIdentifier)
        emojiCollectionView.delegate = self
        emojiCollectionView.dataSource = self
        
        expenseTextField.becomeFirstResponder()
        tipPrototyps = Injection.tipRepository.get()
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionViewLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    private func configureExpenseTextField() {
        expenseTextField.textAlignment = .right
        expenseTextField.font = UIFont.boldSystemFont(ofSize: 36.0)
        expenseTextField.enablesReturnKeyAutomatically = true
        expenseTextField.keyboardType = .decimalPad
    }
    
    private func configureEmojiCollectionView() {
        emojiCollectionView.clipsToBounds = false
        emojiCollectionView.isScrollEnabled = false
        emojiCollectionView.showsVerticalScrollIndicator = false
        emojiCollectionView.showsHorizontalScrollIndicator = false
    }

    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = UIDevice.isSmallDevice ? 10.0 : 20.0
        layout.minimumInteritemSpacing = UIDevice.isSmallDevice ? 10.0 : 20.0
        
        let height = emojiCollectionView.bounds.height - layout.minimumLineSpacing * 1.0
        let width = emojiCollectionView.bounds.width - layout.minimumInteritemSpacing * 2.0
        
        let cellWidth = (height / 2.0 < width / 3.0) ? height / 2.0 : width / 3.0
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)

        emojiCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipPrototyps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewController.collectionViewReuseIdentifier, for: indexPath)
        if let emojiCell = cell as? EmjoiCollectionViewCell {
            emojiCell.tipPrototyp = tipPrototyps[indexPath.row]
        }
        return cell
    }
    
    
}

