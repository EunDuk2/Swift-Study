//
//  ViewController.swift
//  KakaoMap
//
//  Created by EUNSUNG on 2023/07/17.
//
// 내 위치로 가는 기능
// 핀 버튼
// 확대 축소 기능
// 주소 적으면 위도, 경도로 바꿔서 핀 찍어주는 기능
import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var mapView:MTMapView!
    @IBOutlet var mapSubView: UIView!
    @IBOutlet var textField: UITextField!
    var zoomLv:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMapView()
        createPin(itemName: "롯데월드", mapPoint: MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.511545, longitude: 127.098609)), markerType: .redPin)
        
        mapView.fitAreaToShowAllPOIItems()
        // 기본 확대 레벨 설정
        mapView.setZoomLevel(0, animated: true)
    }
    
    func addPinForAddress(_ address: String) {
        // 지리적인 정보를 처리하는 CLGeocoder 사용
        let geocoder = CLGeocoder()
        // 주소를 지리적인 정보로 변환하고
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error { // 변환 중 오류가 발생하면 오류 메시지 출력
                print("Error geocoding address: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first,
                      let location = placemark.location { // 변환된 지리 정보로 위치 저장
                // 주소를 위도와 경도로 변환한 위치에 핀을 생성
                self.createPin(itemName: address, mapPoint: MTMapPoint(geoCoord: MTMapPointGeo(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                , markerType: .redPin)
                // 핀이 찍힌 위치로 이동
                self.mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)), animated: true)
            }
        }
    }
    @IBAction func onSearch(_ sender: Any) {
        addPinForAddress(textField.text!)
    }
    
    @IBAction func onTrackMyLocation(_ sender: Any) {
        trackMyLocation()
    }
    @IBAction func onStepper(_ sender: UIStepper) {
        if(zoomLv < sender.value) { // + 버튼 터치시 확대
            mapView.setZoomLevel(mapView.zoomLevel - 1, animated: true)
        } else { // - 버튼 터치시 축소
            mapView.setZoomLevel(mapView.zoomLevel + 1, animated: true)
        }
        zoomLv = sender.value
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
    func createPin(itemName: String, mapPoint: MTMapPoint, markerType: MTMapPOIItemMarkerType) {
        let poiItem = MTMapPOIItem()
        poiItem.itemName = "\(itemName)"
        poiItem.mapPoint = mapPoint
        poiItem.markerType = markerType
        
        // 커스텀 뷰를 생성하여 버튼을 추가
        let customCalloutView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        customCalloutView.backgroundColor = .white
        
        // 뷰에 레이블을 추가하고 itemName출력
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.textColor = .black
        label.textAlignment = .center
        label.text = "\(itemName)"
        
        customCalloutView.addSubview(label)
        
        // 커스텀 콜아웃 뷰 설정
        poiItem.customCalloutBalloonView = customCalloutView
        
        mapView.addPOIItems([poiItem])
    }

    // 내 위치로 트래킹
    func trackMyLocation() {
        // 사용자 위치에 마커 찍기
        mapView.showCurrentLocationMarker = true
        // 사용자 위치로 지도가 이동, 사용자가 움직이면 지도도 따라감
        mapView.currentLocationTrackingMode = .onWithoutHeading
    }
    // 말풍선을 터치했을 때 액션
    func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
        // 웹뷰를 담고 있는 컨트롤러를 푸시
        let ViewController2 = storyboard!.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        navigationController?.pushViewController(ViewController2, animated: true)
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


