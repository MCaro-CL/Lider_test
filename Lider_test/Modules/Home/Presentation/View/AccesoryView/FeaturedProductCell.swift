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
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 30
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .init(white: 1, alpha: 0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var addToCartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.backgroundColor = .white
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.tintColor = .sparkYellow
        btn.addTarget(self, action: #selector(operationProduct), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .trueBlue
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)
        
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            addToCartButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: addToCartButton.topAnchor),
            priceLabel.rightAnchor.constraint(equalTo: addToCartButton.rightAnchor),
            priceLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            
            
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: priceLabel.topAnchor, constant: -4),
            titleLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: priceLabel.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            
            
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
