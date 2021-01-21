//
//  newMapView.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/31/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces
import GoogleMaps
//import GooglePlacePicker

class newMapView: UIViewController {
   var marker: GMSMarker!
    
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
   // var locationManager = CLLocationManager()
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "اختر الموقع"
        
    
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = "اختر الموقع"
        sureBtn.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
     //   mapView.camera = GMSCameraPosition(target: locationManager.location!.coordinate, zoom: 20, bearing: 0, viewingAngle: 0)
       // self.show_marker(position: mapView.camera.target)
        self.mapView.delegate = self
        let polyLine: GMSPolyline = GMSPolyline()
        polyLine.isTappable = true
        mapView.isUserInteractionEnabled = true
        mapView.settings.setAllGesturesEnabled(true)
        mapView.settings.consumesGesturesInView = true
       
       
    }
    
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D, marker: GMSMarker) {
        
        // 1
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            
            //Add this line
            
            
            //Rest of response handling
        }
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                // 3
                let title = address.lines as [String]?
                marker.title = title?.first
                
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

  
    @IBAction func okTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
   
}



extension newMapView: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()

        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

    }

    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
let center = CLLocationCoordinate2D(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 20, bearing: 0, viewingAngle: 0)
self.mapView?.isMyLocationEnabled = true
        let marker = GMSMarker(position: center)
        
        print("Latitude :\(center.latitude)")
        print("Longitude :\(center.longitude)")
        
        marker.map = self.mapView
        marker.title = "Current Location"
        marker.isDraggable = true
        // 8
        locationManager.stopUpdatingLocation()
    }

}
extension newMapView : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("clicked on marker")
    }
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
         print("long press on marker")
    }
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 100))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        let title = UILabel(frame: CGRect.init(x: 0, y: 8, width: view.frame.width-16, height: 15))
        title.text = "Current Location"
        view.addSubview(title)
        return view
    }
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("dragging start")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("endDrag")
       
    }
    func mapView(_ mapView: GMSMapView!, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.title = "Hello World"
        marker.map = mapView
    }
    func mapView(_ mapView: GMSMapView!, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.delegate = self
        mapView.clear()
        
        let marker = GMSMarker(position: coordinate)
        marker.title = "Hello World"
        marker.map = mapView
        print("Tapped at coordinate: " + String(coordinate.latitude) + " "
            + String(coordinate.longitude))
        let  Latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let x = Double(Latitude)
        let y = Double(longitude)
        
        let def = UserDefaults.standard
        def.setValue(x, forKey: "Latitude")
        def.setValue(y, forKey: "Longitude")
        def.synchronize()
        
        // self.navigationController?.popViewController(animated: true)
    }
    
}
