//
//  popUpViewController.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/24/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import SBCardPopup

class popUpViewController: UIViewController , SBCardPopupContent {
    static func create() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "popUpViewController") as! popUpViewController
        return viewController
    }
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancleBtn: UIButton!
  
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " تنبيه "
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(animated:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
        }
        self.title = " تنبيه "
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
            okBtn.layer.cornerRadius = 15
        cancleBtn.layer.cornerRadius = 15
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
   
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    weak var popupViewController: SBCardPopupViewController?
    
    let allowsTapToDismissPopupCard = false
    let allowsSwipeToDismissPopupCard = false
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SWRevealViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        var pushingController: Any?
        
        if frontViewController is UINavigationController {
            if (frontViewController as! UINavigationController).topViewController != viewController {
                pushingController = frontViewController
            }
        }
        else if let navigationController = frontViewController.navigationController {
            pushingController = navigationController
        }
        
        if pushingController != nil && !(viewController is UINavigationController) {
            (pushingController as! UINavigationController).pushViewController(viewController, animated: false)
            revealToggle(animated: animated)
        }
        else {
            pushFrontViewController(viewController, animated: animated)
        }
    }
}
