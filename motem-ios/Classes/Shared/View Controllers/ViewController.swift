//
//  ViewController.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/15/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var client: Client?
    
    convenience init(client: Client?) {
        
        let xibName = NSStringFromClass(type(of: self))
        let path = Bundle.main.path(forResource: xibName, ofType: "xib")
        
        if let path = path {
            
            if (path.characters.count > 0) {
                
                self.init(nibName: xibName, bundle: nil)
            }
            else {
                
                self.init()
            }
        }
        else {
            
            self.init()
        }
        
        self.client = client
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

