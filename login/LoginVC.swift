//
//  LoginVC.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/1/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import OneSignal
import PasswordTextField

class LoginVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
   
    @IBOutlet weak var passwordText: PasswordTextField!
  
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var menu: UIBarButtonItem!
    var user_list = [userData]()
     var refresher : UIRefreshControl!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title =  "تسجيل  الدخول "
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            menu.target = revealViewController()
            menu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
        }
        
        self.title =  "تسجيل  الدخول "
        emailText.delegate = self
        passwordText.delegate = self
        emailText.tag = 0
        passwordText.tag = 0
        emailText.returnKeyType = .done
        passwordText.returnKeyType = .done
      
       
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        // hide the back Item navigation
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
       self.hideKeyboardWhenTappedAround()
        emailText.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        passwordText.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        
        nextBtn.backgroundColor = UIColor(red:0.46, green:0.46, blue:0.46, alpha:1.0)
        let color = UIColor.white
        
        emailText.attributedPlaceholder = NSAttributedString(string: emailText.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        passwordText.attributedPlaceholder = NSAttributedString(string: passwordText.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
       
        emailText.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        emailText.layer.borderWidth = 0.5
        emailText.layer.cornerRadius = 5
        passwordText.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        passwordText.layer.borderWidth = 0.5
        passwordText.layer.cornerRadius = 5
        nextBtn.layer.borderWidth = 0.5
        nextBtn.layer.cornerRadius = 5
        
// Do any additional setup after loading the view.
        
    }

    
    @objc func backTapped(sender: AnyObject) {
       self.navigationController?.popViewController(animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 150)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 150)
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
    
    
    @IBAction func nextToSms(_ sender: Any) {
        
      
        

        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
        let dd = status.subscriptionStatus.userId

        print(dd)

        guard let player_id = status.subscriptionStatus.userId else {
            let alert = UIAlertController(title: "error", message: "oneSignal error", preferredStyle: .alert)
                                                                                                  alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                                                                  }))
                                                                                                  self.present(alert, animated: true)
           return
        }
         
     //   let player_id = "2000"


       print(player_id)

        guard let email = emailText.text, !email.isEmpty else {return}
        guard let password = passwordText.text, !password.isEmpty else {return}
        API.getUserData(email: email, password: password,player_id: player_id){ [self] (error: Error?, user_list:[userData]?) in

            self.user_list = user_list!
            if user_list?.count == 0{
                AlertManager.showAlert("هناك خطأ في الايميل او الباسوورد", inViewController: self)
            }
            else{
                // self.offerName.text = offer_list.first!.o_name
                if fromSubToLog(){
            let userName = user_list!.first!.name
            let email = user_list!.first!.email
               let user_id = user_list!.first!.id
                let def = UserDefaults.standard
                def.setValue(userName, forKey: "b_name")
                def.setValue(player_id, forKey: "player_id")
                def.setValue(user_id, forKey: "user_id")
                def.synchronize()


                self.goToHomePage()
                }
                else{
                    let userName = user_list!.first!.name
                    let email = user_list!.first!.email
                       let user_id = user_list!.first!.id
                    let lang = Language.currentLanguage()
                    
                        let def = UserDefaults.standard
                        def.setValue(userName, forKey: "b_name")
                        def.setValue(player_id, forKey: "player_id")
                        def.setValue(user_id, forKey: "user_id")
                    def.setValue(email, forKey: "email")
                    def.setValue(lang, forKey: "lang")
                    def.setValue(true, forKey: "isLoggedIn")
                        def.synchronize()
                    UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
                }
            
            }
        }
    }
    fileprivate func fromSubToLog() -> Bool {
        return UserDefaults.standard.bool(forKey: "fromSubToLog")
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
    
    func goToHomePage() {
        let lang = Language.currentLanguage()
        let email = emailText.text
        guard let window = UIApplication.shared.keyWindow else { return}
        print("AddressHistory Tapped")
        
        let def = UserDefaults.standard
        def.setValue(email, forKey: "email")
        def.setValue(lang, forKey: "lang")
        def.setValue(true, forKey: "isLoggedIn")
        def.set(false, forKey: "fromSubToLog")
        def.synchronize()
        self.performSegue(withIdentifier: "goToSubService", sender: self)
        //UserDefaults.standard.synchronize()
       
    }
    }


