//
//  FiltersViewModel.swift
//  Home List
//
//  Created by Ravi on 22/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import RxSwift

class FilterViewModel {
    
    var applyButtonTapped: PublishSubject<Void> = PublishSubject<Void>()
    var filtersApplied: (() -> Void)?
    
    var items: Variable<[ApartmentTypeCellViewModel]> = Variable<[ApartmentTypeCellViewModel]>([])
    var refreshTrigger: PublishSubject<Void> = PublishSubject<Void>()
    var apartmentTypeString: Variable<String> = Variable<String>("")
    var propertyTypeString: Variable<String> = Variable<String>("")
    var furnishingTypeString: Variable<String> = Variable<String>("")
    var dismissTrigger: PublishSubject<Void> = PublishSubject<Void>()
    
    private let bag = DisposeBag()
    
    init() {
        createInitialModels()
        
        refreshTrigger.subscribe(onNext: { [unowned self] _ in
            self.apartmentTypeString.value = ""
            self.propertyTypeString.value = ""
            self.furnishingTypeString.value = ""
            self.createInitialModels()
        }).disposed(by: bag)
        
        applyButtonTapped.subscribe(onNext: { [unowned self] _ in
            self.dismissTrigger.onNext(())
            self.filtersApplied?()
        }).disposed(by: bag)
    }
    
    func createInitialModels() {
        let apartmentViewModel = ApartmentTypeCellViewModel(model: ApartmentTypeModel(title: "Apartment Type", types: [(ApartmentType.rk.rawValue, false), (ApartmentType.oneBHK.rawValue, false), (ApartmentType.twoBHK.rawValue, false), (ApartmentType.threeBHK.rawValue, false), (ApartmentType.fourBHK.rawValue, false), (ApartmentType.moreBHK.rawValue, false)], type: .apartmentType))

        apartmentViewModel.filterString.subscribe(onNext: { [unowned self] str in
            self.apartmentTypeString.value = str
        }).disposed(by: bag)
        
        let propertyTypeViewModel = ApartmentTypeCellViewModel(model: ApartmentTypeModel(title: "Property Type", types: [(Property.apartment.rawValue, false), (Property.independentHouse.rawValue, false), (Property.independentFloor.rawValue, false)], type: .propertyType))
        
        propertyTypeViewModel.filterString.subscribe(onNext: { [unowned self] str in
            self.propertyTypeString.value = str
        }).disposed(by: bag)
        
        let furnishingViewModel = ApartmentTypeCellViewModel(model: ApartmentTypeModel(title: "Furnishing Type", types: [(Furnishing.semi.rawValue, false), (Furnishing.full.rawValue, false), (Furnishing.none.rawValue, false)], type: .furnishing))
        
        furnishingViewModel.filterString.subscribe(onNext: { [unowned self] str in
            self.furnishingTypeString.value = str
        }).disposed(by: bag)
        
        items.value = [apartmentViewModel, propertyTypeViewModel, furnishingViewModel]
    }
}
