//
//  firstLogIn.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/30/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore
import GoogleSignIn
import FirebaseAnalytics
import Alamofire
import SwiftyJSON
import OneSignal
import AuthenticationServices

//@available(iOS 13.0, *)
//@available(iOS 13.0, *)


class firstLogIn: UIViewController , UIApplicationDelegate  {
   
  
    
    @IBOutlet weak var gmailBtn: UIButton!
    @IBOutlet weak var facebookButtonHolder: UIView!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var faceBookView: UIView!
  
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var emailBtn: UIButton!
    var faceBookButton : UIButton!
     var user_list = [userData]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " التسجيل "
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 13.0, *) {
          //  performExistingAccountSetupFlows()
        } else {
            // Fallback on earlier versions
        }
    }
    // sign in with apple
//    @available(iOS 13.0, *)
//    private func performExistingAccountSetupFlows() {
//        // Prepare requests for both Apple ID and password providers.
//        let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]
//
//        // Create an authorization controller with the given requests.
//        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if revealViewController() != nil {
            
            
            
            menu.target = revealViewController()
            menu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
            
            
            
        }
        
        self.title = " التسجيل "
        
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        
        
        //creating button FB
//        faceBookButton = UIButton(frame: CGRect(x: 0,
//                                                y: 0,
//                                                width: facebookButtonHolder.bounds.size.width,
//                                                height: facebookButtonHolder.bounds.size.height))
//        facebookButtonHolder.addSubview(faceBookButton!)
//       faceBookButton!.addTarget(self, action: #selector(fbButtonTapped), for: .touchUpInside)
//
//        faceBookButton!.setTitleColor(UIColor.white, for: .normal)
//        faceBookButton!.backgroundColor = UIColor.clear
registerBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        logInBtn.backgroundColor = UIColor(red:0.41, green:0.41, blue:0.41, alpha:1.0)
//        faceBookView.backgroundColor = UIColor(red:0.31, green:0.41, blue:0.63, alpha:1.0)
//        gmailBtn.backgroundColor = UIColor(red:0.84, green:0.27, blue:0.31, alpha:1.0)
//        emailBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
//        faceBookView.layer.cornerRadius = 5
//         gmailBtn.layer.cornerRadius = 5
//         emailBtn.layer.cornerRadius = 5
//        GIDSignIn.sharedInstance().delegate = self
//      //  GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance()?.presentingViewController = self
        
       // Sign in with apple
//
//        if #available(iOS 13.0, *) {
//            let siwaButton = ASAuthorizationAppleIDButton(type: .continue, style: .black)
//
//            siwaButton.translatesAutoresizingMaskIntoConstraints = false
//
//                   // add the button to the view controller root view
//                   self.view.addSubview(siwaButton)
//
//                   // set constraint
//                   NSLayoutConstraint.activate([
//                    siwaButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.centerXAnchor, multiplier: 0),
//                    siwaButton.widthAnchor.constraint(equalToConstant: self.emailBtn.frame.size.width),
//                   // siwaButton.widthAnchor.constraint(equalToConstant:292),
//                    siwaButton.topAnchor.constraint(equalTo: emailBtn.bottomAnchor, constant: 8),
//                       siwaButton.heightAnchor.constraint(equalToConstant: 49.0)
//                   ])
//
//                   // the function that will be executed when user tap the button
//                   siwaButton.addTarget(self, action: #selector(appleSignInTapped), for: .touchUpInside)
//
//        } else {
//            // Fallback on earlier versions
//        }
//
//        // set this so the button will use auto layout constraint
        
        
    }
    //Sign in with apple
