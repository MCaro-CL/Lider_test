//
//  CategoryCell.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import UIKit

final class CategoryCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func fill(with category: String) {
        self.titleLabel.text = category
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CategoryCell {
    private func setupUI() {
        addInheritance()
        setupConstraints()
    }
    private func addInheritance() {
        contentView.addSubview(titleLabel)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
