//
//  ApartmentTypeCellViewModel.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import RxSwift

struct ApartmentTypeModel {
    var title: String
    var types: [(name: String, selected: Bool)]
    var type: Filter
}

class ApartmentTypeCellViewModel {
    
    private var model: ApartmentTypeModel
    
    var itemSelected: PublishSubject<Int> = PublishSubject<Int>()
    var filterString: PublishSubject<String> = PublishSubject<String>()
    var titleString: Variable<String> = Variable<String>("")
    var items: Variable<[TagModel]> = Variable<[TagModel]>([])
    
    private let bag = DisposeBag()
    
    init(model: ApartmentTypeModel) {
        self.model = model
        
        // prepare filter based on selection
        itemSelected.subscribe(onNext: { [unowned self] index in
            let state = self.model.types[index].selected
            self.model.types[index].selected = !state
            
            self.prepareItems()
            
            var apiString = ""
            for type in self.model.types where type.selected == true {
                var value = ""
                switch self.model.type {
                case .apartmentType:
                    value = ApartmentType(rawValue: type.name)?.getAPIValue() ?? ""
                case .furnishing:
                    value = Furnishing(rawValue: type.name)?.getAPIValue() ?? ""
                case .propertyType:
                    value = Property(rawValue: type.name)?.getAPIValue() ?? ""
                }
                if apiString != "" {
                    apiString += "/\(value)"
                } else {
                    apiString = value
                }
            }
            self.filterString.onNext(apiString)
        }).disposed(by: bag)
        
        prepareItems()
        
        titleString.value = model.title
    }
    
    func prepareItems() {
        items.value = model.types.map({ (name, state) -> TagModel in
            return TagModel(name: name, selected: state)
        })
    }
}
