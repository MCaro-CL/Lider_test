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
    private var activityIndicator: UIActivityIndicatorView?
    
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
    func startLoading() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator?.center = self.view.center
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.color = .white
            self.view.addSubview(activityIndicator!)
        }
        
        activityIndicator?.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
}
