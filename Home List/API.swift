//
//  API.swift
//  Home List
//
//  Created by Ravi on 20/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    enum Endpoint {
        case getProperties(withPage: Int)
        
        var method: HTTPMethod {
            switch self {
            case .getProperties:
                return .get
            }
        }
        
        var headers: [String: String]? {
            switch self {
            case .getProperties:
                return nil
            }
        }
        
        var encoding: ParameterEncoding {
            switch self {
            case .getProperties:
                return URLEncoding.default
            }
        }
        
        public var path: String {
            switch self {
            case let .getProperties(count):
                return NetworkUtility.getPropertiesURL(withPage: count)
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .getProperties:
                return nil
            }
        }
    }
    
    static func request(_ endpoint: API.Endpoint, completionHandler: @escaping (DataResponse<Data>) -> Void) {
        
        let manager = Alamofire.SessionManager.default
        manager.startRequestsImmediately = true
        manager.session.configuration.timeoutIntervalForRequest = 180 // seconds

        _ = manager.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: endpoint.headers).responseData { response in
            completionHandler(response)
        }        
    }
}
