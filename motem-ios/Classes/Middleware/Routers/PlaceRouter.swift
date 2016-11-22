//
//  PlaceRouter.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/22/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import Alamofire

enum PlaceRouter: URLRequestConvertible {
    
    case search(parameters: Parameters)
    
    var method: HTTPMethod {
        
        switch self {
            
        case .search:
            return .get
        }
    }
    
    var path: String {
        
        switch self {
            
        case .search:
            return "/api/places/search"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try Client.BaseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
            
        case .search(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }
        
        return urlRequest
    }
}
