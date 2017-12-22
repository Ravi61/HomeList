//
//  ResponseDecodable.swift
//  Home List
//
//  Created by Ravi on 21/12/17.
//  Copyright © 2017 No Broker. All rights reserved.
//

import Foundation
import Alamofire

public enum AlamofireDecodableError: Error {
    case invalidKeyPath
    case emptyKeyPath
}

extension AlamofireDecodableError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidKeyPath:   return "Nested object doesn't exist by this keyPath."
        case .emptyKeyPath:     return "KeyPath can not be empty."
        }
    }
}

extension DataResponse {
    
    func makeDecoder(orUse decoder: JSONDecoder?) -> JSONDecoder {
        var jsonDecoder = JSONDecoder()
        
        if let decoder = decoder {
            jsonDecoder = decoder
        } else {
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
        }
        
        return jsonDecoder
    }
    
    func mapObject<T: Decodable>(withDecoder decoder: JSONDecoder? = nil) throws -> T {
        do {
            let json = result.value as! [String: Any]
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return try makeDecoder(orUse: decoder).decode(T.self, from: data)
        } catch {
            throw AlamofireDecodableError.invalidKeyPath
        }
    }
}
