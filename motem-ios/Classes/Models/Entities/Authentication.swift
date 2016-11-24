//
//  Authentication.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/17/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class Authentication: Mappable {
    
    var profile: User?
    var sessionToken: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        profile <- map["profile"]
        sessionToken <- map["sessionToken"]
    }
}
