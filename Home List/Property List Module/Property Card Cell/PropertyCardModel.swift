//
//  PropertyCardModel.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import RxSwift

struct PropertyCardModel {
    var name: String
    var address: String
    var amount: Int
    var furnishing: Furnishing
    var bathrooms: Int
    var area: Int
    var isFavourite: Variable<Bool> = Variable<Bool>(false)
    var isSponsored: Bool
    var imageURL: String

    init(name: String, address: String, amount: Int, furnishing: Furnishing,
         bathrooms: Int, area: Int, isFavourite: Bool, isSponsored: Bool, imageURL: String) {
        self.name = name
        self.address = address
        self.amount = amount
        self.furnishing = furnishing
        self.bathrooms = bathrooms
        self.area = area
        self.isSponsored = isSponsored
        self.isFavourite.value = isFavourite
        self.imageURL = imageURL
    }
}
