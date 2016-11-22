//
//  PlaceCell.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/22/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import UIKit

protocol PlaceCellDelegate: class {
    
    func placeCellWillPrepareForReuse(cell: PlaceCell)
}

class PlaceCell: UICollectionViewCell {
    
    static let ReuseIdentifier: String = "PlaceCellReuseIdentifier"
    
    @IBOutlet weak var backgroundImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    
    weak var delegate: PlaceCellDelegate?

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        if let delegate = self.delegate {
            
            delegate.placeCellWillPrepareForReuse(cell: self)
        }
    }
}
