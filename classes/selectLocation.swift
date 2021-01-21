//
//  selectLocation.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 5/21/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit

import GooglePlacePicker
import GoogleMaps
import GooglePlaces

class selectLocation: UIViewController {
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPlacePickerView()
        // Do any additional setup after loading the view.
        
        
    }
    

    func getPlacePickerView() {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        UINavigationBar.appearance().barTintColor = UIColor.white
        //        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 17)!]
        
        present(placePicker, animated: true, completion: nil)
    }

}
extension selectLocation : GMSPlacePickerViewControllerDelegate
{
    //  GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
       
     
        self.indicatorView.isHidden = true
        viewController.dismiss(animated: true, completion: nil)
        
        let  Latitude = place.coordinate.latitude
        let longitude = place.coordinate.longitude
        let x = Double(Latitude)
        let y = Double(longitude)
        
        let def = UserDefaults.standard
        def.setValue(x, forKey: "Latitude")
        def.setValue(y, forKey: "Longitude")
        def.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        
        viewController.dismiss(animated: true, completion: nil)
        
        
        self.indicatorView.isHidden = true
        
        self.navigationController?.popViewController(animated: true)
    }
}
