//
//  Authenticator.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/15/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import Foundation

enum AuthenticatorState {
    
    case Unauthorized
    case Authorized
}

class Authenticator: NSObject {
    
    var state = AuthenticatorState.Unauthorized
    
}
