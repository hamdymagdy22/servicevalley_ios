//
//  editLocation.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 4/24/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import iOSDropDown

class editLocation: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var addressName: UITextField!
   
    @IBOutlet weak var cityDropDown: DropDown!
    
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var buildingNumber: UITextField!
    @IBOutlet weak var flatNumber: UITextField!
    @IBOutlet weak var saveChangeBtn: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "تعديل العنوان"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if revealViewController() != nil {
//
//
//            barBtn.target = revealViewController()
//            barBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
//
//
//        }
         cityDropDown.optionArray = ["المدينة المنورة","مكة","الرياض","جدة"]
        
       

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
         self.hideKeyboardWhenTappedAround()
        super.title = "تعديل العنوان"
        
        if isMapped(){
            
        
        guard let cityName1 = helper.getcityName() else {
            
            return
        }
        guard let addressName1 = helper.getaddressName() else {
         
            return
        }
        guard let streetName1 = helper.getstreetName() else {
           
            return
        }
        guard let buildingNumber1 = helper.getbuildingNumber() else {
            return
        }
        guard let flatNumber1 = helper.getflatNumber() else {
            return
        }
            addressName.text = addressName1
            cityDropDown.text = cityName1
            streetName.text = streetName1
            buildingNumber.text = buildingNumber1
            flatNumber.text = flatNumber1
        }
        
        streetName.delegate = self
        cityDropDown.delegate = self
        addressName.delegate = self
        buildingNumber.delegate = self
        flatNumber.delegate = self
        addressName.tag = 0
        cityDropDown.tag = 0
        streetName.tag = 0
        buildingNumber.tag = 0
        flatNumber.tag = 0
        
        streetName.returnKeyType = .done
     cityDropDown.returnKeyType = .done
        addressName.returnKeyType = .done
        buildingNumber.returnKeyType = .done
        flatNumber.returnKeyType = .done

        
       
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
     
        
        // Do any additional setup after loading the view.
      
        cityDropDown.listWillAppear {
            self.streetName.isHidden = true
            self.buildingNumber.isHidden = true
           
        }
        cityDropDown.listWillDisappear {
            self.streetName.isHidden = false
            self.buildingNumber.isHidden = false
            
        }
    }
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 100)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 100)
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
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        else
        {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
        }
        // Do not add a line break
        return false
    }
    
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    fileprivate func isMapped() -> Bool {
        return UserDefaults.standard.bool(forKey: "isMapped")
    }
    
    @IBAction func goToMapTapped(_ sender: Any) {
        let addressName = self.addressName.text!
        
        let cityName = self.cityDropDown.text!
        let streetName = self.streetName.text!
        let buildingNumber = self.addressName.text!
        let flatNumber = self.flatNumber.text!
        let l_description =  "\(cityName)-شارع \(streetName)"
        let def = UserDefaults.standard
        def.setValue(cityName, forKey: "cityName")
        def.setValue(streetName, forKey: "streetName")
        def.setValue(buildingNumber, forKey: "buildingNumber")
        def.setValue(flatNumber, forKey: "flatNumber")
        def.setValue(addressName, forKey: "addressName")
        def.setValue(true, forKey: "isMapped")
        def.synchronize()
        self.performSegue(withIdentifier: "goToMap", sender: self)
        
    }
    
    
    @IBAction func saveChangeTapped(_ sender: Any) {
        let addressName = self.addressName.text!

        let cityName = self.cityDropDown.text!
        let streetName = self.streetName.text!
        let buildingNumber = self.addressName.text!
        let flatNumber = self.flatNumber.text!
        let l_description =  "\(cityName)-شارع \(streetName)"
        let def = UserDefaults.standard
        def.setValue(cityName, forKey: "cityName")
        def.setValue(streetName, forKey: "streetName")
        def.setValue(buildingNumber, forKey: "buildingNumber")
        def.setValue(flatNumber, forKey: "flatNumber")
        def.setValue(addressName, forKey: "addressName")
        def.setValue(false, forKey: "isMapped")
        def.synchronize()
      
        if (addressName.isEmpty || (cityName.isEmpty) || (streetName.isEmpty) || (buildingNumber.isEmpty)) || (flatNumber.isEmpty)
        {
            AlertManager.showAlert("يجب ادخال جميع البيانات", inViewController:self)
            return;
        }
            
        else
            
        {
            API.editAddress(l_name: addressName, l_building_number: buildingNumber, l_flat_number: flatNumber, l_area: cityName, l_flag: "0",l_description:l_description ){ ( error : Error?, success : Bool) in
                if success {
                    AlertManager.showAlert("تم تغيير البيانات بنجاح", inViewController:self)
                   
                    UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
                    
        }
                else{
                    AlertManager.showAlert("عليك التاكد من وضع جميع البيانات واختيار المكان ", inViewController:self)
                    
                }
    }
    

}
}
}
