//
//  StandardProductCell.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//
import UIKit

class StandardProductCell: UICollectionViewCell {
    static let reuseIdentifier = "StandardProductCell"
    
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray5
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado")
    }
    
    private func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with product: UiProduct) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
    }
}
