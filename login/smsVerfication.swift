//
//  smsVerfication.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 4/22/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import OneSignal

class smsVerfication: UIViewController , UITextFieldDelegate {
  //  @IBOutlet weak var phoneNumber: UITextField!
  //  @IBOutlet weak var sendCodeBtn: UIButton!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var finishRegisterBtn: UIButton!
    @IBOutlet weak var barBtn: UIBarButtonItem!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title =   "تفعيل الحساب "
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if revealViewController() != nil {
            
            barBtn.target = revealViewController()
            barBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
        }
        self.title =   "تفعيل الحساب "
       // phoneNumber.delegate = self
        codeTF.delegate = self
        
     //   phoneNumber.tag = 0
        codeTF.tag = 0
        
     //   phoneNumber.returnKeyType = .done
        codeTF.returnKeyType = .done
        codeTF.keyboardType = .asciiCapableNumberPad
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
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
        
        //  finishRegisterBtn.isHidden = true
        // Do any additional setup after loading the view.
  //  sendCodeBtn.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        finishRegisterBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
     //   sendCodeBtn.layer.cornerRadius = 15
        finishRegisterBtn.layer.cornerRadius = 15
    }
    
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
        }
        // Do not add a line break
        return false
    }
    fileprivate func fromSubToLog() -> Bool {
        return UserDefaults.standard.bool(forKey: "fromSubToLog")
    }
    
//    @IBAction func sendCodeTapped(_ sender: UIButton) {
//
//        guard let phone1 = phoneNumber.text, !phone1.isEmpty else {return}
//        // var AppSid :String? = ""
//        // let Recipient = phoneNumber
//        //  var Body :String? = ""
//        API.checkNumber ( phone:phone1,completion: { (error, success) in
//        // Stop loading indicator
//        if success==true {
//
//        let url = URL(string: "http://api.unifonic.com/rest/Verify/GetCode")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//       // let postString = "AppSid=sAyc5FaS2lBMtVSV0Hh6IL8ialulPe&Recipient="+phone1+"&Body=كود التفعيل الخاص بك هو : "
//            let postString = "AppSid=lEgiMZ85Xq9cB6J4wcNOqfDzqbVY&Recipient="+phone1+"&Body=كود التفعيل الخاص بك هو : "
//       //     let postString = "AppSid=VOcXma9arSxxEUqrAM1asOs6RwQ&Recipient="+phone1+"&Body=كود التفعيل الخاص بك هو : "
//        request.httpBody = postString.data(using: .utf8)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//            DispatchQueue.main.async {
//                                   let alert = UIAlertController(title: "خطآ ", message: "هناك مشكلة في اتصالك بالانترنت", preferredStyle: .alert)
//                                                                         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//                                                                         }))
//                                                                         self.present(alert, animated: true)
//                                   }
//                // print("Error while fetching remote rooms: \(String(describing: error)")
//                // completion(nil)
//                return
//            }
//
//
//            guard let data = data,
//                let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
//                else {
//                    print("Nil data received from fetchAllRooms service")
//                      DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "خطآ ", message: "هناك مشكلة في اتصالك بالسيرفر", preferredStyle: .alert)
//                                                          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//                                                          }))
//                                                          self.present(alert, animated: true)
//                    }
//                    // completion(nil)
//                    return
//            }
//
//            guard let success = json?["success"] as? String else {
//               //   print("Malformed data received from fetchAllRooms service")
//
//                //  completion(nil)
//                print("1234")
//                return
//            }
//
//            if success == "true"
//            {
//                 print("ok it's true")
//                DispatchQueue.main.async {
//                                    let alert = UIAlertController(title: "تنبيه", message: "تم ارسال رسالة بكود التفعيل الى هاتفك", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//                    }))
//                    self.present(alert, animated: true)
//                }
//
//                print("ok it's true")
//                let def = UserDefaults.standard
//                def.setValue(phone1, forKey: "phone1")
//                def.synchronize()
//            }
//            else
//            {
//                print("ok it's false")
//                  DispatchQueue.main.async {
//                let alert = UIAlertController(title: "تنبيه", message: "تاكد من الرقم الصحيح", preferredStyle: .alert)
//                               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//                               }))
//                               self.present(alert, animated: true)
//                }
//            AlertManager.showAlert("تاكد من الرقم الصحيح", inViewController: self)
//            }
//        }
//
//        task.resume()
//
//    }
//        else {
//            let alert = UIAlertController(title: "تنبيه", message: "هذا الرقم تم التسجيل به من قبل يرجى ادخال رقم آخر", preferredStyle: .alert)
//                                                  alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//                                                  }))
//                                                  self.present(alert, animated: true)
//
//            }
//
//        })
//    }
    @IBAction func finishRegisterTapped(_ sender: Any) {
        guard let phone1 = helper.getPhone1()
                else {
                       return
               }
                guard let codeNumber = codeTF.text, !codeNumber.isEmpty else {return}
                // var AppSid :String? = ""
                // let Recipient = phoneNumber
                //  var Body :String? = ""
               let url = URL(string: "http://api.unifonic.com/rest/Verify/VerifyNumber")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

                let postString = "AppSid=lEgiMZ85Xq9cB6J4wcNOqfDzqbVY&Recipient="+phone1+"&PassCode="+codeNumber+""
                request.httpBody = postString.data(using: .utf8)

                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                                        let alert = UIAlertController(title: "خطآ ", message: "هناك مشكلة في اتصالك بالانترنت", preferredStyle: .alert)
                                                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                            }))
                                                            self.present(alert, animated: true)

                        // print("Error while fetching remote rooms: \(String(describing: error)")
                        // completion(nil)
                        return
                    }

                    guard let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Nil data received from fetchAllRooms service")
                                           let alert = UIAlertController(title: "خطآ ", message: "هناك مشكلة في اتصالك بالسيرفر", preferredStyle: .alert)
                                                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                                }))
                                                                self.present(alert, animated: true)

                            // completion(nil)
                            return
                    }

                    guard let success = json?["success"] as? String else {
                        //  print("Malformed data received from fetchAllRooms service")
                        //  completion(nil)
                        return
                    }

                    if success == "true"
                    {
                        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
                         guard let player_id = status.subscriptionStatus.userId else {
                                   let alert = UIAlertController(title: "error", message: "oneSignal error", preferredStyle: .alert)
                                                                                                                         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                                                                                         }))
                                                                                                                         self.present(alert, animated: true)

                            return
                        }
                    
