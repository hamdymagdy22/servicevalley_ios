//
//  selectTime.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/14/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit

class selectTime: UIViewController {
   
    @IBOutlet weak var nextBtn: UIButton!
   // @IBOutlet weak var endView: UIView!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var pmTimeLbl: UILabel!
   
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBAction func textFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        datePickerView.locale = Locale.init(identifier: "ar")
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(selectTime.datePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:mm a"
        
     //    dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.locale = Locale.init(identifier: "ar")
        
        dateTextField.text = dateFormatter.string(from: sender.date)
        
    }
   @objc func donePressed(sender: UIBarButtonItem) {
        if dateTextField.text?.isEmpty == false
        {
        
        dateTextField.resignFirstResponder()
        let dateFormatter = DateFormatter()
        
        // set the dateFormatter's dateFormat to the dateString's format
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale.init(identifier: "ar")
        
        // create date object
        guard let tempDate = dateFormatter.date(from: dateTextField.text!) else {
            fatalError("wrong dateFormat")
        }

        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "hh:mm" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")

        let time = dateFormatter.string(from: tempDate)
        timeLbl.text = time
        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "a" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")

        let minute = dateFormatter.string(from: tempDate)
        pmTimeLbl.text = minute
        // set the dateFormatter's dateFormat to the output format you wish to receive
//        dateFormatter.dateFormat = "a" // LL is the stand-alone month
//
//        let year = dateFormatter.string(from: tempDate)
//        yearLbl.text = year
    }
        else
        {
            AlertManager.showAlert("الرجاء ادخال التاريخ ", inViewController: self)
        }
        
    }
    
   @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "hh:mm a"
        dateformatter.locale = Locale.init(identifier: "ar")
        
        //  dateformatter.timeStyle = DateFormatter.Style.none
        
        dateTextField.text = dateformatter.string(from: NSDate() as Date)
        
        dateTextField.resignFirstResponder()
        let dateFormatter = DateFormatter()
        
        // set the dateFormatter's dateFormat to the dateString's format
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale.init(identifier: "ar")
        
        // create date object
        guard let tempDate = dateFormatter.date(from: dateTextField.text!) else {
            fatalError("wrong dateFormat")
        }
        
        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "hh:mm" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")
        
        let time = dateFormatter.string(from: tempDate)
        timeLbl.text = time
        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "a" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")
        
        let minute = dateFormatter.string(from: tempDate)
        pmTimeLbl.text = minute
        // set the dateFormatter's dateFormat to the output format you wish to receive
        //        dateFormatter.dateFormat = "a" // LL is the stand-alone month
        //
        //        let year = dateFormatter.string(from: tempDate)
        //        yearLbl.text = year
    }
    // setup date Piker
    func backTapped(sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            }
        let titleColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
      let day = UserDefaults.standard.string(forKey: "day")
        let month = UserDefaults.standard.string(forKey: "month")
        let year = UserDefaults.standard.string(forKey: "year")
        dayLbl.text = day
        monthLbl.text = month
        yearLbl.text = year
     //   endView.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        oneView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        twoView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        thirdView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        fourthView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        fifthView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        oneView.layer.cornerRadius = 8
        twoView.layer.cornerRadius = 8
        thirdView.layer.cornerRadius = 8
        fourthView.layer.cornerRadius = 8
        fifthView.layer.cornerRadius = 8
        dayLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        monthLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        yearLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        timeLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        pmTimeLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        nextBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
       
        dateTextField.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor

        dateTextField.layer.borderWidth = 0.5
        dateTextField.layer.cornerRadius = 5
        dateTextField.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        let color = UIColor.white
        dateTextField.attributedPlaceholder = NSAttributedString(string: dateTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        // tool bar of date piker
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height:self.view.frame.size.height/10))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
       // let todayBtn = UIBarButtonItem(title: "الان", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectDate.tappedToolBarBtn))
        
     //   let okBarBtn = UIBarButtonItem(title: "تم", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectDate.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "اختار الوقت"

        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
     //   toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        dateTextField.inputAccessoryView = toolBar
        
        // tool bar of date piker

        // Do any additional setup after loading the view.
    }
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    @IBAction func nextWithTime(_ sender: Any) {
        guard let b_time = dateTextField.text, !b_time.isEmpty else {
            AlertManager.showAlert("please Enter the time", inViewController: self)
            return
        }
        let def = UserDefaults.standard
        def.setValue(b_time, forKey: "b_time")
        def.synchronize()
        if isLoggedIn() == true{
            
                
           self.performSegue(withIdentifier: "selectCompany", sender: self)
        }
        else
        {
           self.performSegue(withIdentifier: "goToLogin", sender: self)
        }
    }
    
    @IBAction func callUs(_ sender: Any) {
    }
    
    @IBAction func myServices(_ sender: Any) {
        print("AddressHistory Tapped")
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "AddressHistory") as! AddressHistory
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealViewController().pushFrontViewController(newFrontController, animated: true)
    }
    
    @IBAction func HomePress(_ sender: Any) {
        print("Home Tapped")
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealViewController().pushFrontViewController(newFrontController, animated: true)
    }

}
// How to dismiss keyboard when touching anywhere outside UITextField
//extension UIViewController
//{
//    func hideKeyboard()
//    {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(UIViewController.dismissKeyboard))
//        
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissKeyboard()
//    {
//        view.endEditing(true)
//    }
//    
//}
//extension CGRect {
//    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
//        self.init(x:x, y:y, width:w, height:h)
//    }
//}

    

