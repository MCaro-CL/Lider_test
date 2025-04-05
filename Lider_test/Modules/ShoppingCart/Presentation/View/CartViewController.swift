//
//  CartViewController.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import UIKit

final class CartViewController: BaseViewController {
    private let viewModel: CartViewModel
    lazy var backToHomeButtom: UIBarButtonItem = {
        let btn = UIBarButtonItem(
            title: NSLocalizedString("CARTVIEWCONTROLLER_BACK_TO_HOME_BTN_TITLE", comment: ""),
            style: .plain,
            target: self,
            action: #selector(tapOnBackToHomeButtom)
        )
        btn.tintColor = .label
        return btn
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var resumeView: ResumeCartView = {
        let resumeCartView = ResumeCartView()
        resumeCartView.setAmount("Total a pagar $2300 CLP")
        resumeCartView.translatesAutoresizingMaskIntoConstraints = false
        return resumeCartView
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.resumeView.isHidden = false
    }
    init(viewModel: CartViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartViewController {
    private func setupUI() {
        title = NSLocalizedString("GENERAL_CART", comment: "")
        addInheritance()
        setupConstraints()
        connectToViewModel()
    }
    private func addInheritance() {
        navigationItem.leftBarButtonItem = backToHomeButtom
        view.addSubview(tableView)
        view.addSubview(resumeView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            resumeView.leftAnchor.constraint(equalTo: view.leftAnchor),
            resumeView.rightAnchor.constraint(equalTo: view.rightAnchor),
            resumeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: resumeView.topAnchor, constant: 2)
        ])
    }
    private func connectToViewModel() {
        subscribe(observable: viewModel.getCartProductsObservable) { [weak self] _ in
            guard let self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        subscribe(observable: viewModel.updatePriceObservable) { [weak self] price in
            guard let self, let price else {return}
            DispatchQueue.main.async {
                self.resumeView.setAmount(String(format: "%.2f", price))
            }
        }
    }
    @objc
    private func tapOnBackToHomeButtom() {
        guard let tabBarController = self.tabBarController else { return }
        UIView
            .transition(with: tabBarController.view, duration: 0.2, options: [.transitionCrossDissolve], animations: {
                self.resumeView.isHidden = true
                tabBarController.selectedIndex = 0
            }, completion: nil)
    }
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberProducts()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CartCell else {
            fatalError("The dequeued cell is not an instance of CartTableViewCell.")
        }
        cell.fill(with: viewModel.getProduct(at: indexPath))
        cell.delegate = self
        
        return cell
    }
}

extension CartViewController: ProductCellDelegate {
    func didTapDeleteButton(_ product: UiProduct) {
        viewModel.resetProductTypeFromCart(product)
    }

    func didTapMinusButton(_ product: UiProduct) {
        viewModel.deleteProductFromCart(product)
    }

    func didTapPlusButton(_ product: UiProduct) {
        viewModel.addProductToCart(product)
    }
}
