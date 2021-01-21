//
//  AppDelegate.swift
//  memuDemo
//
//  Created by Mohammed Gamal on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//
import FBSDKLoginKit
import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import GoogleSignIn
import Alamofire
import SwiftyJSON
import OneSignal

@UIApplicationMain
//@available(iOS 13.0, *)
class AppDelegate: UIResponder, UIApplicationDelegate  {
 
    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //   FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = "998809497998-nv2bmj0erbgt1ccmp9k2n746j1t9djs9.apps.googleusercontent.com"
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
      
    //    GIDSignIn.sharedInstance().delegate = self
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "toturialViewController")
//
//        self.window?.rootViewController = initialViewController
//        self.window?.makeKeyAndVisible()
        // 00B79F
       UINavigationBar.appearance().barTintColor = UIColor(red: 0.00, green: 0.72, blue: 0.62, alpha: 1.00)
       
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
             let storyboard = UIStoryboard(name: "Main", bundle: nil) //Write your storyboard name
            let viewController = storyboard.instantiateViewController(withIdentifier: "toturialViewController") as! toturialViewController
            self.window!.rootViewController = viewController
            self.window!.makeKeyAndVisible()
        }
        
        // Override point for customization after application launch.
        // save data in user defult to login automatic
        // save data in user defult to login automatic§
        let def = UserDefaults.standard
        if let email = def.object(forKey: "email") as? String
        {
            print("email:\(email)")

            let tab = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController")
            window?.rootViewController = tab

        }
        
//        OneSignal.add(self as? OSSubscriptionObserver)
        //this line should be added
        
        // Add your AppDelegate as an obsserver
      //  OneSignal.add(self as OSSubscriptionObserver)
//        func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges!) {
//                      if !stateChanges.from.subscribed && stateChanges.to.subscribed {
//                         print("Subscribed for OneSignal push notifications!")
//                      }
//                      print("SubscriptionStateChange: \n\(stateChanges)")
//
//                      //The player id is inside stateChanges. But be careful, this value can be nil if the user has not granted you permission to send notifications.
//                      if let playerId = stateChanges.to.userId {
//                         print("Current playerId \(playerId)")
//
//                      }
//                   }
        
        //one signal
        
          OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

        let kMapsAPIKey = "AIzaSyCLCIyw1fOW03L-QDQ3K4VqmJFTEWnPKS4"
        if kMapsAPIKey.isEmpty {
            
            let bundleId = Bundle.main.bundleIdentifier!
            
        let msg = "Configure API keys inside Appdelegate.swift for your  bundle `\(bundleId)`, " +
            "see README.GooglePlacesClone for more information"
            print(msg)
        }
        
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
          GMSServices.provideAPIKey("AIzaSyCLCIyw1fOW03L-QDQ3K4VqmJFTEWnPKS4")
        GMSPlacesClient.provideAPIKey("AIzaSyCLCIyw1fOW03L-QDQ3K4VqmJFTEWnPKS4")
        // Override point for customization after application launch.
        Localizer.DoTheExchange()
      //  FirebaseApp.configure()
       
         //Remove this method to stop OneSignal Debugging
       //  OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

         //START OneSignal initialization code
        
        //oneSignal
        NotificationCenter.default.post(name: Notification.Name("SERVICE VALLEY"), object: nil)
        
//        let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
//            print("Received Notification - \(notification?.payload.notificationID) - \(notification?.payload.title)")
//            let storyboard = UIStoryboard(name: "Main", bundle: nil) //Write your storyboard name
//           let viewController = storyboard.instantiateViewController(withIdentifier: "ordersList") as! ordersList
//           self.window!.rootViewController = viewController
//           self.window!.makeKeyAndVisible()
//        }
//        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
//           // This block gets called when the user reacts to a notification received
//           let payload: OSNotificationPayload = result!.notification.payload
//
//           var fullMessage = payload.body
//           print("Message = \(fullMessage)")
//
//           if payload.additionalData != nil {
//             if payload.title != nil {
//                 let messageTitle = payload.title
//                    print("Message Title = \(messageTitle!)")
//              }
//
//              let additionalData = payload.additionalData
//              if additionalData?["actionSelected"] != nil {
//                 fullMessage = fullMessage! + "\nPressed ButtonID: \(additionalData!["actionSelected"])"
//                let storyboard = UIStoryboard(name: "Main", bundle: nil) //Write your storyboard name
//               let viewController = storyboard.instantiateViewController(withIdentifier: "ordersList") as! ordersList
//               self.window!.rootViewController = viewController
//               self.window!.makeKeyAndVisible()
//              }
//           }
//        }
       let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: true, ]

        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "51efd6bc-49fb-4554-9e79-26b6a98370df",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)

        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;

        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
      
            // Add your AppDelegate as an subscription observer
     
       
        
        return ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
   
  
       
   
  
    // google sign in
    func application(_ application: UIApplication,
                     open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool{
        return GIDSignIn.sharedInstance().handle(url)

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        AppEvents.activateApp()
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

