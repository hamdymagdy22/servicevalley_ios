//
//  companyList.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 11/6/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//
import Cosmos
import UIKit
import KImageView
import SBCardPopup
class companyList: UIViewController {
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
  
    var refresher : UIRefreshControl!
    var company_list = [companies]()
    var data: [userLocations]?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " مقدمي الخدمة "
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            
            
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
            
            
            
        }
        self.title = " مقدمي الخدمة "
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red:0.33, green:0.72, blue:0.62, alpha:1.0)
        let titleColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        handleRefresh()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "تحميل")
        refresher.addTarget(self, action: #selector (companyList.handleRefresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refresher)
        tableView.dataSource = self
       // endView.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
    
    @objc private func handleRefresh() {
        API.getCompanies { (error: Error?, company_list:[companies]?) in
            if let company_list = company_list {
                self.company_list = company_list
              // company_list.sorted() { $0.c_base_price > $1.c_base_price}
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
               if company_list.count == 0 {
                                              let alert = UIAlertController(title: "عفوا ، لا يوجد شركات تقدم الخدمة في منطقتك حاليا", message: nil, preferredStyle: .alert)
                                              alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
                                               let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                                                
                                                self.revealViewController().pushFrontViewController(newFrontController, animated: true)
                                              }))
                self.present(alert, animated: true)
                                          }
                
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleButtonTapped(sender: UIButton) {
        
        
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        
        let selectedCell = tableView.cellForRow(at: selectedIndex) as! companyCell
        
        let company_id:Int? = Int(selectedCell.companyID.text!)
        let def = UserDefaults.standard
        def.setValue(company_id, forKey: "company_id")
        def.synchronize()
        guard let has_products = helper.getHas_products() else {return}
       
        if has_products == "false" {
            self.performSegue(withIdentifier: "noProducts", sender: self)
        }else {
            self.performSegue(withIdentifier: "doService", sender: self)
        }
        
    }
    
    @objc func handleCompanyTapped(sender: UIButton) {
    
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        let selectedCell = tableView.cellForRow(at: selectedIndex) as! companyCell
        
        let company_id:Int? = Int(selectedCell.companyID.text!)
        let def = UserDefaults.standard
        def.setValue(company_id, forKey: "company_id")
        def.synchronize()
        
        self.performSegue(withIdentifier: "companyDetailsSegue", sender: self)
        
    }
}

extension companyList :  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return company_list.count
    
    }
//    func numberOfSections(in tableView: UITableView) -> Int
//    {
//        var numOfSections: Int = 0
//        if company_list.count == 0
//        {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
//            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            noDataLabel.text          = "لا توجد شركات في هذا الموقع يقدم نفس الخدمة"
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell") as! companyCell
        let strin = self.company_list[indexPath.row].c_image
        
        let imageName = "https://servicevalley.net/storage/app/public/company_images/\(strin)"
        let url = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        cell.companyCell.layer.borderWidth = 3
        cell.companyCell.layer.masksToBounds = false
        // companyCell.layer.borderColor = UIColor.black.cgColor
        cell.companyCell.layer.cornerRadius = cell.companyCell.frame.height/2
        cell.companyCell.clipsToBounds = true
        cell.companyCell.imageFromURL(url: url, indicatorColor: .gray, errorImage: UIImage(named: "home")!)
        cell.companyName.text = company_list[indexPath.row].c_name
        cell.companyID.text = String(company_list[indexPath.row].c_id)
        cell.fromlabel.text = company_list[indexPath.row].c_work_started_at
        cell.toLabel.text = company_list[indexPath.row].c_work_ended_at
        cell.priceLabel.text = String(company_list[indexPath.row].total)
        
       cell.selectBtn.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        cell.selectBtn.tag = indexPath.row
         cell.companyDetailsBtn.tag = indexPath.row
//        cell.madmonCheckImage.image = UIImage(named: "check-mark")?.withAlignmentRectInsets(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        cell.selectBtn.addTarget(self, action: #selector(handleButtonTapped(sender:)), for: .touchUpInside)
        cell.companyDetailsBtn.addTarget(self, action: #selector(handleCompanyTapped(sender:)), for: .touchUpInside)
         cell.nameView.roundCorners(corners: [ .topRight, .bottomLeft], radius: 15)
        
       
        let rate:Double? = Double(company_list[indexPath.row].c_rate)
        cell.companyDetailsBtn.isEnabled = true
        cell.selectBtn.isEnabled = true
        if rate == nil {
            cell.cosmosView.rating = 0
        }
        else
        {
            cell.cosmosView.rating = rate!
        }
        
        
        
        
            let madmoon = company_list[indexPath.row].c_guaranteed
        if madmoon == "1"
        {
            cell.madmonLbl.text = "موصي به"
            
          
            cell.companyCell.layer.borderColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0).cgColor
           // cell.companyCell.layer.borderWidth = 4
            // cell.madmonView.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
           // cell.madmonView.layer.borderWidth = 3
          
            // companyCell.layer.borderColor = UIColor.black.cgColorimage.layer.borderWidth = 1
            
         cell.madmonCheckImage.layer.cornerRadius = cell.madmonCheckImage.frame.height/2
            cell.madmonCheckImage.clipsToBounds = true
            cell.madmonCheckImage.layer.masksToBounds = false
          
            
        }
        else
        {
            cell.madmonView.isHidden = true
            cell.madmonLbl.text = "غير مضمون"
          cell.madmonCheckImage.isHidden = true
            cell.madmonLbl.bounds.size.width =  cell.madmonView.bounds.size.width
           cell.madmonView.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1.0)
             cell.madmonLbl.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1.0)
            //cell.madmonView.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
           // cell.madmonView.layer.borderWidth = 3
            cell.companyCell.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
          //   cell.companyCell.layer.borderWidth = 4
        }
        
        return cell
    }
    
    
}
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//}
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 180
}
extension UIViewController {
    
    func presentViewControllerAsPopup(_ viewController: UIViewController) {
        
        let cardPopup = SBCardPopupViewController(contentViewController: viewController)
        cardPopup.cornerRadius = 15
       
        cardPopup.show(onViewController: self)
    }
}


