//
//  PropertyCardListViewModel.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import RxSwift

protocol PropertyCardListViewModelRepresentable {
    // MARK: Input
    var callButtonTrigger: PublishSubject<String> { get }
    var favouriteButtonTrigger: PublishSubject<Void> { get }

    // MARK: Output
    var propertyBasicDetails: Observable<(name: String, address: String)> { get }
    var propertyAmount: Observable<String> { get }
    var propertyDesc: Observable<String> { get }
    var propertyArea: Observable<Int> { get }
    var sponsoredImageWidthTrigger: Observable<Int> { get }
    var favouriteSelectionTrigger: Observable<Bool> { get }
    var photoURL: Observable<String> { get }
}

class PropertyCardListViewModel: PropertyCardListViewModelRepresentable {

    private var model: PropertyCardModel
    private var bag = DisposeBag()

    // MARK: Input
    var callButtonTrigger: PublishSubject<String> = PublishSubject<String>()
    var favouriteButtonTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: Output
    var propertyBasicDetails: Observable<(name: String, address: String)>
        = Observable<(name: String, address: String)>.just(("", ""))
    var propertyAmount: Observable<String> = Observable<String>.just("")
    var propertyDesc: Observable<String> = Observable<String>.just("")
    var propertyArea: Observable<Int> = Observable<Int>.just(0)
    var sponsoredImageWidthTrigger: Observable<Int> = Observable.just(0)
    var favouriteSelectionTrigger: Observable<Bool> = Observable.just(false)
    var photoURL: Observable<String> = Observable.just("")

    init(model: PropertyCardModel) {
        self.model = model

        let address = "at \(model.address)"
        propertyBasicDetails = Observable.just((model.name, address))

        let amount = model.amount.formatAsMoney()
        propertyAmount = Observable.just(amount)

        let furnishing = model.furnishing.rawValue
        let desc = "\(furnishing)\n\(model.bathrooms) Bathrooms"
        propertyDesc = Observable.just(desc)

        propertyArea = Observable.just(model.area)

        callButtonTrigger.subscribe(onNext: { [unowned self] number in
            self.call(number)
        }).disposed(by: bag)

        favouriteSelectionTrigger = model.isFavourite.asObservable()

        favouriteButtonTrigger.subscribe(onNext: { [unowned self] _ in
            let state = self.model.isFavourite.value
            self.model.isFavourite.value = !state
        }).disposed(by: bag)

        if model.isSponsored {
            sponsoredImageWidthTrigger = Observable.just(30)
        }

        let displayURL = getPicURL(model.imageURL)
        photoURL = Observable.just(displayURL)
    }

    func call(_ number: String) {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    func getPicURL(_ url: String) -> String {
        let base = "http://d3snwcirvb4r88.cloudfront.net/images/"
        let middle = url.components(separatedBy: "_").first ?? ""
        return "\(base)\(middle)/\(url)"
    }
}
