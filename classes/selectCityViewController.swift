//
//  selectCityViewController.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/5/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import OneSignal
import iOSDropDown


class selectCityViewController: UIViewController, UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate,SWRevealViewControllerDelegate {

    @IBOutlet weak var barBtn: UIBarButtonItem!
   
    @IBOutlet weak var selectCityTF: UITextField!
    var cities_name: [String] = []
     var cities_Id: [Int] = []
    var city_list = [cities]()
      let cityPicker = UIPickerView()
    @IBOutlet weak var gg: UIButton!
    var refresher : UIRefreshControl!
    var city_Id:Int = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " اختر المدينة "
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            barBtn.target = revealViewController()
            barBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().delegate = self
            revealViewController().rearViewRevealWidth = 0
            
            
            
        }
        // picker
        cityPicker.delegate = self
        selectCityTF.inputView = cityPicker
        selectCityTF.layer.borderWidth = 1.5
        selectCityTF.layer.masksToBounds = true
        selectCityTF.layer.borderColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00).cgColor
        gg.layer.cornerRadius = 15
        self.parent?.title = " اختر المدينة "
        selectCityTF.delegate = self
        
        handleRefresh()
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        // toolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height:self.view.frame.size.height/10))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-30.0)
        
        //  toolBar.barStyle = UIBarStyle.black
        toolBar.barTintColor =  UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        toolBar.tintColor = UIColor.white
        let todayBtn = UIBarButtonItem(title: "تم", style: UIBarButtonItem.Style.plain, target: self, action: #selector(subServicesPage.tappedToolBarBtn))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "اختار المدينة"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace], animated: true)
//        
//        selectCityTF.inputAccessoryView = toolBar
    
     
    }
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition)
    {
        if position == FrontViewPosition.left     // if it not statisfy try this --> if revealController.frontViewPosition == FrontViewPosition.Left
        {
            self.view.isUserInteractionEnabled = true
            print("YES YES YES YES RRRRIIIIGGGGHHHHTTTT")
            revealController.panGestureRecognizer().isEnabled=true
        }
        else
        {
            self.view.isUserInteractionEnabled = false
            revealController.panGestureRecognizer().isEnabled=false
             print("YES YES YES YES LLLLEEEEFFFFTTTT")
        }
    }
    
//    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
//        let point = revealController.panGestureRecognizer().location(in: self.view)
//
//        if revealController.frontViewPosition == FrontViewPosition.right //&& point.x < 50.0
//        {
//            print("YES YES YES YES RRRRIIIIGGGGHHHHTTTT")
//          //  self.view.isUserInteractionEnabled = true
//                revealController.panGestureRecognizer().isEnabled=true
//            return false
//
//        }
//        else if revealController.frontViewPosition == FrontViewPosition.left {
//            print("YES YES YES YES LLLLEEEEFFFFTTTT")
//           // self.view.isUserInteractionEnabled = true
//            revealController.panGestureRecognizer().isEnabled=false
//            return true
//        }
//
//        return true
//    }
    
        func handleRefresh() {
            API.getCities { (error: Error?, city_list:[cities]?) in
                if let city_list = city_list {
                    for item in city_list {
                        
                        let names = item.city_name
                        let city_Id = item.city_id
                        self.cities_name.append(names)
                        self.cities_Id.append(city_Id)
                    }
                    if self.cities_name.count != 0 {
                       self.selectCityTF.text = self.cities_name[0]
                    }
                   
                    
                    if let refresher = self.refresher{
                        refresher.endRefreshing()
                    
                }
            
                
            }
        }
        // Do any additional setup after loading the view.
    }
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        selectCityTF.resignFirstResponder()
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let cityName = selectCityTF.text!
        if cityName.isEmpty
        {
            
            //Display the messsage
            // displayMyAlertMessage( userMessage: "All Field are required")
            AlertManager.showAlert("اختر المدينة اولا", inViewController: self)
            return;
        }
        
        let cityId = cities_Id[city_Id]
        let def = UserDefaults.standard
        def.setValue(cityId, forKey: "city_id")
        def.synchronize()
 
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return cities_name.count
       
    }        //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            return "\(cities_name[row])"
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
       
            self.selectCityTF.text = cities_name[row]
       
    
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