//    @available(iOS 13.0, *)
//    @objc func appleSignInTapped() {
//        let provider = ASAuthorizationAppleIDProvider()
//        let request = provider.createRequest()
//        // request full name and email from the user's Apple ID
//        request.requestedScopes = [.fullName, .email]
//
//        // pass the request to the initializer of the controller
//        let authController = ASAuthorizationController(authorizationRequests: [request])
//
//        // similar to delegate, this will ask the view controller
//        // which window to present the ASAuthorizationController
//        authController.presentationContextProvider = self
//
//        // delegate functions will be called when user data is
//        // successfully retrieved or error occured
//        authController.delegate = self
//
//        // show the Sign-in with Apple dialog
//        authController.performRequests()
//    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        faceBookButton!.frame = CGRect(x: 0,
//                                       y: 0,
//                                       width: facebookButtonHolder.bounds.size.width,
//                                       height: facebookButtonHolder.bounds.size.height)
    }
    // Sign In with Apple
   
    @objc func backTapped(sender: AnyObject) {
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    }
//    @IBAction func googleTapped(_ sender: AnyObject) {
//       // GIDSignIn.sharedInstance().delegate=self
//       // GIDSignIn.sharedInstance().uiDelegate=self
//        GIDSignIn.sharedInstance().signIn()
//        }
//
//    @IBAction func googleTapped(_ sender: Any) {
//      //  GIDSignIn.sharedInstance() = self
//              //  GIDSignIn.sharedInstance().uiDelegate=self
//                GIDSignIn.sharedInstance().signIn()
//     //   self.performSegue(withIdentifier: "sms", sender: self)
//
//    }
}
    // fun for Google Sign in
        
