//
//  callUsViewController.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 11/3/20.
//  Copyright © 2020 Parth Changela. All rights reserved.
//

import UIKit
import MessageUI

class callUsViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var barMenu: UIBarButtonItem!
    let composeViewController = MFMailComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            
            
            barMenu.target = revealViewController()
            barMenu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
        }
        composeViewController.delegate = self
     //   composeViewController.mailComposeDelegate = self
        self.title = "اتصل بنا"
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       
        let backButton1 = UIBarButtonItem(title: "الرئيسية", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)

        // Do any additional setup after loading the view.
    }
    @objc func backTapped(sender: AnyObject) {
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    }
    
    @IBAction func sendEmailTapped(_ sender: Any) {
        composeViewController.mailComposeDelegate = self
        composeViewController.delegate = self
              // Entered a generic email in place of your constant value
              composeViewController.setToRecipients(["sp@servicevalley.net"])
              // Entered a generic subject in place of your constant value
             // composeViewController.setSubject("subject")
              // You have a typo on "Constants" here
            //  composeViewController.setMessageBody("", isHTML: false)
              present(composeViewController, animated: true, completion: nil)
          }
        

    @IBAction func instaTapped(_ sender: Any) {
        var instagramHooks = "https://instagram.com/saservicev?igshid=1ljga0ow3wu0n"
        var instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
          //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://instagram.com/saservicev?igshid=1ljga0ow3wu0n")! as URL)
        }
    }
    
    @IBAction func tweetTapped(_ sender: Any) {
        var instagramHooks = "https://twitter.com/SaServicev?s=09"
        var instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
          //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://twitter.com/SaServicev?s=09")! as URL)
        }
    }
    


       
        
    
    
    @IBAction func callTapped(_ sender: Any) {
        let phoneNumberTextfield = "0541654455"
        if let url = URL(string: "tel://\(phoneNumberTextfield)"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
extension callUsViewController: MFMailComposeViewControllerDelegate {
    // Removed the private
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        switch result {
        case .sent:
            print("Email sent")
        case .saved:
            print("Draft saved")
        case .cancelled:
            print("Email cancelled")
        case  .failed:
            print("Email failed")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
