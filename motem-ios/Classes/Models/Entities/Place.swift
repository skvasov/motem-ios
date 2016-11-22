//
//  Place.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/22/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation
import SwiftyJSON

class Place {
    
    var name: String?
    var imageURL: String?
    
    init(json: JSON) {
        
        self.name = json["name"].stringValue
        self.imageURL = json["imageUrl"].stringValue
    }
}
