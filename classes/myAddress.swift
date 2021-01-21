//
//  myAddress.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/15/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class myAddress: UIViewController , UIPopoverPresentationControllerDelegate {
   
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var refresher : UIRefreshControl!
    var location_list = [userLocations]()
    var data: [userLocations]?
    @IBOutlet weak var barMenu: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.navigationItem.title = "عناويني"
//        DispatchQueue.global().async {
//            self.handleRefresh()
//            self.tableView.reloadData()
//            }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        DispatchQueue.global().async {
            self.handleRefresh()
            }
        
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
      
        
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "تحميل")
        refresher.addTarget(self, action: #selector (myAddress.handleRefresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refresher)
 tableView.dataSource = self
        tableView.delaysContentTouches = false
       tableView.allowsSelection = false
      //   endView.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        // Do any additional setup after loading the view.
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
    fileprivate func isDeleting() -> Bool {
        return UserDefaults.standard.bool(forKey: "isDeleting")
    }
    @objc func backTapped(sender: AnyObject) {
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    }
   
    @objc func handleRefresh() {
        API.getUserLocations { (error: Error?, location_list:[userLocations]?) in
            if let location_list = location_list {
                self.location_list = location_list
                
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            }
        }
    }
    @IBAction func goToMap(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToMap", sender: self)
        
    }
    
    @objc func handleButtonTapped(sender: UIButton) {
        
        
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        
       
        
        let selectedCell = tableView.cellForRow(at: selectedIndex) as! myAddressCell
        let mainAddress = selectedCell.mainAddressLabel.text
        let address = selectedCell.largeAddressLbl.text
        let flatNumber = selectedCell.numberFlatLbl.text
        let buildingNumber = selectedCell.numberBuildingLbl.text
        let Longitude = selectedCell.viewMap.camera.target.longitude
        let Latitude = selectedCell.viewMap.camera.target.latitude
        let user_id:Int? = Int(selectedCell.userID.text!)
        let location_id:Int? = Int(selectedCell.locationID.text!)

        let def = UserDefaults.standard
        def.setValue(mainAddress, forKey: "mainAddress")
        def.setValue(address, forKey: "address")
        def.setValue(flatNumber, forKey: "flatNumber")
        def.setValue(buildingNumber, forKey: "buildingNumber")
        def.setValue(Longitude, forKey: "Longitude")
        def.setValue(Latitude, forKey: "Latitude")
        def.setValue(user_id, forKey: "user_id")
        def.setValue(location_id, forKey: "location_id")
        def.synchronize()
        
        self.performSegue(withIdentifier: "goToCompanyList", sender: self)
        
        
    }
    @objc func handleEditingTapped(sender: UIButton) {
        
        
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        
        
        
        let selectedCell = tableView.cellForRow(at: selectedIndex) as! myAddressCell
        
        let user_id:Int? = Int(selectedCell.userID.text!)
        let l_id:Int? = Int(selectedCell.locationID.text!)
        let mainAddress = selectedCell.mainAddressLabel.text
        let address = selectedCell.largeAddressLbl.text
        let flatNumber = selectedCell.numberFlatLbl.text
        let buildingNumber = selectedCell.numberBuildingLbl.text
        let Longitude = selectedCell.viewMap.camera.target.longitude
        let Latitude = selectedCell.viewMap.camera.target.latitude
        
        let def = UserDefaults.standard
        def.setValue(mainAddress, forKey: "mainAddress")
        def.setValue(address, forKey: "address")
        def.setValue(flatNumber, forKey: "flatNumber")
        def.setValue(buildingNumber, forKey: "buildingNumber")
        def.setValue(Longitude, forKey: "Longitude")
        def.setValue(Latitude, forKey: "Latitude")
        def.setValue(user_id, forKey: "user_id")
        def.setValue(l_id, forKey: "l_id")
        def.synchronize()
        
        self.performSegue(withIdentifier: "editAddress", sender: self)
        
        
    }
   
    
//    @IBAction func addNewLocationBtn(_ sender: Any) {
//        if isLoggedIn()
//        {
//            self.performSegue(withIdentifier: "gg", sender: self)
//        }
//        else
//        {
//            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "firstLogIn") as! firstLogIn
//            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
//            
//            revealViewController().pushFrontViewController(newFrontController, animated: true)
//        }
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}

extension myAddress:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
       return location_list.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myAddressCell") as! myAddressCell
        
       
        cell.delegate = self as? AddressCellDelegate
        cell.tag = indexPath.row
        cell.indexPath = indexPath
        cell.largeAddressLbl.text = location_list[indexPath.row].l_description
        cell.mainAddressLabel.text = location_list[indexPath.row].l_name
        cell.numberBuildingLbl.text = location_list[indexPath.row].l_building_number
        cell.numberFlatLbl.text = location_list[indexPath.row].l_flat_number
        cell.locationID.text = String(location_list[indexPath.row].l_id)
        cell.userID.text = String(location_list[indexPath.row].user_id)
        cell.locationID.isHidden = true
         cell.userID.isHidden = true
        cell.selectAddressBtn.tag = indexPath.row
        cell.selectAddressBtn.addTarget(self, action: #selector(handleButtonTapped(sender:)), for: .touchUpInside)
        cell.deleteAddressBtn.tag = indexPath.row
        cell.deleteAddressBtn.addTarget(self, action: #selector(didPressButton(sender:)), for: .touchUpInside)
        cell.editAddressBtn.tag = indexPath.row
        cell.editAddressBtn.addTarget(self, action: #selector(handleEditingTapped(sender:)), for: .touchUpInside)
        let Latitude = location_list[indexPath.row].l_latitude
         let longitude = location_list[indexPath.row].l_longitude
        let l_id = location_list[indexPath.row].l_id
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: Latitude, longitude: longitude, zoom: 15)

        cell.viewMap.camera = camera
        
       
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    @objc func didPressButton (sender: UIButton) {
        
//        guard let customAlertVC = customAlertVC else { return }
//        let popupVC = PopupViewController(contentController: customAlertVC, popupWidth: 350, popupHeight: 600)
//        popupVC.cornerRadius = 15
//        popupVC.shadowEnabled = true
//        popupVC.backgroundAlpha = 0.9
//
//
//        // show it by call present(_ , animated:) method from a current UIViewController
//        present(popupVC, animated: true, completion: nil)
//
//         if isDeleting() {
            let indexPath = IndexPath(row: sender.tag, section: 0)
            let location = userLocations()
            let gg = location_list[indexPath.row].l_id
        
            API.deleteAddress(l_id : gg  ){ ( error : Error?, success : Bool) in
                if success {
                    if let index = self.data?.index (of: location ){
                        self.data?.remove(at: index)
                        
                        // remove Row
                        self.tableView.beginUpdates()
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        self.tableView.endUpdates()
                        
                        
                    } else {
                        self.tableView.reloadData()
                    }
                }
            }
        
        
            handleRefresh()

    
}
}

//extension myAddress : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return true
//}
//}




