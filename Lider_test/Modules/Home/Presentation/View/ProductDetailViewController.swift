//
//  ProductDetailViewController.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import UIKit

final class ProductDetailViewController: BaseViewController {
    private var product: UiProduct?
    private let viewModel: ProductDetailViewModel
    
    private lazy var productImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 30, weight: .bold, width: .compressed)
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var productPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .regular, width: .compressed)
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var productDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .light, width: .compressed)
        lbl.textColor = .label
        lbl.textAlignment = .justified
        lbl.numberOfLines = 5
        lbl.minimumScaleFactor = 0.8
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var addToCartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.tintColor = .trueBlue
        btn.addTarget(self, action: #selector(tapOnAddToCartButton), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "x.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 29).isActive = true
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.tintColor = .lightGray
        btn.addTarget(self, action: #selector(tapOnCloseButton), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init(productId: Int, viewModel: ProductDetailViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
        setupUI()
        viewModel.onSetupUI(id: productId)
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func tapOnCloseButton() {
        dismiss(animated: true)
    }
    @objc
    private func tapOnAddToCartButton() {
        viewModel.didTapOnAddToCartButton(self.product)
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

extension ProductDetailViewController {
    private func setupUI() {
        view.backgroundColor = .customBackgrond
        addInheritance()
        setupConstraints()
        connectToViewModel()
    }
    private func addInheritance() {
        view.addSubview(closeButton)
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productPriceLabel)
        view.addSubview(productDescriptionLabel)
        view.addSubview(addToCartButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            productImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            productImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productNameLabel.leftAnchor.constraint(equalTo: productImageView.leftAnchor),
            productNameLabel.rightAnchor.constraint(equalTo: productImageView.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productPriceLabel.leftAnchor.constraint(equalTo: productImageView.leftAnchor),
            productPriceLabel.rightAnchor.constraint(equalTo: productImageView.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            productDescriptionLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 8),
            productDescriptionLabel.leftAnchor.constraint(equalTo: productImageView.leftAnchor),
            productDescriptionLabel.rightAnchor.constraint(equalTo: productImageView.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 8),
            addToCartButton.rightAnchor.constraint(equalTo: productImageView.rightAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    private func connectToViewModel() {
        subscribe(observable: viewModel.getProductInformationObservable) {[weak self] result in
            guard let self, let result else {return}
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let product):
                        self.product = product
                        Task {
                            self.productImageView.image = await self.fetchProductImage(url: product.image)
                        }
                        self.productNameLabel.text = product.title
                        self.productDescriptionLabel.text = product.description
                        self.productPriceLabel.text = "$ \(product.price)"
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            let alert = UIAlertController(
                                title: "Error al obtener detalles del producto",
                                message: error.localizedDescription,
                                preferredStyle: .alert
                            )
                            alert
                                .addAction(
                                    UIAlertAction(
                                        title: "Volver al home",
                                        style: .cancel,
                                        handler: {[weak self] _ in
                                self?.dismiss(animated: true)
                            })
)
                            
                            self.present(alert, animated: true)
                        }
                }
            }
        }
        
        subscribe(observable: viewModel.addToCartObservable) { _ in
            let generadorNotificacion = UINotificationFeedbackGenerator()
            generadorNotificacion.notificationOccurred(.success) // O .warning, .error
        }
    }
}
