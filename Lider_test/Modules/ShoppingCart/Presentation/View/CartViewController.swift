//
//  CartViewController.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import UIKit

final class CartViewController: BaseViewController {
    private let viewModel: CartViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var resumeView: ResumeCartView = {
        let resumeCartView = ResumeCartView()
        resumeCartView.setAmount("Total a pagar $2300 CLP")
        resumeCartView.translatesAutoresizingMaskIntoConstraints = false
        return resumeCartView
    }()
    
    init(viewModel: CartViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
        setupUI()
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
        
    }
}