//let player_id = "2000"

                        API.register ( player_id: player_id, completion: { [self] (error, success,state) in
                            if success {                                           // Stop loading indicator
                                if state == true {
                                    print("111111")
                       // AlertManager.showAlert(" هذا الرقم تم التسجيل به من قبل او حدث خطآ اثناء التسجيل", inViewController:self)
                        }
                        else
                        {
                             print("222222")
                            let def = UserDefaults.standard

                            def.setValue(player_id, forKey: "player_id")
                            def.setValue(true, forKey: "isLoggedIn")

                            def.synchronize()
                            if fromSubToLog(){
                            
                                   let alert = UIAlertController(title: "تم التسجيل", message: "سيتم الانتقال بك الي الصفحة الرئيسية ", preferredStyle: .alert)
                                       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                        UserDefaults.standard.set(false, forKey: "fromSubToLog")
                                           self.goToHomePage()
                                       }))
                                       self.present(alert, animated: true)

                            }
                            else{
                                let def = UserDefaults.standard

                                def.setValue(true, forKey: "fromLogin")
                                def.setValue(true, forKey: "isLoggedIn")

                                def.synchronize()
                                
                                                                       
                               
                                
                                let alert = UIAlertController(title: "تم التسجيل", message: "سيتم الانتقال بك الي الصفحة الرئيسية ", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                     UserDefaults.standard.set(false, forKey: "fromSubToLog")
                                        self.goToHomePage()
                                    }))
                                    self.present(alert, animated: true)
                                    
                                
                            }
                       
                           
                            
                            
                            }
                            
                            

                        }
                            else {
                                print("3333")
                                  let alert = UIAlertController(title: " لم يتم التسجيل", message: "رقم التلفون قد يكون مستخدم من قبل", preferredStyle: .alert)
                                                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                                          
                                                      }))
                                                      self.present(alert, animated: true)
                            }
                            
                        } )
                       }
                    if success == "false"
                    {
                        let alert = UIAlertController(title: " لم يتم التسجيل", message: "كود التفعيل غير صحيح", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                            
                        }))
                        self.present(alert, animated: true)
                      
                       

                    }

                }

                        task.resume()
       

      
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
    
}
