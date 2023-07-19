//
//  ViewController.swift
//  KakaoMap
//
//  Created by EUNSUNG on 2023/07/17.
//
// 내 위치로 가는 기능
// 주소 적으면 위도, 경도로 바꿔서 핀 찍어주는 기능
import UIKit

class ViewController: UIViewController {
    
    var mapView:MTMapView!
    @IBOutlet var mapSubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMapView()
        createPin(itemName: "롯데월드", mapPoint: MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.511545, longitude: 127.098609)), markerType: .redPin)
        
        //mapView.fitAreaToShowAllPOIItems()
    }
    
    @IBAction func onTrackMyLocation(_ sender: Any) {
        trackMyLocation()
    }
}

extension ViewController: MTMapViewDelegate {
    // 맵 생성
    func setupMapView() {
        mapView = MTMapView(frame: mapSubView.bounds)
        mapView.delegate = self
        mapView.baseMapType = .standard
        mapSubView.addSubview(mapView)
    }
    // 핀 생성
    func createPin(itemName:String, mapPoint:MTMapPoint, markerType:MTMapPOIItemMarkerType) {
        let poiItem = MTMapPOIItem()
        
        poiItem.itemName = "\(itemName)"
        poiItem.mapPoint = mapPoint
        poiItem.markerType = markerType
        
        mapView.addPOIItems([poiItem])
    }
    // 내 위치로 트래킹
    func trackMyLocation() {
        mapView.showCurrentLocationMarker = true
        mapView.currentLocationTrackingMode = .onWithoutHeading
    }
    
    // Custom: 현 위치 트래킹 함수
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocation = location?.mapPointGeo()
        if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{
            print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
        }
    }
    
    func mapView(_ mapView: MTMapView?, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle)) degrees")
    }
}


