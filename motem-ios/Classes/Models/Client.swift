//
//  Client.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/15/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation

class Client: NSObject {
    
    var authenticator: Authenticator
    
    override init() {
        
        self.authenticator = Authenticator()
    }
}
