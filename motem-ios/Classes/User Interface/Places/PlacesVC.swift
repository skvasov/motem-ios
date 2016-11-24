//
//  PlacesVC.swift
//  motem-ios
//
//  Created by Sergei Kvasov on 11/22/16.
//  Copyright © 2016 Mobexs.com. All rights reserved.
//

import UIKit
import PKHUD
import AlamofireObjectMapper
import Alamofire

class PlacesVC: ViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PlaceCellControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var cellControllers: [PlaceCellController] = []
    
    // MARK: - Lazy getters
    
    lazy var layout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.collectionView?.collectionViewLayout = self.layout
        self.collectionView?.register(UINib(nibName: "PlaceCell", bundle: nil), forCellWithReuseIdentifier: PlaceCell.ReuseIdentifier)
        
        if let client = self.client {
            
            HUD.show(HUDContentType.systemActivity)
            
            let params = ["q": "burger"]
            
            client.sessionManager.request(PlaceRouter.search(parameters: params)).responseArray(keyPath: "places") { (response: DataResponse<[Place]>) in
                
                HUD.hide()
                
                switch response.result {
                    
                case .success:
                    
                    guard let places = response.result.value else {
                        
                        return
                    }
                    
                    let cellControllers = places.map({ (place) -> PlaceCellController in
                        
                        let cellController = PlaceCellController(place: place)
                        cellController.delegate = self
                        return cellController
                    })
                    
                    self.cellControllers.append(contentsOf: cellControllers)
                    self.collectionView?.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.cellControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCell.ReuseIdentifier, for: indexPath) as! PlaceCell
        
        let cellController = self.cellControllers[indexPath.item]
        cellController.cell = cell
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width, height: 200)
    }
    
    // MARK: - PlaceCellControllerDelegate
}
