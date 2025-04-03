//
//  StandardProductCell.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//
import UIKit

class StandardProductCell: UICollectionViewCell {
    static let reuseIdentifier = "StandardProductCell"
    
    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray5
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado")
    }
    
    private func setupViews() {
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        
        
        NSLayoutConstraint.activate([
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -4),
            titleLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: priceLabel.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -4),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
        ])
    }
    
    
    func configure(with product: UiProduct) {
        Task{
            imageView.image = await fetchProductImage(url: product.image)
            titleLabel.text = product.title
            priceLabel.text = "$\(product.price)"
        }
    }
    
    private func fetchProductImage(url: String) async -> UIImage? {
        guard let url = URL(string: url) else {
            return nil
        }
        do {
            return try await ImageDownloader.shared.downloadImage(from: url)
        } catch {
            print("Error al descargar la imagen: \(error.localizedDescription)")
            return nil
        }
    }
}
