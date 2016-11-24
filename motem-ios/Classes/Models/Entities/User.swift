//
//  User.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/17/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class User: Mappable {
    
    var name: String?
    var email: String?
    var imageURL: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        email <- map["email"]
        imageURL <- map["imageUrl"]
    }
}
