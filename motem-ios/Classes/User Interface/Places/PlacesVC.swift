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
import DGElasticPullToRefresh

class PlacesVC: ViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PlaceCellControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var currentPage = 0
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
        
        if let collectionView = self.collectionView {

            collectionView.collectionViewLayout = self.layout
            collectionView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellWithReuseIdentifier: PlaceCell.ReuseIdentifier)
            
            let loadingView = DGElasticPullToRefreshLoadingViewCircle()
            loadingView.tintColor = UIColor.black
            
            collectionView.dg_addPullToRefreshWithActionHandler({ [unowned self] in
            
                self.currentPage = 0
                self.cellControllers = []
                self.loadNextPage()
                
            }, loadingView: loadingView)
            
            collectionView.dg_setPullToRefreshFillColor(UIColor.white)
            collectionView.dg_setPullToRefreshBackgroundColor(UIColor.white)
        }
        
        self.loadNextPage()
    }
    
    func loadNextPage() {
        
        self.currentPage += 1
        
        if let client = self.client {
            
            HUD.show(HUDContentType.systemActivity)
            
            let params: [String : Any] = ["page": self.currentPage,
                                          "perPage": 25]
            
            client.sessionManager.request(PlaceRouter.search(parameters: params)).responseArray(keyPath: "places") { [weak self] (response: DataResponse<[Place]>) in
                
                HUD.hide()
                
                guard let weakSelf = self else {
                    
                    return
                }
                
                switch response.result {
                    
                case .success:
                    
                    guard let places = response.result.value else {
                        
                        weakSelf.showDataLoadingError(error: nil)
                        return
                    }
                    
                    let cellControllers = places.map({ (place) -> PlaceCellController in
                        
                        let cellController = PlaceCellController(place: place)
                        cellController.delegate = weakSelf
                        return cellController
                    })
                    
                    weakSelf.cellControllers.append(contentsOf: cellControllers)
                    
                    if let collectionView = weakSelf.collectionView {

                        collectionView.reloadData()
                        collectionView.dg_stopLoading()
                    }
                    
                case .failure(let error):
                    
                    weakSelf.showDataLoadingError(error: error)
                }
            }
        }
    }
    
    func showDataLoadingError(error: Error?) {
    
        print("fail")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        
        if let collectionView = self.collectionView {
        
            collectionView.dg_removePullToRefresh()
        }
    }
}
