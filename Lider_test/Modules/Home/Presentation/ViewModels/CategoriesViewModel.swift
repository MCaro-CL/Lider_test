//
//  CategoriesViewModel.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation
import RxSwift

final class CategoriesViewModel {
    private(set) var categories: [String] = ["Todos"]
    
    private let getCategoriesUseCase: GetCategoriesUseCase
    private let getCategoriesNotification = PublishSubject<Result<(), HTTPError>>()
    var getCategoriesObservable: Observable<Result<(), HTTPError>> {
        return getCategoriesNotification.asObservable()
    }
    private let selectCategory: SelectCategoryUseCase
    private let selectCategoryNotification = PublishSubject<()>()
    var selectCategoryObservable: Observable<Void> {
        return selectCategoryNotification.asObservable()
    }
    
    init(getCategoriesUseCase: GetCategoriesUseCase, selectCategory: SelectCategoryUseCase) {
        self.getCategoriesUseCase = getCategoriesUseCase
        self.selectCategory = selectCategory
    }
    
    func onSetupView() {
        Task{
            switch await getCategoriesUseCase.execute() {
                case .success(let categories):
                    for category in categories {
                        self.categories.append(category)
                    }
                    getCategoriesNotification.onNext(.success(()))
                case .failure(let failure):
                    getCategoriesNotification.onNext(.failure(failure))
            }
        }
    }
    func numbersOfCategories() -> Int {
        return categories.count
    }
    func getCategory(at: IndexPath) -> String {
        return categories[at.row]
    }
    func didTapOnCategory(at: IndexPath) {
        selectCategory.execute(category: categories[at.row])
        selectCategoryNotification.onNext(())
    }
}
