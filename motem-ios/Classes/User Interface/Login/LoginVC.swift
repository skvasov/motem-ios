//
//  LoginVC.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/15/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginVC: ViewController {
    
    @IBOutlet weak var usernameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showLoginError() {
        
    }
    
    func showEmptyFieldsError () {
    }

    // MARK: - Actions

    @IBAction func login(sender: AnyObject) {
        
        guard let username = self.usernameTextField?.text else {
            
            showEmptyFieldsError()
            return
        }
        
        guard let password = self.passwordTextField?.text else {
            
            showEmptyFieldsError()
            return
        }
        
        let params = ["username" : username,
                      "password" : password]
        
        Alamofire.request("http://otmburger.com/api/signup/login", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseData(completionHandler: { response in
            
            guard let data = response.result.value else {
                
                self.showLoginError()
                return
            }
            
            let json = JSON(data: data)
            let authentication = Authentication(json: json)
            
            if let client = self.client, let sessionToekn = authentication.sessionToken {
                
                client.authenticator.state = .Authorized
            }
        })
    }

}
