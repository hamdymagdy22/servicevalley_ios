//
//  mapViewDetails.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 11/4/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import iOSDropDown

class mapViewDetails: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var addressTitleTF: UITextField!
    @IBOutlet weak var buildingNumberTF: UITextField!
    @IBOutlet weak var flatNumberTF: UITextField!
    @IBOutlet weak var locationDiscriptionTF: UITextField!
    @IBOutlet weak var chooseBuilding: DropDown!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "اكمل البيانات"
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
         super.title = "اكمل البيانات"
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
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

        // Do any additional setup after loading the view.
    }
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
        
      //  lastOffset = self.scrollView.contentOffset
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeField?.resignFirstResponder()
        
        activeField = nil
        
        return true
        
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
    @IBAction func backTapped(_ sender: Any) {
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "myAddress") as! myAddress
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
    }
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    fileprivate func ifAddressTwo() -> Bool {
        return UserDefaults.standard.bool(forKey: "ifAddressTwo")
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
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
        if isLoggedIn(){
            if ifAddressTwo(){
                API.addNewAddress { (error:Error?, addNewAddress: userLocations?) in
                    
                }
                self.performSegue(withIdentifier: "goToAddressHistory", sender: self)
            }
            else
            {
                API.addNewAddress { (error:Error?, addNewAddress: userLocations?) in
                    
                }
                self.performSegue(withIdentifier: "goToMyAddresses", sender: self)
            }
        }
        
        else
        {
            AlertManager.showAlert("عليك التسجيل اولا", inViewController: self)
            print("AddressHistory Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "firstLogIn") as! firstLogIn
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealViewController().pushFrontViewController(newFrontController, animated: true)
            
        }
        
        
      
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
