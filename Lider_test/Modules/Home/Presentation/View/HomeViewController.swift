//
//  HomeViewController.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 02-04-25.
//
import UIKit

final class HomeViewController: BaseViewController {
    private let viewModel: HomeViewModel
    
    lazy var showCategoryButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: .init(systemName: "ellipsis.circle"),style: .plain,target: self,action: #selector(didTapRightBarButton))
        btn.tintColor = .label
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(200))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                        heightDimension: .absolute(250))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .absolute(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.register(FeaturedProductCell.self, forCellWithReuseIdentifier: FeaturedProductCell.reuseIdentifier)
        collectionView.register(StandardProductCell.self, forCellWithReuseIdentifier: StandardProductCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: HomeViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabBarHeight = tabBarController?.tabBar.frame.height {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
        }
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .customBackgrond
        
        addInheritance()
        setupConstraints()
        connectToViewModel()
        viewModel.onSetupUI()
        title = NSLocalizedString("HOME_TITLE", comment: "")
    }
    private func addInheritance() {
        navigationItem.rightBarButtonItem = showCategoryButton
        view.addSubview(collectionView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func connectToViewModel() {
        subscribe(observable: viewModel.getProductsObservable) { [weak self] result in
            guard let self, let result else {
                return
            }
            switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alert = UIAlertController(
                            title: "Error al cargar los productos",
                            message: error.localizedDescription,
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: { _ in
                            self.viewModel.onSetupUI()
                        }))
                        alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
                        
                        self.present(alert, animated: true)
                    }
            }
            
        }
    }
    
    @objc
    private func didTapRightBarButton() {
        coordinator.presentViewController(from: self, to: CategoriesViewController.self) { delegate in
            delegate.delegate = self
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Se utiliza una sección para el producto destacado y otra para los productos estándar
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsOn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            // Configuración de la celda destacada
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedProductCell.reuseIdentifier, for: indexPath) as! FeaturedProductCell
            if let featuredProduct = self.viewModel.getFeaturedProduct() {
                cell.configure(with: featuredProduct)
                cell.delegate = self
                return cell
            } else {
                return cell
            }
        } else {
            // Configuración de las celdas estándar
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandardProductCell.reuseIdentifier, for: indexPath) as! StandardProductCell
            cell.configure(with: viewModel.getProduct(at: indexPath))
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.getProduct(at: indexPath).id
        coordinator.presentViewController(from: self, to: ProductDetailViewController.self, args: id)
    }
    
}

extension HomeViewController: CategorySelectionDelegate {
    func didSelectCategory(_ category: String) {
        viewModel.fetchProductsBy(category: category)
    }
}

extension HomeViewController: ProductCellDelegate {
    func didTapPlusButton(_ product: UiProduct) {
        viewModel.addProductToCart(product)
    }
}
