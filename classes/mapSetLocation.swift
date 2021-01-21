//
//  mapSetLocation.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/27/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import GooglePlacePicker
import GoogleMaps
import GooglePlaces
import iOSDropDown

class mapSetLocation: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var addressTitleTF: UITextField!
    @IBOutlet weak var buildingNumberTF: UITextField!
    @IBOutlet weak var flatNumberTF: UITextField!
    @IBOutlet weak var locationDiscriptionTF: UITextField!
    @IBOutlet weak var chooseBuilding: DropDown!
 
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide the back Item navigation
        navigationItem.hidesBackButton = true
        // creat new back button in right side
        let backButton1 = UIBarButtonItem(title: " أختر المدينة ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
         navigationItem.leftBarButtonItem?.tintColor = UIColor(red:0.33, green:0.72, blue:0.62, alpha:1.0)
        
        
       
//        var attributes = [String: AnyObject]()
//        attributes[NSForegroundColorAttributeName] = UIColor.red
//        navigationController?.navigationBar.titleTextAttributes = attributes
        //
        addressTitleTF.delegate = self
        buildingNumberTF.delegate = self
        flatNumberTF.delegate = self
        chooseBuilding.delegate = self
    
        locationDiscriptionTF.delegate = self
        
        addressTitleTF.tag = 0
        buildingNumberTF.tag = 0
        flatNumberTF.tag = 0
        locationDiscriptionTF.tag = 0
        addressTitleTF.returnKeyType = .next
        buildingNumberTF.returnKeyType = .next
        flatNumberTF.returnKeyType = .next
        locationDiscriptionTF.returnKeyType = .next
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        scrollView.contentSize = CGSize(width: 100.0, height: 200)
        scrollView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.getPlacePickerView()
        self.viewContainer.isHidden = true
        addressTitleTF.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        addressTitleTF.layer.borderWidth = 0.5
        addressTitleTF.layer.cornerRadius = 5
        buildingNumberTF.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        buildingNumberTF.layer.borderWidth = 0.5
        buildingNumberTF.layer.cornerRadius = 5
        flatNumberTF.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        flatNumberTF.layer.borderWidth = 0.5
        flatNumberTF.layer.cornerRadius = 5
        locationDiscriptionTF.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        locationDiscriptionTF.layer.borderWidth = 0.5
        locationDiscriptionTF.layer.cornerRadius = 5
        chooseBuilding.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        chooseBuilding.layer.borderWidth = 0.5
        chooseBuilding.layer.cornerRadius = 5
        backButton.layer.borderWidth = 0.5
        backButton.layer.cornerRadius = 5
        confirmButton.layer.borderWidth = 0.5
        confirmButton.layer.cornerRadius = 5
        addressTitleTF.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        buildingNumberTF.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        flatNumberTF.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        locationDiscriptionTF.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        confirmButton.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        backButton.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        chooseBuilding.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        let color = UIColor.white
        addressTitleTF.attributedPlaceholder = NSAttributedString(string: addressTitleTF.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        buildingNumberTF.attributedPlaceholder = NSAttributedString(string: buildingNumberTF.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        flatNumberTF.attributedPlaceholder = NSAttributedString(string: flatNumberTF.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        locationDiscriptionTF.attributedPlaceholder = NSAttributedString(string: locationDiscriptionTF.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        chooseBuilding.attributedPlaceholder = NSAttributedString(string: locationDiscriptionTF.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        
        // Do any additional setup after loading the view.
        chooseBuilding.optionArray = ["شقة", "فيلا"]
      
    }// move text up
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
    
        animateViewMoving(up: true, moveValue: 120)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        animateViewMoving(up: false, moveValue: 120)
    }
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    var activeField:UITextField?
  var lastOffset:CGPoint?

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        activeField = textField
        
        lastOffset = self.scrollView.contentOffset
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeField?.resignFirstResponder()
        
        activeField = nil
    
        return true
        
    }
    
    fileprivate func addressTwo() -> Bool {
        return UserDefaults.standard.bool(forKey: "addressTwo")
    }
    
    var keyboardHeight:CGFloat = 0.0
   // var constraintContentHeight:Int
    
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    func keyboardWillShow(notification: NSNotification) {
        
        if keyboardHeight != nil {
            
            return
            
        }
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            keyboardHeight = keyboardSize.height
            
            // so increase contentView's height by keyboard height
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.contentHeightConstraint.constant += self.keyboardHeight
                
            })
            
            // move if keyboard hide input field
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                
                // scroll to the position above keyboard 10 points
                
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset!.x, y: collapseSpace + 10)
                
            })
        }
    }
    @objc func backTapped(sender: AnyObject) {
        // bact to last View Controller
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "myAddress") as! myAddress
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
    }
    
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    
    @IBAction func search(_ sender: Any) {
        self.viewContainer.isHidden = true
        self.getPlacePickerView()
    }
//    private func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//        // Try to find next responder
//        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//        } else {
//            // Not found, so remove keyboard.
//            textField.resignFirstResponder()
//            self.hideKeyboardWhenTappedAround()
//        }
//
//        // Do not add a line break
//        return false
//    }
//
    
    @IBAction func nextPageTapped(_ sender: Any) {
        let address = addressTitleTF.text!
        let buildingNo = buildingNumberTF.text!
        let flat = flatNumberTF.text!
        let locationDiscription = locationDiscriptionTF.text!
       
        
        if (address.isEmpty || (buildingNo.isEmpty) || (flat.isEmpty) || (locationDiscription.isEmpty))
        {
            //Display the messsage
            // displayMyAlertMessage( userMessage: "All Field are required")
            return;
        }
        let def = UserDefaults.standard
        def.setValue(address, forKey: "l_name")
        def.setValue(buildingNo, forKey: "buildingNo")
        def.setValue(flat, forKey: "flat")
        def.setValue(locationDiscription, forKey: "locationDiscription")
        def.synchronize()
        API.addNewAddress { (error:Error?, addNewAddress: userLocations?) in
            
        }
        if addressTwo()
        {
            
            let def = UserDefaults.standard
            def.setValue(false, forKey: "addressTwo")
            def.synchronize()
            let revealviewcontroller:SWRevealViewController = self.revealViewController()
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "AddressHistory") as! AddressHistory
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }
        else
        {
            let revealviewcontroller:SWRevealViewController = self.revealViewController()
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "myAddress") as! myAddress
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
        

    }
    
    
   

}
extension mapSetLocation : GMSPlacePickerViewControllerDelegate
{
   //  GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        self.viewContainer.isHidden = false
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
        }

    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {

        viewController.dismiss(animated: true, completion: nil)

        self.viewContainer.isHidden = true
        self.indicatorView.isHidden = true
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "myAddress") as! myAddress
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
