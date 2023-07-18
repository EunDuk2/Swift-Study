//
//  ViewController.swift
//  KakaoMap
//
//  Created by EUNSUNG on 2023/07/17.
//

import UIKit

class ViewController: UIViewController, MTMapViewDelegate {
    
    var mapView:MTMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView = MTMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)
        
        let poiItem1 = MTMapPOIItem()
        
        poiItem1.itemName = "롯데월드"
        poiItem1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.511545, longitude: 127.098609))
        poiItem1.markerType = .redPin
        
        mapView.addPOIItems([poiItem1])
        
        //mapView.fitAreaToShowAllPOIItems()
    }

}

