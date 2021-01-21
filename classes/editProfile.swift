//
//  editProfile.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 4/22/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit

import iOSDropDown

class editProfile: UIViewController, UITextFieldDelegate {
 
    var refresher : UIRefreshControl!
    var location_list = [userLocations]()
    var profile_list = [userData]()
     var jsonArray: [String] = []
    @IBOutlet weak var barBtn: UIBarButtonItem!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var dropDown: DropDown!
    
    @IBOutlet weak var saveChange: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            
            
            barBtn.target = revealViewController()
            barBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
            
            
        }
        self.title = "  تعديل الملف الشخصي "
        nameText.delegate = self
        phoneText.delegate = self
        emailText.delegate = self
       
        nameText.tag = 0
        phoneText.tag = 0
        emailText.tag = 0
        
        nameText.returnKeyType = .done
        phoneText.returnKeyType = .done
        emailText.returnKeyType = .done
       
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        handleRefresh()
       
        
        
        
     
        handleProfileData()
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
         navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        userPic.layer.cornerRadius = userPic.frame.height/2
       // addBtn.layer.cornerRadius = addBtn.frame.height/2
        saveChange.backgroundColor = UIColor.white
        saveChange.layer.cornerRadius = 15
        
        dropDown.listWillAppear {
            self.saveChange.isHidden = true
        }
        dropDown.listWillDisappear {
             self.saveChange.isHidden = false
            
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
    fileprivate func isFaceBookLogIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isFaceBookLogIn")
    }
    @IBAction func backTapped(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    func handleRefresh() {
        API.getUserLocations { (error: Error?, location_list:[userLocations]?) in
            if let location_list = location_list {
                for item in location_list {
                    let url = item.l_name
                    
                    self.jsonArray.append(url)
                }
                self.dropDown.optionArray = self.self.jsonArray
                if let refresher = self.refresher{
                    refresher.endRefreshing()
              
            }
        }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
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
    func handleProfileData() {
        
        API.getProfileData{ (error: Error?, profile_List: [userData]?) in
            if let profile_List = profile_List {
                self.profile_list = profile_List
                self.nameText.placeholder = self.profile_list.first!.name
                self.phoneText.placeholder = self.profile_list.first!.phone1
                self.emailText.text = self.profile_list.first!.email
                
                
                
            }
        }
    }
    
    @IBAction func updateMyDataBtn(_ sender: Any) {
        let newEmail = emailText.text
        let newPhone = phoneText.text
        let newName = nameText.text
        let email = self.profile_list.first!.email
       let phone = self.profile_list.first!.phone1
        let name = self.profile_list.first!.name
        let oldPassword = self.profile_list.first!.password
        let newPassword = ""
        API.updateUserData (newEmail: newEmail!, newName: newName! , newPhone: newPhone! , newPassword: newPassword, oldEmail: email , oldPhone: phone ,
                            oldName: name,oldPassword: oldPassword) { (error:Error?, user: [userData]) in
                                AlertManager.showAlert("تم تغيير معلوماتك الشخصية", inViewController: self)
                                
        
    }
         self.navigationController?.popViewController(animated: true)
        
    }

}
