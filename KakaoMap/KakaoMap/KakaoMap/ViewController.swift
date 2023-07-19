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
        
        setupMapView()
        createPin(itemName: "롯데월드", mapPoint: MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.511545, longitude: 127.098609)), markerType: .yellowPin)
        
        mapView.fitAreaToShowAllPOIItems()
    }
    // 맵 생성
    func setupMapView() {
        mapView = MTMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)
    }
    // 핀 생성
    func createPin(itemName:String, mapPoint:MTMapPoint, markerType:MTMapPOIItemMarkerType) {
        let poiItem = MTMapPOIItem()
        
        poiItem.itemName = "\(itemName)"
        poiItem.mapPoint = mapPoint
        poiItem.markerType = markerType
        
        mapView.addPOIItems([poiItem])
    }
    
}

