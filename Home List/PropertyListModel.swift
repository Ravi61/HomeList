//
//  PropertyListModel.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation

struct PropertyListModel: Codable {

    let data: [PropertyData]?
    let message: String?
    let otherParams: OtherParam?
    let status: Int?
    let statusCode: Int?
}

struct OtherParam: Codable {

    let city: String?
    let count: Int?
    let regionId: String?
    let searchToken: String?
    let topPropertyId: String?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case city
        case count
        case regionId = "region_id"
        case searchToken
        case topPropertyId
        case totalCount = "total_count"
    }
}

struct PropertyData: Codable {

    let accomodationType: String?
    let accomodationTypeDesc: String?
    let accurateLocation: Bool?
    let activationDate: Int?
    let active: Bool?
    let adminEvent: String?
    let amenities: String?
    let amenitiesMap: AmenitiesMap?
    let availableFrom: Int?
    let balconies: Int?
    let bathroom: Int?
    let buildingId: String?
    let buildingType: String?
    let city: String?
    let creationDate: Int?
    let cupBoard: Int?
    let dateOnly: Int?
    let deposit: Int?
    let description: String?
    let detailUrl: String?
    let facing: String?
    let facingDesc: String?
    let floor: Int?
    let forLease: Bool?
    let furnishing: String?
    let furnishingDesc: String?
    let gym: Bool?
    let id: String?
    let inactiveReason: String?
    let inactiveReasonDesc: String?
    let lastActivationDate: Date?
    let lastUpdateDate: Int?
    let latitude: Float?
    let leaseType: String?
    let lift: Bool?
    let loanAvailable: Bool?
    let locality: String?
    let localityId: String?
    let location: String?
    let longitude: Float?
    let managed: String?
    let nbLocality: String?
    let negotiable: Bool?
    let ownerId: String?
    let ownerName: String?
    let parking: String?
    let parkingDesc: String?
    let photoAvailable: Bool?
    let photos: [Photo]?
    let pinCode: Int?
    let powerBackup: String?
    let propertyAge: Int?
    let propertyCode: String?
    let propertySize: Int?
    let propertyTitle: String?
    let propertyType: String?
    let rent: Int?
    let score: Score?
    let secondaryTitle: String?
    let sharedAccomodation: Bool?
    let shortUrl: String?
    let shortlistedByLoggedInUser: Bool?
    let society: String?
    let sponsored: Bool?
    let street: String?
    let swimmingPool: Bool?
    let tenantTypeDesc: String?
    let title: String?
    let totalFloor: Int?
    let type: String?
    let typeDesc: String?
    let waterSupply: String?
}

struct Photo: Codable {

    let displayPic: Bool?
    let imagesMap: ImagesMap?
    let name: String?
    let title: String?
}

struct ImagesMap: Codable {

    let large: String?
    let medium: String?
    let original: String?
    let thumbnail: String?
}

struct AmenitiesMap: Codable {

    let AC: Bool?
    let CLUB: Bool?
    let CPA: Bool?
    let FS: Bool?
    let GP: Bool?
    let GYM: Bool?
    let HK: Bool?
    let INTERCOM: Bool?
    let INTERNET: Bool?
    let LIFT: Bool?
    let PARK: Bool?
    let PB: Bool?
    let POOL: Bool?
    let RWH: Bool?
    let SC: Bool?
    let SECURITY: Bool?
    let SERVANT: Bool?
    let STP: Bool?
    let VP: Bool?
}

struct Score : Codable {
    
    let lastUpdatedDate : Int?
    let lifestyle : Float?
    let transit : Float?
}
