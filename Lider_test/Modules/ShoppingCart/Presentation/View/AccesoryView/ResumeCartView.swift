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
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        lbl.textColor = .black
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
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.backgroundColor = .trueBlue
        btn.layer.cornerRadius = 15
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAmount(_ amount: Double) {
        if amount > 0 {
            totalLabel.text = "\(NSLocalizedString("RESUMECARTVIEW_TOTAL_TITLE", comment: "")) \(String(format: "%.2f", amount)) CLP"
        } else {
            totalLabel.text = nil
        }
        
    }
}

extension ResumeCartView {
    private func setupUI() {
        backgroundColor = .white
        addInheritance()
        setupConstraints()
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray.cgColor
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.3
    }
    private func addInheritance() {
        addSubview(totalLabel)
        addSubview(purchaseButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            totalLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            totalLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            purchaseButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 24),
            purchaseButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 48),
            purchaseButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -48),
            purchaseButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
}
