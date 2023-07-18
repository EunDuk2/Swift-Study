//
//  ViewController.swift
//  KakaoMap
//
//  Created by EUNSUNG on 2023/07/17.
//

import UIKit

class ViewController: UIViewController, MTMapViewDelegate {
    
    var mapView:MTMapView!
    var location1 = MTMapPointGeo(latitude: 37.555351847837, longitude: 126.93557855711)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView = MTMapView(frame: self.view.frame)
        
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)
        
        let poiItem1 = MTMapPOIItem()
        
        poiItem1.itemName = "회사"
        poiItem1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.555351847837, longitude: 126.93557855711))
        poiItem1.markerType = .redPin
        
        let poiItem2 = MTMapPOIItem()
        
        poiItem2.itemName = "우리집"
        poiItem2.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.481126679565, longitude: 126.94470156213))
        poiItem2.markerType = .redPin
        
        mapView.addPOIItems([poiItem1])
        mapView.addPOIItems([poiItem2])
    }


}

