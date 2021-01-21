//
//  changePassword.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 5/20/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit

class changePassword: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var pastPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var rePasswordTF: UITextField!
    @IBOutlet weak var BarMenu: UIBarButtonItem!
   
    @IBOutlet weak var saveChange: UIButton!
   
    @IBOutlet weak var bigView: UIView!
    var profile_list = [userData]()
    var refresher : UIRefreshControl!
    var user_list = [userData]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title =  "تغيير الباسورد "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            BarMenu.target = revealViewController()
            BarMenu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
        }
       let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        self.title =  "تغيير الباسورد "
        pastPasswordTF.delegate = self
        newPasswordTF.delegate = self
        rePasswordTF.delegate = self
        pastPasswordTF.tag = 0
        newPasswordTF.tag = 0
        rePasswordTF.tag = 0
        pastPasswordTF.returnKeyType = .done
        newPasswordTF.returnKeyType = .done
        rePasswordTF.returnKeyType = .done
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        handleRefresh()
        bigView.layer.cornerRadius = 15
        pastPasswordTF.layer.cornerRadius = 15
         newPasswordTF.layer.cornerRadius = 15
         rePasswordTF.layer.cornerRadius = 15
        saveChange.layer.borderWidth = 4
        saveChange.layer.cornerRadius = 15
        saveChange.clipsToBounds = true
        saveChange.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: Any) {
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
    
    func handleRefresh() {
        
        API.getProfileData{ (error: Error?, profile_List: [userData]?) in
            if let profile_List = profile_List {
                self.profile_list = profile_List
                
            }
        }
    }
    
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else
        {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
        }
        
        // Do not add a line break
        return false
    }

    @IBAction func saveChangeTapped(_ sender: Any) {
        
        let pastPassword = pastPasswordTF.text!
        let newPassword = newPasswordTF.text!
        let confirmPassword = rePasswordTF.text!
        let lastPassword = profile_list.first!.password
        let email = profile_list.first!.email
        let newEmail = ""
        let newName = ""
        let newPhone = ""
         let phone = profile_list.first!.phone1
        let name = profile_list.first?.name
    
        if (pastPassword.isEmpty) || (newPassword.isEmpty) || (confirmPassword.isEmpty)
        {
            AlertManager.showAlert("تاكد من ادخال جميع الخانات", inViewController: self)
            return;
        }
        
        if ( newPassword != confirmPassword )
            
        {
            AlertManager.showAlert("عليك التاكد من ادخال الرقم السري الصحيح مرتين", inViewController: self)
            return;
        }
        
        API.updateUserData (  newEmail: newEmail ,
                              newName: newName,newPhone: newPhone, newPassword: newPassword , oldEmail: email , oldPhone: phone , oldName: name! ,
                              oldPassword: pastPassword) { (error:Error?, user_List: [userData]?) in
                                if let user_List = user_List {
                                    let gg = user_List.first!.password
                                    if (gg != lastPassword)
                                    {
                                        AlertManager.showAlert("يرجى التأكد من البيانات وحاول مرة أخرى", inViewController: self)
                                    }
                                    else
                                    {
                                        AlertManager.showAlert("تم تغيير الرقم السري", inViewController: self)
                                        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                                        
                                        self.revealViewController().pushFrontViewController(newFrontController, animated: true)
                                    }
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
}
