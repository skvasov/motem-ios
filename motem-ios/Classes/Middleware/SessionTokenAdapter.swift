//
//  SessionTokenAdapter.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/21/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import Alamofire

class SessionTokenAdapter: RequestAdapter {
    
    private let sessionToken: String
    
    init(sessionToken: String) {
        
        self.sessionToken = sessionToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer" + self.sessionToken, forHTTPHeaderField: "Authrization")
        return urlRequest
    }
}
