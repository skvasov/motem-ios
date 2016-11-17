//
//  User.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/17/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    var name: String?
    var email: String?
    var imageURL: String?
    
    init(json json: JSON) {
        
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        self.imageURL = json["imageUrl"].stringValue
    }
}
