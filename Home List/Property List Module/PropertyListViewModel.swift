//
//  PropertyListViewModel.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import RxSwift

enum LoaderState {
    case animate
    case stop
}

protocol PropertyListViewModelRepresentable {
    // MARK: Input
    var checkPagination: PublishSubject<Int> { get }
    
    // MARK: Output
    var tableItemsFetched: Observable<[PropertyCardListViewModel]> { get }
    var loaderTrigger: PublishSubject<LoaderState> { get }
}

class PropertyListViewModel: PropertyListViewModelRepresentable {
    
    // MARK: Input
    var checkPagination: PublishSubject<Int> = PublishSubject<Int>()
    
    // MARK: Output
    var tableItemsFetched: Observable<[PropertyCardListViewModel]> = Observable<[PropertyCardListViewModel]>.just([])
    var loaderTrigger: PublishSubject<LoaderState> = PublishSubject<LoaderState>()
    
    fileprivate var tableItems: Variable<[PropertyCardListViewModel]> = Variable<[PropertyCardListViewModel]>([])
    fileprivate var page: Int = 1
    private let bag = DisposeBag()
    
    init() {
        
        tableItemsFetched = tableItems.asObservable()
        
        checkPagination.subscribe(onNext: { [unowned self] index in
            if index == self.tableItems.value.count - 1 {
                self.page += 1
                self.getPropertyList()
            }
        }).disposed(by: bag)
        
        let model = PropertyCardListViewModel(model: PropertyCardModel(name: "ABC", address: "abcd athdhjh dkjskgfk", amount: 5000, furnishing: .semi, bathrooms: 4, area: 4000, isFavourite: false, isSponsored: true))
        tableItems.value = [model, model, model, model, model]
    }
}

extension PropertyListViewModel {
    
    func getPropertyList() {
        loaderTrigger.onNext(.animate)
        API.request(API.Endpoint.getProperties(withPage: page)) { (response) in
            self.loaderTrigger.onNext(.stop)
            print(response.result.debugDescription)
        }
    }
}
