//
//  Place.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/22/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

class Place: Mappable {
    
    var name: String?
    var imageURL: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        imageURL <- map["imageURL"]
    }
}
