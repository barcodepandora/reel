//
//  ObserverOnline.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/4/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import RxSwift

class ObserverOnline {
    
    // MARK: - Character
    
    var time: Int!
    var disposeBag: DisposeBag!
    var summaryViewController: SummaryViewController!
    
    // MARK: - Reactive
    
    private let baseline = Variable("baselineOnline")
    var again:Observable<String> {
        return baseline.asObservable()
    }
    
    func prepare() {
        
        let delegate = self.summaryViewController
        
        // session
        if let bag = DisposeBag() as DisposeBag? {
            self.disposeBag = bag
            
            // gesture
            delegate!.gestured
                .debounce(RxTimeInterval(self.time), scheduler: MainScheduler.instance)
                .subscribe({ [weak self] character in
                    self!.doIsOnline()
                }).disposed(by: disposeBag)
            
            // validate
            self.again
                .debounce(RxTimeInterval(time), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] character in
                    self!.doIsOnline()
                }).disposed(by: self.disposeBag)
            
        }
    }
    
    func doIsOnline() {
        self.summaryViewController.prepareViewModel()
        self.baseline.value = "baselineOnline"
    }
}
