//
//  Client.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/15/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import Alamofire

class Client: NSObject {
    
    static let BaseURL: String = "http://otmburger.com"
    
    let sessionManager: SessionManager
    let authenticator: Authenticator
    
    override init() {
        
        self.sessionManager = SessionManager()
        self.sessionManager.startRequestsImmediately = true
        
        self.authenticator = Authenticator()
    }
}
