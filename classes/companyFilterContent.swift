//
//  companyFilterContent.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/21/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import LZViewPager

class companyFilterContent: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource {

    @IBOutlet weak var viewPager: LZViewPager!
    private var subControllers:[UIViewController] = []
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    func numberOfItems() -> Int {
        return self.subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        let selectedImage = UIImage(named: "greenColor") as UIImage?
        let unSelectedImage = UIImage(named: "darkLight") as UIImage?
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "JFFlat-Regular", size: 11)
    
        button.setBackgroundImage(selectedImage, for: .selected)
        button.setBackgroundImage(unSelectedImage, for: .normal)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        
        
        
        
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        return UIColor.red
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " مقدمي الخدمة "
        
     
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(animated:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
        }
        let vc1 = UIViewController.createFromNib(storyBoardId: "companyList")!
        vc1.title = "الاوفر $"
        let vc2 = UIViewController.createFromNib(storyBoardId: "companyListByApproved")!
        vc2.title = "موصي به"
        let vc3 = UIViewController.createFromNib(storyBoardId: "nearestCompanies")!
        vc3.title = "الاقرب"
        subControllers = [vc1, vc2,vc3]
        viewPager.hostController = self
    
        viewPager.reload()
        
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       
        
    }
    
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func widthForButton(at index: Int) -> CGFloat {
        return 63
    }
    
    func heightForHeader() -> CGFloat {
        return 26
    }
    
    func buttonsAligment() -> ButtonsAlignment {
        return .left
    }

    func widthForIndicator(at index: Int) -> CGFloat {
        return 0
    }
    
    
    func leftMarginForHeader()-> CGFloat {
        return 30
    }
    func rightMarginForHeader() -> CGFloat {
        return 30
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


