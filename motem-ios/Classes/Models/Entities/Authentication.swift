//
//  Authentication.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/17/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import SwiftyJSON

class Authentication {
    
    var profile: User?
    var sessionToken: String?
    
    init(json: JSON) {
        
        self.sessionToken = json["sessionToken"].stringValue
        self.profile = User(json: json["profile"])
    }
}
