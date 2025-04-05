//
//  CartCell.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 04-04-25.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
    func didTapDeleteButton(_ product: UiProduct)
    func didTapMinusButton(_ product: UiProduct)
    func didTapPlusButton(_ product: UiProduct)
}
final class CartCell: UITableViewCell {
    private var product: UiProduct?
    weak var delegate: ProductCellDelegate?
    private let repository =  CartRepository.shared
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var productPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var minusProductButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 0
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .red
        btn.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(operationProduct), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private lazy var productQuantityLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.text = "1"
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var addProductButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 1
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemGreen
        btn.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(operationProduct), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private lazy var deleteAllProductsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 2
        btn.setTitle(NSLocalizedString("CARTCELL_DELETE_PRODUCTS_BUTTON_TITLE", comment: ""), for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 0.8
        btn.addTarget(self, action: #selector(operationProduct), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.product = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension CartCell {
    private func setupUI() {
        selectionStyle = .none
        addInheritance()
        setupConstraints()
        NotificationCenter.default.addObserver(self,selector: #selector(updateCell),name: NSNotification.Name("updatedRepository"),object: nil)
    }
    private func addInheritance() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(productQuantityLabel)
        contentView.addSubview(deleteAllProductsButton)
        contentView.addSubview(minusProductButton)
        contentView.addSubview(addProductButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productNameLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 4),
            productNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2),
            productPriceLabel.leftAnchor.constraint(equalTo: productNameLabel.leftAnchor),
            productPriceLabel.rightAnchor.constraint(equalTo: productNameLabel.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            deleteAllProductsButton.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 8),
            deleteAllProductsButton.leftAnchor.constraint(equalTo: productPriceLabel.leftAnchor),
            deleteAllProductsButton.rightAnchor.constraint(equalTo: productPriceLabel.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            minusProductButton.topAnchor.constraint(equalTo: deleteAllProductsButton.bottomAnchor, constant: 8),
            minusProductButton.leftAnchor.constraint(equalTo: deleteAllProductsButton.leftAnchor),
        ])
        NSLayoutConstraint.activate([
            productQuantityLabel.centerYAnchor.constraint(equalTo: minusProductButton.centerYAnchor),
            productQuantityLabel.centerXAnchor.constraint(equalTo: productNameLabel.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            addProductButton.topAnchor.constraint(equalTo: minusProductButton.topAnchor),
            addProductButton.rightAnchor.constraint(equalTo: deleteAllProductsButton.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            productImageView.rightAnchor.constraint(equalTo: contentView.centerXAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            productImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.width / 2)
        ])
        
    }
    
}

extension CartCell {
    func fill(with product: UiProduct) {
        self.product = product
        Task{ productImageView.image = await fetchProductImage(url: product.image)}
        productNameLabel.text = product.title
        productPriceLabel.text = "$ \(product.price)"
    }
    
    @objc
    private func operationProduct(_ sender: UIButton) {
        guard let product = product else { return }
        switch sender.tag {
                case 0:
                delegate?.didTapMinusButton(product)
                case 1:
                delegate?.didTapPlusButton(product)
                case 2:
                delegate?.didTapDeleteButton(product)
                default:
                break
        }
    }
    @objc
    private func updateCell() {
        guard let product = product else { return }
        productQuantityLabel.text = "\(repository.counterBy(id: product.id))"
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
    
}

extension ProductCellDelegate {
    func didTapDeleteButton(_ product: UiProduct) {}
    func didTapMinusButton(_ product: UiProduct) {}
}
