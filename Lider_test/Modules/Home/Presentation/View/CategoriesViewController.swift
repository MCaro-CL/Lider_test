//
//  CategoriesViewController.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import UIKit

final class CategoriesViewController: BaseViewController {
    let viewModel: CategoriesViewModel
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = NSLocalizedString("CATEGORIES_TITLE", comment: "")
        lbl.font = .boldSystemFont(ofSize: 24)
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var closebutton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(.init(systemName: "x.circle.fill"), for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableview.backgroundColor = .clear
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()
    
    init(viewModel: CategoriesViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
        setupUI()
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoriesViewController {
    private func setupUI() {
        view.backgroundColor = .customBackgrond
        addInheritance()
        setupConstraints()
        connectToViewModel()
        viewModel.onSetupView()
    }
    private func addInheritance() {
        view.addSubview(titleLabel)
        view.addSubview(closebutton)
        view.addSubview(tableview)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            closebutton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            closebutton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            tableview.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: closebutton.rightAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func connectToViewModel() {
        subscribe(observable: viewModel.getCategoriesObservable) { [weak self] _ in
            guard let self else {return}
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    @objc
    private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfCategories()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
            return UITableViewCell()
        }
        cell.fill(with: viewModel.getCategory(at: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didTapOnCategory(at: indexPath)
    }
}
