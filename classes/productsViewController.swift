//
//  productsViewController.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/24/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import SBCardPopup
class productsViewController: UIViewController {
    var refresher : UIRefreshControl!
    var product_list = [products]()
   
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "المنتجات"
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            
            
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
        }
        
        
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        handleRefresh()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "تحميل")
        refresher.addTarget(self, action: #selector (productsViewController.handleRefresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refresher)
        tableView.dataSource = self
        // endView.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        
        // Do any additional setup after loading the view.
    }
    @objc private func handleRefresh() {
        API.getProducts { (error: Error?, product_list:[products]?) in
            if let product_list = product_list {
                self.product_list = product_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
               
                self.tableView.reloadData()
                if product_list.count == 0 {
                                                  let alert = UIAlertController(title: "عفوا ، لا يوجد منتجات اضافية حاليا", message: nil, preferredStyle: .alert)
                                                  alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
                                                    self.navigationController?.popViewController(animated: true)
                                                  }))
                    self.present(alert, animated: true)
                                              }
            }
        }
    }
    @objc func handleProductTapped(sender: UIButton) {
        
        
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        
        
        
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        
        
        
        let selectedCell = tableView.cellForRow(at: selectedIndex) as! productCell
        
        let product_id = Int(selectedCell.product_id.text!)
        let def = UserDefaults.standard
        def.setValue(product_id, forKey: "product_id")
        
        def.synchronize()
        
//        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "selectDate") as! selectDate
//        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
//
//        revealViewController().pushFrontViewController(newFrontController, animated: true)
         self.performSegue(withIdentifier: "selectDate", sender: self)
        
        
    }
    
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
extension productsViewController :  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return product_list.count
        
    }
//    func numberOfSections(in tableView: UITableView) -> Int
//    {
//        var numOfSections: Int = 0
//        if product_list.count == 0
//        {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
//            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            noDataLabel.text          = "لا توجد منتجات متاحة حاليا لهذه الشركة "
//            noDataLabel.textColor     = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
//            noDataLabel.textAlignment = .center
//            tableView.backgroundView  = noDataLabel
//            tableView.separatorStyle  = .none
//            })
//        }
//        else
//        {
//            tableView.separatorStyle = .singleLine
//            numOfSections            = 1
//            tableView.backgroundView = nil
//        }
//        return numOfSections
//    }
//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! productCell
        let strin = self.product_list[indexPath.row].c_image
        let imageName = "https://servicevalley.net/storage/app/public/company_images/\(strin)"
        let url = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        cell.companyLogo.imageFromURL(url: url, indicatorColor: .gray, errorImage: UIImage(named: "home")!)
        cell.productName.text = self.product_list[indexPath.row].pro_name
        cell.priceLabel.text = self.product_list[indexPath.row].pro_price
        cell.decriptionLabel.text = self.product_list[indexPath.row].pro_description
        cell.product_id.text = String(self.product_list[indexPath.row].pro_id)
        
       
        cell.middleView.roundCorners(corners: .topLeft, radius: 15)
        cell.containerView.roundCorners(corners: .topRight, radius: 15)
        cell.containerView.roundCorners(corners: .topLeft, radius: 15)
        cell.productNameView.roundCorners(corners: .bottomLeft, radius: 15)
        cell.productImage.roundCorners(corners: .topLeft, radius: 15)
         cell.productImage.roundCorners(corners: .topRight, radius: 15)
       
        cell.companyLogo.layer.cornerRadius = cell.companyLogo.frame.height/2
        cell.companyName.text = self.product_list[indexPath.row].c_name
        let strin2 = self.product_list[indexPath.row].pro_image
        let imageName2 = "https://servicevalley.net/storage/app/public/product_images/\(strin2)"
        let url2 = imageName2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
        cell.productImage.imageFromURL(url: url2, indicatorColor: .gray, errorImage: UIImage(named: "home")!)
        // cell.buyBtn.layer.cornerRadius = 50
        cell.companyLogo.layer.borderWidth = 2
        cell.companyLogo.layer.borderColor =  UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00).cgColor
        cell.buyBtn.tag = indexPath.row
        cell.buyBtn.addTarget(self, action: #selector(handleProductTapped(sender:)), for: .touchUpInside)
        cell.containerView.layer.shadowColor = UIColor.darkGray.cgColor
        cell.containerView.layer.shadowOpacity = 2
        cell.containerView.layer.shadowRadius = 15
        cell.shopView.layer.cornerRadius = cell.shopView.frame.height/2
     //   cell.shopView.layer.masksToBounds = true
     //   cell.containerView.layer.masksToBounds = true
        //cell.companyLogo.layer.borderWidth = 2
       // cell.companyLogo.layer.borderColor =  UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0).cgColor
        
        
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 385
    }
    
}

//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//}


