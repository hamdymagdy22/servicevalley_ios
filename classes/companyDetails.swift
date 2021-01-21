//
//  companyDetails.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 4/15/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import Cosmos
import KImageView
import SBCardPopup

class companyDetails: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var madmonView: UIView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var madmonLbl: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyDescription: UILabel!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var startAtLbl: UILabel!
    @IBOutlet weak var endAtLbl: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var ServicesName: UILabel!
    @IBOutlet weak var barBtn: UIBarButtonItem!
    
    var companyInfo_list = [companiesInfo]()
    var subService_list = [subServicesInfo]()
    var refresher : UIRefreshControl!
    
    @IBOutlet weak var rateLabel: CosmosView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " مقدمي الخدمة "
        
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            barBtn.target = revealViewController()
            barBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
        }
        self.navigationItem.title = " مقدمي الخدمة "
        
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
         navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        handleRefresh()
       //  endView.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        servicesCollectionView.reloadData()
        servicesCollectionView.layer.cornerRadius = 15
        servicesCollectionView.semanticContentAttribute = .forceRightToLeft
        containerView.layer.cornerRadius = 10
        madmonView.layer.cornerRadius = 0.5 * madmonView.bounds.size.height
        checkImage.addShadow()
        
        selectBtn.layer.cornerRadius = 15
        
       
        
        selectBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        companyName.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        ServicesName.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
       // priceLabel.textColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        
    }
    
    @objc func backTapped(sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func handleRefresh() {
        
        API.getCompanyDetails{ (error: Error?, companyInfo_List:[companiesInfo]?) in
            if let companyInfo_List = companyInfo_List {
                self.servicesCollectionView.reloadData()
                self.companyInfo_list = companyInfo_List
              
                    self.subService_list =  self.companyInfo_list.first!.subServiceArray
                self.rateLabel.rating = Double(self.companyInfo_list.first!.c_rate ?? 0)
                
                self.companyName.text = companyInfo_List.first?.c_name
                self.companyDescription.text = companyInfo_List.first?.c_description
                self.startAtLbl.text = companyInfo_List.first?.c_work_started_at
                self.endAtLbl.text = companyInfo_List.first?.c_work_ended_at
                let strin = self.companyInfo_list.first?.c_image
                self.companyImage.layer.cornerRadius = self.companyImage.frame.height/2
                self.companyImage.layer.borderWidth = 2
                self.companyImage.layer.masksToBounds = true
                let imageName = "https://servicevalley.net/storage/app/public/company_images/\(strin)"
                let url = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
               
                self.companyImage.imageFromURL(url: url, indicatorColor: .gray, errorImage: UIImage(named: "home")!)
            
                let rate = self.companyInfo_list.first?.c_rate
                
                if rate == nil
                {
                    self.rateLabel.rating = 0
                }
                else
                {
                    self.rateLabel.rating = Double(rate!)
                }
                
            
                let madmoon = self.companyInfo_list.first!.c_guaranteed
                if madmoon == "1"
                {
                    self.madmonLbl.text = "موصي به"
                    
                    
                    self.companyImage.layer.borderColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00).cgColor
                    
                    // cell.companyCell.layer.borderWidth = 4
                    // cell.madmonView.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
                    // cell.madmonView.layer.borderWidth = 3
                 
                    
                    
                    
                }
                else
                {
                    self.madmonView.isHidden = true
                    self.madmonLbl.text = "غير مضمون"
                    self.checkImage.isHidden = true
                  //  self.madmonLbl.bounds.size.width =  self.madmonView.bounds.size.width
                    self.madmonView.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1.0)
                    self.madmonLbl.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1.0)
                    //cell.madmonView.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
                    // cell.madmonView.layer.borderWidth = 3
                    self.companyImage.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
                    //   cell.companyCell.layer.borderWidth = 4
                }
              
}
            
        }
    }
    
    
    @IBAction func goToOrders(_ sender: Any) {
        guard let has_products = helper.getHas_products() else {return}
        
         if has_products == "false" {
             self.performSegue(withIdentifier: "noProducts", sender: self)
         }else {
             self.performSegue(withIdentifier: "doService", sender: self)
         }
     
}
}


    extension companyDetails: UICollectionViewDelegate, UICollectionViewDataSource {
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return subService_list.count
            
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "companyDetailsCell", for: indexPath) as! companyDetailsCell
            
            cell.layer.cornerRadius = 15
            cell.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
            cell.serviceName.text = self.companyInfo_list[indexPath.section].subServiceArray[indexPath.row].s_name
            
            return cell
            
        }
       
        
        
        
    }



