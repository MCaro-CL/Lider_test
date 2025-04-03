//
//  ResumeCartView.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import UIKit

final class ResumeCartView: UIView {
    private lazy var totalLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 30, weight: .light, width: .compressed)
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var purchaseButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(NSLocalizedString("RESUME_CARTVIEW_PURCHASE_BTN_TITLE", comment: ""), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAmount(_ amount: String) {
        totalLabel.text = amount
    }
}

extension ResumeCartView {
    private func setupUI() {
        addInheritance()
        setupConstraints()
    }
    private func addInheritance() {
        addSubview(totalLabel)
        addSubview(purchaseButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            totalLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            totalLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            purchaseButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 32),
            purchaseButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 48),
            purchaseButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -48),
            purchaseButton.heightAnchor.constraint(equalToConstant: 56),
            purchaseButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
}
