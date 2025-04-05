//
//  FeaturedProductCell.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//
import UIKit

class FeaturedProductCell: UICollectionViewCell {
    static let reuseIdentifier = "FeaturedProductCell"
    private var product: UiProduct?
    weak var delegate: ProductCellDelegate?
    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var addToCartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.backgroundColor = .white
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.tintColor = .systemBlue
        btn.addTarget(self, action: #selector(operationProduct), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemYellow
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            priceLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            addToCartButton.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
        ])
    }
    
    func configure(with product: UiProduct) {
        Task{
            self.product = product
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
            debugPrint("Error al descargar la imagen: \(error.localizedDescription)")
            return nil
        }
    }
    
    @objc
    private func operationProduct() {
        guard let product = product else { return }
        delegate?.didTapPlusButton(product)
    }
}
