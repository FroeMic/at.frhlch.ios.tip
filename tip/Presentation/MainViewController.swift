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
    @IBOutlet var relativTipLabel: UILabel!
    @IBOutlet var absolutTipLabel: UILabel!
    
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    
    private var tipPrototyps: [TipPrototyp] = []
    private var selectedPrototyp: TipPrototyp?
    private var modifier: Float = 0.0
    private var tip: Float {
        return (selectedPrototyp?.tip ?? 0.0) + modifier
    }
    private var expense: Float {
        guard let expenseText = expenseTextField.text, let expense = Float(expenseText) else {
            return 0.0
        }
        return expense
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureExpenseTextField()
        configureEmojiCollectionView()
        configureCollectionViewLayout()
        configureRelativTipLabel()
        configureAbsolutTipLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        emojiCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: MainViewController.collectionViewReuseIdentifier)
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
        layout.minimumLineSpacing = UIDevice.isSmallDevice ? 10.0 : 10.0
        layout.minimumInteritemSpacing = UIDevice.isSmallDevice ? 10.0 : 10.0
        
        let height = emojiCollectionView.bounds.height - layout.minimumLineSpacing * 1.0
        let width = emojiCollectionView.bounds.width - layout.minimumInteritemSpacing * 2.0
        
        let cellWidth = (height / 2.0 < width / 3.0) ? height / 2.0 : width / 3.0
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        emojiCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func configureRelativTipLabel() {
        relativTipLabel.font = UIFont.systemFont(ofSize: 24.0)
        relativTipLabel.textAlignment = .right
    }
    
    func configureAbsolutTipLabel() {
        absolutTipLabel.font = UIFont.systemFont(ofSize: 14.0)
        absolutTipLabel.textAlignment = .right
        absolutTipLabel.textColor = UIColor.gray
    }
    
    // MARK: User Interaction
    @IBAction func increaseButtonPressed(_ sender: ShadowButton) {
        modifier += 0.01
        hapticFeedback()
        animateButton(sender)
        updateLabels()
    }
    
    @IBAction func decreaseButtonPressed(_ sender: ShadowButton) {
        let stepSize: Float = -0.01
        if tip + stepSize < 0.0 {
            modifier = -1.0 * (selectedPrototyp?.tip ?? 0.0)
            hapticFeedback(forSuccess: false)
            animateButton(sender)
        } else {
            modifier += stepSize
            hapticFeedback()
            animateButton(sender)
        }
        updateLabels()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
        super.touchesBegan(touches, with: event)
    }

    private func didSelectTipPrototyp(_ tipPrototyp: TipPrototyp) {
        selectedPrototyp = tipPrototyp
        resetModifier()
        dismissKeyboard()
        hapticFeedback()
        updateLabels()
    }
    
    
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func resetModifier() {
        modifier = 0.0
    }
        private func updateLabels() {
        relativTipLabel.text = "\(Int(tip * 100)) %"
        absolutTipLabel.text = "\(expense * tip)"
    }
    
    private func hapticFeedback(forSuccess: Bool = true) {
        if Injection.settingsRepository.shouldProvideHapticFeedback {
            let notificationType: UINotificationFeedbackType = forSuccess ? .success : .error
            feedbackGenerator.notificationOccurred(notificationType)
        }
    }
    
    private func animateButton(_ button: ShadowButton) {
        if Injection.settingsRepository.shouldAnimate {
            button.animate()
        }
    }

}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectTipPrototyp(tipPrototyps[indexPath.row])
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipPrototyps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewController.collectionViewReuseIdentifier, for: indexPath)
        if let emojiCell = cell as? EmojiCollectionViewCell {
            emojiCell.tipPrototyp = tipPrototyps[indexPath.row]
            emojiCell.shouldAnimateOnSelection = Injection.settingsRepository.shouldAnimate
        }
        return cell
    }
    
}

