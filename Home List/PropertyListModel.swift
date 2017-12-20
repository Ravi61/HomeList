//
//  PropertyListModel.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation

struct PropertyListModel: Codable {
    
    let data : [PropertyData]?
    let message : String?
    let otherParams : OtherParam?
    let status : Int?
    let statusCode : Int?
}

struct OtherParam: Codable {
    
    let city : String?
    let count : Int?
    let regionId : String?
    let searchToken : AnyObject?
    let topPropertyId : AnyObject?
    let totalCount : Int?
    
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
    
    let accomodationType : String?
    let accomodationTypeDesc : String?
    let accurateLocation : Bool?
    let activationDate : Int?
    let active : Bool?
    let adminEvent : String?
    let amenities : String?
    let amenitiesMap : AmenitiesMap?
    let availableFrom : Int?
    let balconies : Int?
    let bathroom : Int?
    let buildingId : AnyObject?
    let buildingType : String?
    let city : String?
    let creationDate : Int?
    let cupBoard : Int?
    let dateOnly : Int?
    let deposit : Int?
    let descriptionField : String?
    let detailUrl : String?
    let facing : String?
    let facingDesc : String?
    let floor : Int?
    let forLease : AnyObject?
    let furnishing : String?
    let furnishingDesc : String?
    let gym : Bool?
    let id : String?
    let inactiveReason : AnyObject?
    let inactiveReasonDesc : AnyObject?
    let lastActivationDate : AnyObject?
    let lastUpdateDate : Int?
    let latitude : Float?
    let leaseType : String?
    let lift : Bool?
    let loanAvailable : Bool?
    let locality : String?
    let localityId : String?
    let location : String?
    let longitude : Float?
    let managed : AnyObject?
    let nbLocality : String?
    let negotiable : Bool?
    let ownerId : String?
    let ownerName : String?
    let parking : String?
    let parkingDesc : String?
    let photoAvailable : Bool?
    let photos : [Photo]?
    let pinCode : Int?
    let powerBackup : String?
    let propertyAge : Int?
    let propertyCode : AnyObject?
    let propertySize : Int?
    let propertyTitle : String?
    let propertyType : String?
    let rent : Int?
    let score : AnyObject?
    let secondaryTitle : String?
    let sharedAccomodation : Bool?
    let shortUrl : String?
    let shortlistedByLoggedInUser : Bool?
    let society : String?
    let sponsored : Bool?
    let street : String?
    let swimmingPool : Bool?
    let tenantTypeDesc : String?
    let title : String?
    let totalFloor : Int?
    let type : String?
    let typeDesc : String?
    let waterSupply : String?
    
    
    enum CodingKeys: String, CodingKey {
        case accomodationType = "accomodationType"
        case accomodationTypeDesc = "accomodationTypeDesc"
        case accurateLocation = "accurateLocation"
        case activationDate = "activationDate"
        case active = "active"
        case adminEvent = "adminEvent"
        case amenities = "amenities"
        case amenitiesMap
        case availableFrom = "availableFrom"
        case balconies = "balconies"
        case bathroom = "bathroom"
        case buildingId = "buildingId"
        case buildingType = "buildingType"
        case city = "city"
        case creationDate = "creationDate"
        case cupBoard = "cupBoard"
        case dateOnly = "dateOnly"
        case deposit = "deposit"
        case descriptionField = "description"
        case detailUrl = "detailUrl"
        case facing = "facing"
        case facingDesc = "facingDesc"
        case floor = "floor"
        case forLease = "forLease"
        case furnishing = "furnishing"
        case furnishingDesc = "furnishingDesc"
        case gym = "gym"
        case id = "id"
        case inactiveReason = "inactiveReason"
        case inactiveReasonDesc = "inactiveReasonDesc"
        case lastActivationDate = "lastActivationDate"
        case lastUpdateDate = "lastUpdateDate"
        case latitude = "latitude"
        case leaseType = "leaseType"
        case lift = "lift"
        case loanAvailable = "loanAvailable"
        case locality = "locality"
        case localityId = "localityId"
        case location = "location"
        case longitude = "longitude"
        case managed = "managed"
        case nbLocality = "nbLocality"
        case negotiable = "negotiable"
        case ownerId = "ownerId"
        case ownerName = "ownerName"
        case parking = "parking"
        case parkingDesc = "parkingDesc"
        case photoAvailable = "photoAvailable"
        case photos = "photos"
        case pinCode = "pinCode"
        case powerBackup = "powerBackup"
        case propertyAge = "propertyAge"
        case propertyCode = "propertyCode"
        case propertySize = "propertySize"
        case propertyTitle = "propertyTitle"
        case propertyType = "propertyType"
        case rent = "rent"
        case score = "score"
        case secondaryTitle = "secondaryTitle"
        case sharedAccomodation = "sharedAccomodation"
        case shortUrl = "shortUrl"
        case shortlistedByLoggedInUser = "shortlistedByLoggedInUser"
        case society = "society"
        case sponsored = "sponsored"
        case street = "street"
        case swimmingPool = "swimmingPool"
        case tenantTypeDesc = "tenantTypeDesc"
        case title = "title"
        case totalFloor = "totalFloor"
        case type = "type"
        case typeDesc = "typeDesc"
        case waterSupply = "waterSupply"
    }
}

struct Photo : Codable {

    let displayPic : Bool?
    let imagesMap : ImagesMap?
    let name : String?
    let title : String?
}

struct ImagesMap : Codable {
    
    let large : String?
    let medium : String?
    let original : String?
    let thumbnail : String?
}

struct AmenitiesMap : Codable {
    
    let AC : Bool?
    let CLUB : Bool?
    let CPA : Bool?
    let FS : Bool?
    let GP : Bool?
    let GYM : Bool?
    let HK : Bool?
    let INTERCOM : Bool?
    let INTERNET : Bool?
    let LIFT : Bool?
    let PARK : Bool?
    let PB : Bool?
    let POOL : Bool?
    let RWH : Bool?
    let SC : Bool?
    let SECURITY : Bool?
    let SERVANT : Bool?
    let STP : Bool?
    let VP : Bool?
}