//        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
//                  withError error: Error!) {
//            if let error = error {
//                print("\(error.localizedDescription)")
//            } else {
//                // Perform any operations on signed in user here.
//                let userId = String(user.userID!)                  // For client-side use only!
//                let idToken = user.authentication.idToken // Safe to send to the server
//                let fullName:String! = user.profile.name!
//                let givenName = user.profile.givenName
//                let familyName = user.profile.familyName
//                let email:String! = user.profile.email
//                let password:String! = String(user.userID)
//                let phone = user.userID
//                let def = UserDefaults.standard
//                def.setValue(fullName, forKey: "name")
//                def.setValue(fullName, forKey: "username")
//                def.setValue(email, forKey: "email")
//                def.setValue(userId, forKey: "password")
//                def.synchronize()
//                print(user.profile.email)
//                print(user.userID)
//                print(user.profile.name)
//
//                let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//                let dd = status.subscriptionStatus.userId
//                print(dd)
//
//
//                  guard let player_id = status.subscriptionStatus.userId else {
//                                                                 let alert = UIAlertController(title: "error", message: "oneSignal error", preferredStyle: .alert)
//                                                                                                                                                       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//                                                                                                                                                       }))
//                                                                                                                                                       self.present(alert, animated: true)
//                                                                return
//                                                             }
//                                                     //       let player_id = "2000"
//                                                            print(player_id)
//
//                                                      // self.performSegue(withIdentifier: "sms4", sender: self)
//                                                      API.getUserData(email: email, password: password,player_id: player_id){ (error: Error?, user_list:[userData]?) in
//
//                                                                 self.user_list = user_list!
//                                                                 if user_list?.count == 0{
//                                                                     let def = UserDefaults.standard
//                                                                    def.setValue(fullName, forKey: "b_name")
//                                                                    def.setValue(fullName, forKey: "b_name")
//                                                                    def.setValue(email, forKey: "email")
//                                                                    def.setValue(password, forKey: "password")
//                                                                    // def.setValue(true, forKey: "isFaceBookLogIn")
//
//                                                                                def.synchronize()
//                                                self.performSegue(withIdentifier: "sms", sender: self)
//                                                                 }
//                                                                 else{
//                                                                    let def = UserDefaults.standard
//
//                                                                    def.setValue(fullName, forKey: "b_name")
//                                                                    def.setValue(email, forKey: "email")
//                                                                    def.setValue(password, forKey: "password")
//                                                                    def.setValue(true, forKey: "isFaceBookLogIn")
//                                                                    def.setValue(player_id, forKey: "player_id")
//                                                                    def.setValue(true, forKey: "isLoggedIn")
//                                                                    def.synchronize()
//                                                                                                                                guard let window = UIApplication.shared.keyWindow else { return}
//                                                                                                                                print("AddressHistory Tapped")
//                                                                                                                                UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
//                                                                 }
//                                                      }
//
//            }
//        }
//
//
//        // fun for Google Sign in
//
//        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
//                  withError error: Error!) {
//            // Perform any operations when the user disconnects from app here.
//            // ...
//        }
//
//
//   @objc func fbButtonTapped() {
//
//        let loginManager = LoginManager()
//    loginManager.logIn(permissions: [.email],
//                           viewController: self) { (loginResult) in
//                            switch loginResult {
//                            case .failed(let error):
//                                AlertManager.showAlert(error.localizedDescription,
//                                                       inViewController: self)
//                            case .cancelled:
//                                return
//                            case .success(_, _, let accessToken):
//
//                                let req = GraphRequest(graphPath: "me", parameters: ["fields":"email, id, name"], httpMethod: HTTPMethod(rawValue: "GET"))
//
//                                req.start(completionHandler: { (_, json, error) in
//                                    if let error = error {
//                                        AlertManager.showAlert(error.localizedDescription,
//                                                               inViewController: self)
//                                    } else {
//                                        let name = (json as! [String:String])["name"]!
//
//                                        let email = (json as! [String:String])["email"]!
//
//                                        let password = (json as! [String:String])["id"]!
//                                      //  let email2 = email+"@facebook.com"
//                                        let username = (json as! [String:String])["name"]!
//                                      //  let phone = (json as! [String:String])["id"]!
//                                        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
//                                               let dd = status.subscriptionStatus.userId
//                                               print(dd)
//                                        guard let player_id = status.subscriptionStatus.userId else {
//                                                   let alert = UIAlertController(title: "error", message: "oneSignal error", preferredStyle: .alert)
//                                                                                                                                         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//                                                                                                                                         }))
//                                                                                                                                         self.present(alert, animated: true)
//                                                  return
//                                               }
//                                            //   let player_id = "2000"
//                                              print(player_id)
//
//                                        // self.performSegue(withIdentifier: "sms4", sender: self)
//                                        API.getUserData(email: email, password: password,player_id: player_id){ (error: Error?, user_list:[userData]?) in
//
//                                                   self.user_list = user_list!
//                                                   if user_list?.count == 0{
//                                                       let def = UserDefaults.standard
//                                                                                                                                                                        def.setValue(name, forKey: "b_name")
//                                                                                                                                                                        def.setValue(username, forKey: "b_name")
//                                                                                                                                                                        def.setValue(email, forKey: "email")
//                                                                                                                                                                        def.setValue(password, forKey: "password")
//                                                                                                                                                                       // def.setValue(true, forKey: "isFaceBookLogIn")
//
//                                                                                                                                                                        def.synchronize()
//                                                                                                                                                                        self.performSegue(withIdentifier: "sms", sender: self)
//                                                   }
//                                                   else{
//                                                       // self.offerName.text = offer_list.first!.o_name
//                                                 let email = email
//
//                                                                                                                                                    let def = UserDefaults.standard
//                                                                                                                                                                    def.setValue(name, forKey: "b_name")
//                                                                                                                                                                    def.setValue(username, forKey: "b_name")
//                                                                                                                                                                    def.setValue(email, forKey: "email")
//                                                                                                                                                                    def.setValue(password, forKey: "password")
//                                                                                                                                                                    def.setValue(true, forKey: "isFaceBookLogIn")
//                                                                                                                                                                    def.setValue(true, forKey: "isLoggedIn")
//                                                    def.setValue(player_id, forKey: "player_id")
//                                                                                                                                                                    def.synchronize()
//                                                                                                                  guard let window = UIApplication.shared.keyWindow else { return}
//                                                                                                                  print("AddressHistory Tapped")
//                                                                                                                  UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
//                                                   }
//                                        }
//
//                                    }})
//                                break
//                            }
//        }
//}
//}

//Apple Login

