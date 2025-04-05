//
//  StandardProductCell.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//
import UIKit

class StandardProductCell: UICollectionViewCell {
    static let reuseIdentifier = "StandardProductCell"
    private var product: UiProduct?
    weak var delegate: ProductCellDelegate?
    
    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "photo.on.rectangle.angled")
        img.contentMode = .scaleAspectFit
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
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
    private lazy var addToCartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.backgroundColor = .white
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.tintColor = .trueBlue
        btn.addTarget(self, action: #selector(operationProduct), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupViews()
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 2)
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowOpacity = 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado")
    }
    
    private func setupViews() {
        contentView.addSubview(addToCartButton)
        NSLayoutConstraint.activate([
            addToCartButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
        contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor),
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8)
        ])
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -4),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -4),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
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
