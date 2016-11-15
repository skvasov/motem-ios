//
//  LoginVC.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/15/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import UIKit

class LoginVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Actions

    @IBAction func login(sender: AnyObject) {
        
        if let client = self.client {
            
            client.authenticator.state = .Authorized
        }
    }

}
