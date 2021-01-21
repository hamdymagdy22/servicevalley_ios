//
//  seletDate.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/7/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit


class selectDate: UIViewController {
    let date = Date()
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var bigView: UIView!
  
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
            let datePickerView:UIDatePicker = UIDatePicker()
        
                datePickerView.datePickerMode = UIDatePicker.Mode.date
                datePickerView.calendar = Calendar(identifier: .gregorian)
                datePickerView.autoresizingMask = UIView.AutoresizingMask.flexibleRightMargin
                datePickerView.locale = Locale.init(identifier: "ar")
                sender.inputView = datePickerView
        
        
                datePickerView.addTarget(self, action: #selector(selectDate.datePickerValueChanged), for: UIControl.Event.valueChanged)
        
        
    }
    
    @objc  func timePicker (sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:mm a"
       
        //    dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.locale = Locale.init(identifier: "ar")
        
        timeTextField.text = dateFormatter.string(from: sender.date)
        
    }
    @IBAction func textTime(_ sender: UITextField) {
                let datePickerView:UIDatePicker = UIDatePicker()
        
                datePickerView.datePickerMode = UIDatePicker.Mode.time
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
                datePickerView.locale = Locale.init(identifier: "ar")
        
                sender.inputView = datePickerView
        
                datePickerView.addTarget(self, action: #selector(selectDate.timePicker), for: UIControl.Event.valueChanged)
        
    }
    

    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.init(identifier: "ar")
        //  dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateTextField.text = dateFormatter.string(from: sender.date)

    }
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
 
    
    
   
    
    @objc func donePressed(sender: UIBarButtonItem) {
    if dateTextField.text?.isEmpty == false
    {
        dateTextField.resignFirstResponder()
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.init(identifier: "ar")
        // set the dateFormatter's dateFormat to the dateString's format
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // create date object
        guard let tempDate = dateFormatter.date(from: dateTextField.text!) else {
            fatalError("wrong dateFormat")
        }

        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "dd" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")

        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "MM" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")

        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "yyyy" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")

    }
        else
    {
        AlertManager.showAlert("الرجاء ادخال التاريخ ", inViewController: self)
        }

    }
    
    @IBAction func nextPage(_ sender: Any) {
       
        guard let b_date = dateTextField.text, !b_date.isEmpty else {
            AlertManager.showAlert("الرجاء ادخال التاريخ", inViewController: self)
            return
            
        }
        guard let b_time = timeTextField.text, !b_time.isEmpty else {
            AlertManager.showAlert("الرجاء ادخال الوقت", inViewController: self)
            return
            
        }
        let def = UserDefaults.standard
        def.setValue(b_date, forKey: "b_date")
        def.setValue(b_time, forKey: "b_time")
        
        def.synchronize()
        
        API.addNewOrders { (error: Error?, order_list:[orders]?) in
        }
        
        
     
    }
    
   
    
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {

        let dateformatter = DateFormatter()
        dateformatter.calendar = Calendar(identifier: .gregorian)
        dateformatter.locale = Locale.init(identifier: "ar")

        dateformatter.dateFormat = "yyyy-MM-dd"

        //  dateformatter.timeStyle = DateFormatter.Style.none

        dateTextField.text = dateformatter.string(from: NSDate() as Date)

        dateTextField.resignFirstResponder()
        let dateFormatter = DateFormatter()

        // set the dateFormatter's dateFormat to the dateString's format
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.init(identifier: "ar")
        // create date object
        guard let tempDate = dateFormatter.date(from: dateTextField.text!) else {
            fatalError("wrong dateFormat")
        }

        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "dd" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")

        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "MM" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")

        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "yyyy" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")

    }
    // setup date Piker
    @objc func backTapped(sender: AnyObject) {
       self.navigationController?.popViewController(animated: true)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " اختر  الموعد "
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
        }
         
                   let iconWidth = 30;
                   let iconHeight = 30;
                   
                   //Define the imageView
                   let imageView = UIImageView();
                   let imageEmail = UIImage(named: "check.png");
                   imageView.image = imageEmail;
        
        imageView.backgroundColor = UIColor.white
        
            imageView.frame = CGRect(x: 4, y: 4, width: iconWidth, height: iconHeight)
        imageView.layer.cornerRadius = imageView.frame.height/2
            dateTextField.leftViewMode = UITextField.ViewMode.always
            dateTextField.addSubview(imageView)
     
         //Define the imageView
                           let imageView2 = UIImageView();
                           let imageEmail2 = UIImage(named: "check.png");
                           imageView2.image = imageEmail2;
                imageView2.backgroundColor = UIColor.white
                    imageView2.frame = CGRect(x: 4, y: 4, width: iconWidth, height: iconHeight)
        imageView2.layer.cornerRadius = imageView2.frame.height/2
        timeTextField.leftViewMode = UITextField.ViewMode.always
                   timeTextField.addSubview(imageView2)
        
        self.title = " اختر  الموعد "
        bigView.layer.cornerRadius = 15
        firstView.layer.cornerRadius = 15
        secondView.layer.cornerRadius = 15
        nextBtn.layer.cornerRadius = 15
        dateTextField.layer.cornerRadius = 15
        timeTextField.layer.cornerRadius = 15
        navigationItem.hidesBackButton = true
        // creat new back button in right side
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
         navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        let titleColor = UIColor.white

        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
     //   endView.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
       
        nextBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
       
        let color = UIColor.white
       
        // tool bar of date piker
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: self.view.frame.size.height/10))

        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)

        toolBar.barStyle = UIBarStyle.blackTranslucent

        toolBar.tintColor = UIColor.white

        toolBar.backgroundColor = UIColor.black


        let todayBtn = UIBarButtonItem(title: "اليوم", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectDate.tappedToolBarBtn))

        let okBarBtn = UIBarButtonItem(title: "تم", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectDate.donePressed))

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))

        label.font = UIFont(name: "Helvetica", size: 12)

        label.backgroundColor = UIColor.clear

        label.textColor = UIColor.white

        label.text = "اختار اليوم"

        label.textAlignment = NSTextAlignment.center

        let textBtn = UIBarButtonItem(customView: label)

        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)

        dateTextField.inputAccessoryView = toolBar

        // tool bar of time piker
        // tool bar of date piker
        let toolBarTime = UIToolbar(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height:self.view.frame.size.height/10))
        
        toolBarTime.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBarTime.barStyle = UIBarStyle.blackTranslucent
        
        toolBarTime.tintColor = UIColor.white
        
        toolBarTime.backgroundColor = UIColor.black
        
        
         let todayBtn2 = UIBarButtonItem(title: "الان", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectDate.tappedToolBarBtnTime))
        
           let okBarBtn2 = UIBarButtonItem(title: "تم", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectDate.donePressedTime))
        
        let flexSpaceTime = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let labelTime = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        labelTime.font = UIFont(name: "Helvetica", size: 12)
        
        labelTime.backgroundColor = UIColor.clear
        
        labelTime.textColor = UIColor.white
        
        labelTime.text = "اختار الوقت"
        
        labelTime.textAlignment = NSTextAlignment.center
        
        let textBtnTime = UIBarButtonItem(customView: labelTime)
        
           toolBarTime.setItems([todayBtn2,flexSpaceTime,textBtnTime,flexSpaceTime,okBarBtn2], animated: true)
        
        timeTextField.inputAccessoryView = toolBarTime

   
        
    }
  
    @objc func tappedToolBarBtnTime(sender: UIBarButtonItem) {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "hh:mm a"
        dateformatter.locale = Locale.init(identifier: "ar")
        
        //  dateformatter.timeStyle = DateFormatter.Style.none
        
        timeTextField.text = dateformatter.string(from: NSDate() as Date)
        
        timeTextField.resignFirstResponder()
        let dateFormatter = DateFormatter()
        
        // set the dateFormatter's dateFormat to the dateString's format
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale.init(identifier: "ar")
        
        // create date object
        guard let tempDate = dateFormatter.date(from: timeTextField.text!) else {
            fatalError("wrong dateFormat")
        }
        
        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "hh:mm" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")
        
        
        // set the dateFormatter's dateFormat to the output format you wish to receive
        dateFormatter.dateFormat = "a" // LL is the stand-alone month
        dateFormatter.locale = Locale.init(identifier: "ar")
        
      
        // set the dateFormatter's dateFormat to the output format you wish to receive
        
    }
    @objc func donePressedTime(sender: UIBarButtonItem) {
        if timeTextField.text?.isEmpty == false
        {
            
            timeTextField.resignFirstResponder()
            let dateFormatter = DateFormatter()
            
            // set the dateFormatter's dateFormat to the dateString's format
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.locale = Locale.init(identifier: "ar")
            
            // create date object
            guard let tempDate = dateFormatter.date(from: timeTextField.text!) else {
                fatalError("wrong dateFormat")
            }
            
            // set the dateFormatter's dateFormat to the output format you wish to receive
            dateFormatter.dateFormat = "hh:mm" // LL is the stand-alone month
            dateFormatter.locale = Locale.init(identifier: "ar")
            
            let time = dateFormatter.string(from: tempDate)
          //  timeLbl.text = time
            // set the dateFormatter's dateFormat to the output format you wish to receive
            dateFormatter.dateFormat = "a" // LL is the stand-alone month
            dateFormatter.locale = Locale.init(identifier: "ar")
            
            let minute = dateFormatter.string(from: tempDate)
         //   pmTimeLbl.text = minute
            // set the dateFormatter's dateFormat to the output format you wish to receive
            //        dateFormatter.dateFormat = "a" // LL is the stand-alone month
            //
            //        let year = dateFormatter.string(from: tempDate)
            //        yearLbl.text = year
        }
        else
        {
            AlertManager.showAlert("الرجاء ادخال الوقت ", inViewController: self)
        }
        
    }
    
}
//extension UITextField{
//
//    func setLeftImage(imageName:String) {
//
//        let imageView = UIImageView(frame: CGRect(x: 220, y:20, width: 30, height: 30))
//        imageView.image = UIImage(named: imageName)
//
//            imageView.layer.masksToBounds = false
//          //  imageView.layer.borderColor = UIColor.black.cgColor
//            imageView.layer.cornerRadius = imageView.frame.height/2
//            imageView.clipsToBounds = true
//        imageView.backgroundColor = UIColor.white
//
//        self.leftView = imageView;
//        self.leftViewMode = .always
//    }
//}


    
    


    