//@available(iOS 13.0, *)
//extension firstLogIn : ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        // return the current view window
//        return self.view.window!
//    }
//}
//
//@available(iOS 13.0, *)
//extension firstLogIn : ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        DispatchQueue.main.async {
//                                let alert = UIAlertController(title: "خطآ ", message: " حاول مرة أخري", preferredStyle: .alert)
//                                                                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//                                                                      }))
//                                                                      self.present(alert, animated: true)
//                                }
//        print("authorization error")
//        guard let error = error as? ASAuthorizationError else {
//            return
//        }
//
//        switch error.code {
//        case .canceled:
//            // user press "cancel" during the login prompt
//            print("Canceled")
//        case .unknown:
////            DispatchQueue.main.async {
////                                    let alert = UIAlertController(title: "خطآ ", message: "user didn't login their Apple ID on the device", preferredStyle: .alert)
////                                                                          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
////                                                                          }))
////                                                                          self.present(alert, animated: true)
////                                    }
//            // user didn't login their Apple ID on the device
//            print("Unknown")
//        case .invalidResponse:
//            // invalid response received from the login
//            print("Invalid Respone")
//        case .notHandled:
//            // authorization request not handled, maybe internet failure during login
//            print("Not handled")
//        case .failed:
//            // authorization failed
//            print("Failed")
//        @unknown default:
//            print("Default")
//        }
//    }
//
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//               // unique ID for each user, this uniqueID will always be returned
//               let password = appleIDCredential.user
//
//               // optional, might be nil
//               let email = appleIDCredential.email
//
//               // optional, might be nil
//               let name = appleIDCredential.fullName?.givenName
//
//               // optional, might be nil
//            //   let familyName = appleIDCredential.fullName?.familyName
//
//               // optional, might be nil
//             //  let nickName = appleIDCredential.fullName?.nickname
//
//               /*
//                   useful for server side, the app can send identityToken and authorizationCode
//                   to the server for verification purpose
//               */
//               var identityToken : String?
//               if let token = appleIDCredential.identityToken {
//                   identityToken = String(bytes: token, encoding: .utf8)
//               }
//
//               var authorizationCode : String?
//               if let code = appleIDCredential.authorizationCode {
//                   authorizationCode = String(bytes: code, encoding: .utf8)
//               }
//
//            //
//            let def = UserDefaults.standard
//            def.setValue(name, forKey: "b_name")
//            //def.setValue(username, forKey: "b_name")
//            def.setValue(email, forKey: "email")
//            def.setValue(password, forKey: "password")
//            def.setValue(true, forKey: "isAppleLogIn")
//
//            def.synchronize()
//            self.performSegue(withIdentifier: "sms", sender: self)
//
////             let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
////                                                           let dd = status.subscriptionStatus.userId
////                                                           print(dd)
////                                                    guard let player_id = status.subscriptionStatus.userId else {
////                                                               let alert = UIAlertController(title: "error", message: "oneSignal error", preferredStyle: .alert)
////                                                                                                                                                     alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
////                                                                                                                                                     }))
////                                                                                                                                                     self.present(alert, animated: true)
////                                                              return
////                                                           }
//
//                   let player_id = "2000"
//                                                          print(player_id)
//
////                                                    // self.performSegue(withIdentifier: "sms4", sender: self)
////            API.getUserData(email: appleIDCredential.email!, password: password,player_id: player_id){ (error: Error?, user_list:[userData]?) in
////
////                self.user_list = user_list!
////                if user_list?.count == 0{
////                    let def = UserDefaults.standard
////                    def.setValue(name, forKey: "b_name")
////                    //def.setValue(username, forKey: "b_name")
////                    def.setValue(email, forKey: "email")
////                    def.setValue(password, forKey: "password")
////                    // def.setValue(true, forKey: "isFaceBookLogIn")
////
////                    def.synchronize()
////                    self.performSegue(withIdentifier: "sms", sender: self)
////                }
////                else{
////                    // self.offerName.text = offer_list.first!.o_name
////                    let email = email
////
////                    let def = UserDefaults.standard
////                    def.setValue(name, forKey: "b_name")
////                    //def.setValue(username, forKey: "b_name")
////                    def.setValue(email, forKey: "email")
////                    def.setValue(password, forKey: "password")
////                    def.setValue(true, forKey: "isFaceBookLogIn")
////                    def.setValue(true, forKey: "isLoggedIn")
////                    def.setValue(player_id, forKey: "player_id")
////                    def.synchronize()
////                    guard let window = UIApplication.shared.keyWindow else { return}
////                    print("AddressHistory Tapped")
////                    UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
////                }
////                                                    }
//
//
//                                        }
//                    }


         



