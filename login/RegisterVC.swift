//
//  RegisterVC.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/1/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import PasswordTextField

class RegisterVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var rePasswordText: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var menu: UIBarButtonItem!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " التسجيل "
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            menu.target = revealViewController()
            menu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
        }
        self.title = " التسجيل "
        nameText.delegate = self
        phoneText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        rePasswordText.delegate = self
        
        nameText.tag = 0
        phoneText.tag = 0
        emailText.tag = 0
        passwordText.tag = 0
        rePasswordText.tag = 0
        
        nameText.returnKeyType = .done
        phoneText.returnKeyType = .done
        emailText.returnKeyType = .done
        passwordText.returnKeyType = .done
        rePasswordText.returnKeyType = .done
        phoneText.keyboardType = .asciiCapableNumberPad
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        
        nameText.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        emailText.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        phoneText.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        passwordText.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        rePasswordText.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        nextBtn.backgroundColor = UIColor(red:0.46, green:0.46, blue:0.46, alpha:1.0)
        let color = UIColor.white
        nameText.attributedPlaceholder = NSAttributedString(string: nameText.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        emailText.attributedPlaceholder = NSAttributedString(string: emailText.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        phoneText.attributedPlaceholder = NSAttributedString(string: phoneText.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        passwordText.attributedPlaceholder = NSAttributedString(string: passwordText.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        rePasswordText.attributedPlaceholder = NSAttributedString(string: rePasswordText.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        
        nameText.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        nameText.layer.borderWidth = 0.5
        nameText.layer.cornerRadius = 5
        emailText.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        emailText.layer.borderWidth = 0.5
        emailText.layer.cornerRadius = 5
        phoneText.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        phoneText.layer.borderWidth = 0.5
        phoneText.layer.cornerRadius = 5
        passwordText.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
       passwordText.layer.borderWidth = 0.5
        passwordText.layer.cornerRadius = 5
        
        rePasswordText.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        rePasswordText.layer.borderWidth = 0.5
        rePasswordText.layer.cornerRadius = 5
        
        nextBtn.layer.borderWidth = 0.5
        nextBtn.layer.cornerRadius = 5
    
        // Do any additional setup after loading the view.
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
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    func goToHomePage() {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                                                    UserDefaults.standard.set(true, forKey: "fromLogin")
                                                   
                                                    UserDefaults.standard.synchronize()
           UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    //        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
    //        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
    //
    //        self.revealViewController().pushFrontViewController(newFrontController, animated: true)
           
           // self.performSegue(withIdentifier: "addLocation", sender: self)
                                            
        }
  
    
    @IBAction func nextToSms(_ sender: Any) {
        
        let userName = nameText.text!
        let email = emailText.text!
        let phone = phoneText.text!
        let password = passwordText.text!
        let confirmPassword = rePasswordText.text!
        
        if (userName.isEmpty || (email.isEmpty) || (password.isEmpty) || (confirmPassword.isEmpty) || (userName.isEmpty)) || (phone.isEmpty)
        {
            //Display the messsage
            DispatchQueue.main.async {
                             let alert = UIAlertController(title: "خطآ ", message: "يجب أدخال كل البيانات", preferredStyle: .alert)
                                                                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                                   }))
                                                                   self.present(alert, animated: true)
                             }
            // displayMyAlertMessage( userMessage: "All Field are required")
            return;
        }
        // check the password match confirmPassword
        if ( password != confirmPassword )
        {
            // Display alert message
            DispatchQueue.main.async {
                                       let alert = UIAlertController(title: "خطآ ", message: "يجب ان تكون كلمة السر مع التاكيد متطابقان", preferredStyle: .alert)
                                                                             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                                             }))
                                                                             self.present(alert, animated: true)
                                       }
            // displayMyAlertMessage( userMessage: "Password Don't Match")
            
            return;
            
        }
        // unifonic code and check phone number
        
             guard let phone1 = phoneText.text, !phone1.isEmpty else {return}
             // var AppSid :String? = ""
             // let Recipient = phoneNumber
             //  var Body :String? = ""
             API.checkNumber ( phone:phone1,completion: { (error, success) in
             // Stop loading indicator
             if success==true {
             
             let url = URL(string: "http://api.unifonic.com/rest/Verify/GetCode")!
             var request = URLRequest(url: url)
             request.httpMethod = "POST"
             request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            // let postString = "AppSid=sAyc5FaS2lBMtVSV0Hh6IL8ialulPe&Recipient="+phone1+"&Body=كود التفعيل الخاص بك هو : "
                 let postString = "AppSid=lEgiMZ85Xq9cB6J4wcNOqfDzqbVY&Recipient="+phone1+"&Body=كود التفعيل الخاص بك هو : "
            //     let postString = "AppSid=VOcXma9arSxxEUqrAM1asOs6RwQ&Recipient="+phone1+"&Body=كود التفعيل الخاص بك هو : "
             request.httpBody = postString.data(using: .utf8)

             let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 guard error == nil else {
                 DispatchQueue.main.async {
                                        let alert = UIAlertController(title: "خطآ ", message: "هناك مشكلة في اتصالك بالانترنت", preferredStyle: .alert)
                                                                              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                                              }))
                                                                              self.present(alert, animated: true)
                                        }
                     // print("Error while fetching remote rooms: \(String(describing: error)")
                     // completion(nil)
                     return
                 }
                

                 guard let data = data,
                     let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                     else {
                         print("Nil data received from fetchAllRooms service")
                           DispatchQueue.main.async {
                         let alert = UIAlertController(title: "خطآ ", message: "هناك مشكلة في اتصالك بالسيرفر", preferredStyle: .alert)
                                                               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                               }))
                                                               self.present(alert, animated: true)
                         }
                         // completion(nil)
                         return
                 }

                 guard let success = json?["success"] as? String else {
                    //   print("Malformed data received from fetchAllRooms service")

                     //  completion(nil)
                     print("1234")
                     return
                 }

                 if success == "true"
                 {
                      print("ok it's true")
                     DispatchQueue.main.async {
                                         let alert = UIAlertController(title: "تنبيه", message: "تم ارسال رسالة بكود التفعيل الى هاتفك", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                         }))
                        let def = UserDefaults.standard
                                                   def.setValue(userName, forKey: "b_name")
                                                   def.setValue(email, forKey: "email")
                                                   def.setValue(password, forKey: "password")
                                                  def.setValue(phone1, forKey: "phone1")
                                                  // def.setValue(phone, forKey: "phone1")
                                                   def.synchronize()
                                                   
                                                
                         self.performSegue(withIdentifier: "sms", sender: self)

                       
                                           
                         self.present(alert, animated: true)
                     }

                     print("ok it's true")
                    
                     
                 }
                 else
                 {
                     print("ok it's false")
                       DispatchQueue.main.async {
                     let alert = UIAlertController(title: "تنبيه", message: " تاكد من الرقم الصحيح , يرجي تغيير الرقم المستخدم", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                    }))
                                    self.present(alert, animated: true)
                     }
               //  AlertManager.showAlert("تاكد من الرقم الصحيح", inViewController: self)
                 }
             }

             task.resume()
         
         }
             else {
                 let alert = UIAlertController(title: "تنبيه", message: "هذا الرقم تم التسجيل به من قبل يرجى ادخال رقم آخر", preferredStyle: .alert)
                                                       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                       }))
                                                       self.present(alert, animated: true)
                 
                 }
                 
             })
        
        
       
    
}
}


