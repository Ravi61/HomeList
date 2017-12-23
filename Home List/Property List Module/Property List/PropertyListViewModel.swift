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
    var filterTapped: PublishSubject<Void> { get }

    // MARK: Output
    var tableItemsFetched: Observable<[PropertyCardListViewModel]> { get }
    var loaderTrigger: PublishSubject<LoaderState> { get }
    var filterTrigger: Observable<FilterViewModel> { get }
}

class PropertyListViewModel: PropertyListViewModelRepresentable {

    // MARK: Input
    var checkPagination: PublishSubject<Int> = PublishSubject<Int>()
    var filterTapped: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: Output
    var tableItemsFetched: Observable<[PropertyCardListViewModel]> = Observable<[PropertyCardListViewModel]>.just([])
    var loaderTrigger: PublishSubject<LoaderState> = PublishSubject<LoaderState>()
    var filterTrigger: Observable<FilterViewModel> = Observable.just(FilterViewModel())

    fileprivate var tableItems: Variable<[PropertyCardListViewModel]> = Variable<[PropertyCardListViewModel]>([])
    fileprivate var page: Int = 0
    private var apartmentString = ""
    private var propertyString = ""
    private var furnishingString = ""

    private let bag = DisposeBag()
    let filterModel = FilterViewModel()

    init() {

        tableItemsFetched = tableItems.asObservable()

        checkPagination.subscribe(onNext: { [unowned self] index in
            if index == self.tableItems.value.count - 1 {
                self.page += 1
                self.getPropertyList(apartmentFilter: self.apartmentString, propertyFilter: self.propertyString,
                                     furnishingFilter: self.furnishingString, isFilter: false)
            }
        }).disposed(by: bag)

        if page == 0 {
            tableItems.value = []
            getPropertyList(apartmentFilter: apartmentString, propertyFilter: propertyString,
                            furnishingFilter: furnishingString, isFilter: false)
        }

        filterModel.apartmentTypeString.asObservable().subscribe(onNext: { [unowned self] str in
            self.apartmentString = str
        }).disposed(by: bag)

        filterModel.propertyTypeString.asObservable().subscribe(onNext: { [unowned self] str in
            self.propertyString = str
        }).disposed(by: bag)

        filterModel.furnishingTypeString.asObservable().subscribe(onNext: { [unowned self] str in
            self.furnishingString = str
        }).disposed(by: bag)

        filterTrigger = filterTapped.map({ _ -> FilterViewModel in
            self.filterModel.filtersApplied = {
                self.getPropertyList(apartmentFilter: self.apartmentString, propertyFilter: self.propertyString,
                                     furnishingFilter: self.furnishingString,isFilter: true)
            }
            return self.filterModel
        })
    }
}

extension PropertyListViewModel {

    // fetching property list from api
    func getPropertyList(apartmentFilter: String, propertyFilter: String, furnishingFilter: String, isFilter: Bool) {
        loaderTrigger.onNext(.animate)
        API.request(.getProperties(withPage: page, apartmentFilter: apartmentFilter, propertyFilter: propertyFilter, furnishingFilter: furnishingFilter)) { [weak self] response in
            self?.loaderTrigger.onNext(.stop)
            do {
                let model: PropertyListModel = try response.mapObject()
                self?.extractTableItems(model: model, isFilter: isFilter)
            } catch {
                print("Unknown error")
            }
        }
    }

    func extractTableItems(model: PropertyListModel, isFilter: Bool) {
        
        let viewModels = model.data?.map({ property -> PropertyCardListViewModel in
            let photoURL = property.photos?.filter({ $0.displayPic == true })
                .map({ $0.imagesMap?.original ?? "" }).first ?? ""

            let model = PropertyCardModel(name: property.propertyTitle ?? "",
                                          address: property.street ?? "",
                                          amount: property.rent ?? 0,
                                          furnishing: Furnishing(rawValue: property.furnishing ?? "") ?? .none,
                                          bathrooms: property.bathroom ?? 0,
                                          area: property.propertySize ?? 0,
                                          isFavourite: false,
                                          isSponsored: property.sponsored ?? false,
                                          imageURL: photoURL)

            return PropertyCardListViewModel(model: model)
        }) ?? []

        if isFilter {
            tableItems.value = viewModels
        } else {
            tableItems.value.append(contentsOf: viewModels)
        }
    }
}
