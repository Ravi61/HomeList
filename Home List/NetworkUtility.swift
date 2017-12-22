//
//  NetworkUtility.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation

struct NetworkUtility {
    private static var baseURL = "http://www.nobroker.in/api/v1/"

    static func getPropertiesURL(withPage count: Int, apartmentFilter: String, propertyFilter: String, furnishingFilter: String) -> String {
        
        var postString = ""
        if apartmentFilter != "" {
            postString += "&type=\(apartmentFilter)"
        }
        if propertyFilter != "" {
            postString += "&buildingType=\(propertyFilter)"
        }
        if furnishingFilter != "" {
            postString = "&furnishing=\(furnishingFilter)"
        }
        
        let url = baseURL + "property/filter/region/ChIJLfyY2E4UrjsRVq4AjI7zgRY/?lat_lng=12.9279232,77.6271078&rent=0,500000&travelTime=30&pageNo=\(count)\(postString)"
        
        return url
    }
}
