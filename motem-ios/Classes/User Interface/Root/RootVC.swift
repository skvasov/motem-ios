//
//  RootVC.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/15/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import UIKit

class RootVC: ViewController {
    
    var viewController: ViewController?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Observable
        if let client = self.client {
            
            client.authenticator.addObserver(self, forKeyPath: "state", options: .new, context: nil)
        }

        authenticatorStateDidChange()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        if let viewController = self.viewController {
            
            viewController.view.frame = self.view.bounds
        }
    }
    
    // MARK: - KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let keyPath = keyPath {
            
            if (keyPath == "state") {
                
                self.authenticatorStateDidChange()
            }
        }
    }
    
    // MARK: - Logic

    func authenticatorStateDidChange() {
        
        var newViewController: ViewController?
        
        if let client = self.client {
            
            switch client.authenticator.state {
                
            case .Unauthorized:
                newViewController = LoginVC(client: client)
            case .Authorized:
                newViewController = MainVC(client: client)
            }
        }
        
        if let viewController = self.viewController {
            
            viewController.willMove(toParentViewController: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
        }
        
        self.viewController = newViewController;
        
        if let viewController = self.viewController {
            
            self.addChildViewController(viewController)
            self.view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }
    
    // MARK: - Clear
    
    deinit {
        
        if let client = self.client {
            
            client.authenticator.removeObserver(self, forKeyPath: "state")
        }
    }
}
