//
//  PlaceCellController.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/22/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import UIKit
import AlamofireImage

protocol PlaceCellControllerDelegate: class {
    
}

class PlaceCellController: PlaceCellDelegate {
    
    private(set) var place: Place
    weak var delegate: PlaceCellControllerDelegate?
    var cell: PlaceCell? {
        
        didSet {
            
            if let cell = self.cell {
                
                cell.delegate = self
            }
            self.updateContents()
        }
    }
    
    init(place: Place) {
        
        self.place = place
    }
    
    func updateContents() {
        
        if let cell = self.cell {
            
            cell.nameLabel?.text = self.place.name
            if let imageURL = self.place.imageURL, let url = URL(string: imageURL)  {

                cell.backgroundImageView?.af_setImage(withURL: url)
            }
        }
    }
    
    // MARK: - PlaceCellDelegate
    
    func placeCellWillPrepareForReuse(cell: PlaceCell) {
     
        if let cell  = self.cell {
            
            cell.nameLabel?.text = ""
            cell.backgroundImageView?.image = nil
        }
        
        self.cell = nil
    }
}
