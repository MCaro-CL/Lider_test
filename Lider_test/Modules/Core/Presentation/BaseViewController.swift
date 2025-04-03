//
//  BaseViewController.swift
//  SmartContacts
//
//  Created by Mauricio Caro on 18-08-22.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController{
    
    let coordinator : Coordinator
    let disposeBag = DisposeBag()
    
    init(coordinator:Coordinator){
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subscribe<T>(observable:Observable<T>, action: @escaping(T?)->Void){
        observable.subscribe(onNext:{ data in
            action(data)
        }).disposed(by: self.disposeBag)
    }
    
}
