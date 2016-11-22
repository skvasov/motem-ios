//
//  MainVC.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/15/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import UIKit

class MainVC: ViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let controller = PlacesVC(client: self.client)
        self.present(controller, animated: true, completion: nil)
    }
}
