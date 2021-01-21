//
//  subServicesPage.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/26/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit

import iOSDropDown
class subServicesPage: UIViewController , UITextFieldDelegate ,UIPickerViewDataSource, UIPickerViewDelegate  {
    
    var typeBigArray  = [types]()
    var typeBigArray2 = [types]()
    
    var subServices_selected = [type_subservices]()
    
    var selectedArray = [type_subservices]()
    var selectedIndex = 0
          var selectedIndexPath = IndexPath(item: 0, section: 0)
   // private var _currentSelection: Int = 0
    var refresher : UIRefreshControl!
    var service_Type = [types]()
    var types_name: [String] = []
    var subServices: [ String] = []
    var subServices2: [ Any] = []
    let typePicker = UIPickerView()
    let sericePicker = UIPickerView()
    var subservice_id: [Int] = []
    var type_id33: [Int] = []
    var secondColumnData = [[type_subservices]]()
    var secondColumnData10 = [[AnyObject]]()
  //  var secondColumnData5 = [[type_subservices2]]()
    var secondColumnData2 = [[type_subservices]]()
    var type_id3322: [Int] = []
    var types_name2: [String] = []
    var sub_name2: [String] = []
    var sub_id2: [Int] = []
    var secondColumnData33 = [[String]]()
    var secondColumnData55 = [[Int]]()
   
    
    @IBOutlet weak var imageLogoView: UIView!
    @IBOutlet weak var serviceImageView: UIView!
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet weak var sub_id_Label: UILabel!
    
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var typesTF: UITextField!
    @IBOutlet weak var subServicesTF: UITextField!
    @IBOutlet weak var serviceLogo: UIImageView!
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var subServiceName: UILabel!
    @IBOutlet weak var type_id_label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         let serviceNameTitle = helper.getServiceName()
        self.navigationItem.title = serviceNameTitle
    }
    
    
    private var _currentSelection: Int = 0

    // whenever current selection is modified, we need to reload other pickers as their content depends upon the current selection index only.
    var currentSelection: Int {
        get {
            return _currentSelection
        }
        set {
            _currentSelection = newValue
            typePicker .reloadAllComponents()
            sericePicker .reloadAllComponents()

          //  typesTF.text = types_name[_currentSelection]
          //  subServicesTF.text = secondColumnData[_currentSelection][0]
         //   textField_2.text = subContentArray[_currentSelection][0]
        }
    }
    // whenever current selection is modified, we need to reload other pickers as their content depends upon the current selection index only.
 

    override func viewDidLoad() {
        
        super.viewDidLoad()
        if revealViewController() != nil {
            
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(animated:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
        }
        
        
        typesTF.layer.cornerRadius = 15.0
        typesTF.layer.borderWidth = 2
        typesTF.layer.borderColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00).cgColor
        subServicesTF.layer.cornerRadius = 15.0
       
        subServicesTF.layer.masksToBounds = true
        subServicesTF.layer.borderWidth = 2
        subServicesTF.layer.borderColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00).cgColor
        typesTF.clipsToBounds = true
        subServicesTF.clipsToBounds = true
        numberTF.layer.cornerRadius = 15.0
        numberTF.layer.borderWidth = 2
        numberTF.clipsToBounds = true
        numberTF.layer.borderColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00).cgColor
        sub_id_Label.isHidden = true
       type_id_label.isHidden = true
        currentSelection = 0
        frameView.layer.cornerRadius = 15
        firstView.layer.masksToBounds = true
        firstView.layer.cornerRadius = 15
        subServiceName.layer.cornerRadius = 15
        secondView.layer.cornerRadius = 15
        
        thirdView.layer.cornerRadius = 15
        fourthView.layer.cornerRadius = 15
        okBtn.layer.cornerRadius = 15
        
        serviceImage.clipsToBounds = true
        serviceImage.layer.cornerRadius = 30
        serviceImage.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        upView.clipsToBounds = true
        upView.layer.cornerRadius = 30
        upView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      //  self.navigationController?.navigationBar.isTranslucent = false
        
        // picker
        typePicker.delegate = self
        typesTF.inputView = typePicker
        sericePicker.delegate = self
        subServicesTF.inputView = sericePicker
        
       self.serviceLogo.layer.masksToBounds = true
        
        numberTF.keyboardType = .asciiCapableNumberPad
        numberTF.delegate = self
        typesTF.delegate = self
         subServicesTF.delegate = self
        numberTF.tag = 0
        typesTF.tag = 0
        subServicesTF.tag = 0
      //  emailText.returnKeyType = .done
       // passwordText.returnKeyType = .done
      //  self.view.sendSubviewToBack(serviceImage)
       // self.view.bringSubviewToFront(upView)
       // self.view.bringSubviewToFront(serviceLogo)
        handleServicesType()
        
//        if secondColumnData2.count == 0 {
//            sericePicker.isUserInteractionEnabled = false
//        }
  //  handleSubServiceSelected()
        self.imageLogoView.layer.masksToBounds = true
              self.imageLogoView.layer.cornerRadius = self.imageLogoView.frame.height/2
               self.imageLogoView.layer.borderWidth = 3
               self.imageLogoView.layer.borderColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00).cgColor
        
        
        
        // Do any additional setup after loading the view.
     
        
        // toolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height:self.view.frame.size.height/10))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-30.0)
        
        //  toolBar.barStyle = UIBarStyle.black
        toolBar.barTintColor =  UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        toolBar.tintColor = UIColor.white
        let todayBtn = UIBarButtonItem(title: "تم", style: UIBarButtonItem.Style.plain, target: self, action: #selector(subServicesPage.tappedToolBarBtn))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "اختار النوع"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace], animated: true)
        
        typesTF.inputAccessoryView = toolBar
        // toolbar
        let toolBar2 = UIToolbar(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height:self.view.frame.size.height/10))
        
        toolBar2.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-30.0)
        
        //  toolBar.barStyle = UIBarStyle.black
        
        toolBar2.barTintColor =  UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        
        toolBar2.tintColor = UIColor.white
        
        let todayBtn2 = UIBarButtonItem(title: "تم", style: UIBarButtonItem.Style.plain, target: self, action: #selector(subServicesPage.tappedToolBarBtn2))
        
        let flexSpace2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label2.font = UIFont(name: "Helvetica", size: 12)
        
        label2.backgroundColor = UIColor.clear
        
        label2.textColor = UIColor.white
        
        label2.text = "اختار الخدمة"
        
        label2.textAlignment = NSTextAlignment.center
        
        let textBtn2 = UIBarButtonItem(customView: label2)
        
        toolBar2.setItems([todayBtn2,flexSpace2,textBtn2,flexSpace2], animated: true)
        
        subServicesTF.inputAccessoryView = toolBar2
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
       
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
        
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        guard let subServiesName = helper.getSubServiesName() else {
           
//           // AlertManager.showAlert("لا يوجد شركات توفر الخدمة في موقعك", inViewController: self)
//        let alert = UIAlertController(title: " لا يوجد شركات توفر الخدمة في موقعك , سنذهب بك الى الصفحة الرئيسية", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
//            self.navigationController?.popViewController(animated: true)
//        }))
//
//       // frameView.isHidden = true
//       // upView.isHidden = true
//
//         self.present(alert, animated: true)
//
            return
        }
        guard let serviceName = helper.getServiceName() else {
//
//            AlertManager.showAlert("لا يوجد شركات توفر الخدمة في موقعك", inViewController: self)
//            self.navigationController?.popViewController(animated: true)
//        let alert = UIAlertController(title: " لا يوجد شركات توفر الخدمة في موقعك , سنذهب بك الى الصفحة الرئيسية", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
//            self.navigationController?.popViewController(animated: true)
//        }))
//
//       // frameView.isHidden = true
//       // upView.isHidden = true
//         self.present(alert, animated: true)
//
           return
        }
        
       
     let serviesLogoName = helper.getServiceLogo()
//        if  serviesLogoName == nil {
//            let subServiceImageName = "Service%20Valley%20Icon.png"
//        }
        
        let subServiceImageName = helper.getSubServiceImageName()
    
        
//        if  subServiceImageName == nil {
//            let subServiceImageName = "Service%20Valley%20Icon.png"
//        }
        let imageName = "https://servicevalley.net/storage/app/public/pro_images/\(subServiceImageName!)"
         let url = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        self.serviceImage.imageFromURL(url:url ?? "", indicatorColor: .gray, errorImage: UIImage(named: "service_valley_logo")!)
        self.title = serviceName
       
       
        
        let imageName2 = "https://servicevalley.net/storage/app/public/mainservices_images/\(serviesLogoName ?? "")"
         let url2 = imageName2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
//        if serviesLogoName == nil {
//
//            let serviesLogoName = "Service%20Valley%20Icon.png"
//        }
       // self.serviceImageView.bringSubviewToFront(self.serviceLogo)
        
        self.serviceLogo.imageFromURL(url: url2 ?? "", indicatorColor: .gray, errorImage: UIImage(named: "service_valley_logo")!)
        self.subServiceName.text = subServiesName
        // upView.layer.cornerRadius = 15
     
   //   self.serviceLogo.layer.cornerRadius = self.serviceLogo.frame.height/2
//        self.serviceLogo.layer.borderWidth = 2
//        self.serviceLogo.layer.borderColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0).cgColor
       // self.serviceLogo.imageWithInset(insets: 16)
//        serviceLogo.contentMode = .scaleAspectFill
//        serviceLogo.image = UIImage(named: "example")?.withAlignmentRectInsets(UIEdgeInsets(top: -30, left: -10, bottom: -30, right: -10))
        
       
        
        
       
        
    }
    

   
//    func unique2(cars: [types]) -> [types] {
//
//        var uniqueCars2 = [types]()
//
//        for car in cars {
//            if !uniqueCars2.contains(car) {
//                uniqueCars2.append(car)
//            }
//        }
//
//        return uniqueCars2
//    }
    @discardableResult
    func unique(cars: [type_subservices]) -> [type_subservices] {

        var uniqueCars = [type_subservices]()

        for car in cars {
            if !uniqueCars.contains(car) {
                uniqueCars.append(car)
            }
        }

        return uniqueCars
    }
    
    func handleServicesType() {

        API.getServicesType{ [self] (error: Error?, service_Type: [types]?) in
            if let service_Type = service_Type {
                
                self.service_Type = service_Type
                if self.service_Type.first?.typesArray != nil {
                    self.subServices_selected = self.service_Type.first!.typesArray
                    
                    
//                    for item in service_Type {
                        
//                        let url = item.t_name
//                         let type_Id = item.t_id
//                        let ss  = item.typesArray
                    
                        var seen = Set<String>()
                    //    var unique = [types]()
                        for message in service_Type {
                            let ss = message.typesArray
                            var set: Set<type_subservices> = []
                            let orderedset = ss.filter{ set.insert($0).inserted }
                            message.typesArray = orderedset
                            if !seen.contains(message.t_name!) {
                            
                                
                                
                    //    print(message.typesArray)
                                typeBigArray.append(message)
                                        seen.insert(message.t_name!)
                            }
                            
                           
                        }
                  
                    
                    
              
                       
                    
                        
                       
                 //       print(typeBigArray.count)
                       
                        
               
                        
                        
                        
                   
                       
                        
                        
                        
                        
                      
 
                        
//                        self.types_name2.append(url!)
//                        self.type_id3322.append(type_Id!)
//
//
//                        self.types_name = self.types_name2.unique()
//                        self.type_id33 = self.type_id3322.unique()
//                        let uniqueCars = unique(cars: ss)
//
//
//
//                        self.secondColumnData.append(uniqueCars)
//
//
//
//                     //  self.secondColumnData2 = self.secondColumnData.removeDups()
//
//
//                        if secondColumnData.allEqual() == true
//                        {
//                            self.secondColumnData2 = secondColumnData.removeDups()
//
//                        }
//                        else {
//                            self.secondColumnData2 = secondColumnData.removeDups()
//
//                        }
//
                        
                        
                        
//                    }
                    
                    
                    
                    
           //         self.typeBigArray.removeDups()
                    
    
                    print(typeBigArray.count)

//                    if self.secondColumnData2[0].first?.sub_s_name == nil {
//                      //  self.sericePicker.isUserInteractionEnabled = false
//                        self.subServicesTF.isUserInteractionEnabled = false
//                    }
//
//                    if self.types_name.count != 0 {
//                        self.typesTF.text = self.types_name[0]
//                         self.type_id_label.text = String( self.type_id33[0])
//                    }
//
//                    if self.secondColumnData2.count != 0 {
//                        self.subServicesTF.text = self.secondColumnData2[0].first?.sub_s_name
//                        self.sub_id_Label.text = String((self.secondColumnData[0].first?.sub_s_id)!)
////                      let ff =  String(self.secondColumnData[0].first?.sub_s_id)
////                                  self.sub_id_Label.text = ff
//                      }
//
                    
                    
                    if self.typeBigArray[0].typesArray.first?.sub_s_name == nil {
                      //  self.sericePicker.isUserInteractionEnabled = false
                        self.subServicesTF.isUserInteractionEnabled = false
                    }
                    
                    if self.typeBigArray.count != 0 {
                        self.typesTF.text = self.typeBigArray[0].t_name
                        self.type_id_label.text = String( self.typeBigArray[0].t_id!)
                    }
                    
                    if self.typeBigArray[0].typesArray.count != 0 {
                        self.subServicesTF.text = self.typeBigArray[0].typesArray.first!.sub_s_name
                        self.sub_id_Label.text = String((self.typeBigArray[0].typesArray.first!.sub_s_id)!)
//                      let ff =  String(self.secondColumnData[0].first?.sub_s_id)
//                                  self.sub_id_Label.text = ff
                      }
                    
                    
                    
                    
//                      if self.secondColumnData.count != 0 {
//                        self.subServicesTF.text = self.secondColumnData[0].first?.sub_s_name
//                       // let ff =  String(self.secondColumnData[0].first?.sub_s_id)
//                                  //  self.sub_id_Label.text = ff
//                        }
                
                    
                    if let refresher = self.refresher{
                        refresher.endRefreshing()
                    }
                        self.selectedArray = self.service_Type[0].typesArray
                    self.refreshContent()
                }
                else {
                    
                        let alert = UIAlertController(title: "نعتذر !! لا توجد هنا خدمات في الوقت الحالي", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
                            
                        }))
                        
                         self.present(alert, animated: true)
                    
                    self.typesTF.isUserInteractionEnabled = false
                    self.subServicesTF.isUserInteractionEnabled = false
                    self.numberTF.isUserInteractionEnabled = false
                    self.okBtn.isUserInteractionEnabled = false
                    
                }
               
            }
        }
        
        }
//    func removeDuplicateElements(post: [type_subservices]) -> [type_subservices] {
//        var uniquePosts = [type_subservices]()
//        for post in uniquePosts {
//            if !uniquePosts.contains(where: {$0.sub_s_name == post.sub_s_name }) {
//                uniquePosts.append(post)
//            }
//        }
//        return uniquePosts
//    }
//
//    func noDuplicates(_ arrayOfDicts: [[String: String]]) -> [[String: String]] {
//        var noDuplicates = [[String: String]]()
//        var usedNames = [String]()
//        for dict in arrayOfDicts {
//            if let name = dict["name"], !usedNames.contains(name) {
//                noDuplicates.append(dict)
//                usedNames.append(name)
//            }
//        }
//        return noDuplicates
//    }
    func refreshContent(){
          // selectedArray =  service_Type[selectedIndex].typesArray
          // selectedArray = [food_list[selectedIndex]]
            
       }
    @objc func backTapped(sender: AnyObject) {
          self.navigationController?.popViewController(animated: true)
      }
      
      @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
          
          typesTF.resignFirstResponder()
      }
      
      @objc func tappedToolBarBtn2(sender: UIBarButtonItem) {
//        if secondColumnData.count == 0 {
//
//        }
        if secondColumnData2.count == 0 {
            
        }
        else {
            if subServicesTF.text == ""{
    
                      self.sericePicker.selectRow(0, inComponent: 0, animated: true)
                             self.pickerView(sericePicker, didSelectRow: 0, inComponent: 0)
            }
              subServicesTF.resignFirstResponder()
        }
        
        

      }
    private func setupQRImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
       // imageView.layer.borderColor = Default.imageBorderColor.cgColor
        imageView.layer.borderWidth = 3.0
       // imageView.layer.cornerRadius = 6.0
        let imageInset: CGFloat = 20
        imageView.image = UIImage(named: "QR")?.resizableImage(withCapInsets: UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset), resizingMode: .stretch)
        return imageView
    }
    fileprivate func fromSubToLog() -> Bool {
        return UserDefaults.standard.bool(forKey: "fromSubToLog")
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
        animateViewMoving(up: true, moveValue: 150)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        animateViewMoving(up: false, moveValue: 150)
       
                        
                    
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
        }
        // Do not add a line break
        return false
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        let number = numberTF.text
        let type = typesTF.text
        let subServ = subServicesTF.text
        let subservice_id = sub_id_Label.text
        let type_id = type_id_label.text
        
        if subServ!.isEmpty
        {
            AlertManager.showAlert("يجب ان تدخل االخدمة اولا .. ", inViewController: self)
            return
        }
        
        if number!.isEmpty
        {
            AlertManager.showAlert("يجب ان تدخل العدد", inViewController: self)
            return
        }
       
        
        if isLoggedIn(){
            let def = UserDefaults.standard
            def.setValue(number, forKey: "number")
            def.setValue(type, forKey: "type")
            def.setValue(subServ, forKey: "subServ")
            def.setValue(subservice_id, forKey: "subservice_id")
            def.setValue(type_id, forKey: "type_id")
            def.synchronize()
            
           performSegue(withIdentifier: "goToMyAdrress", sender: self)
            
        }
        else{
            print("AddressHistory Tapped")
            let def = UserDefaults.standard
            def.setValue(true, forKey: "fromSubToLog")
            def.synchronize()
//            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "firstLogIn") as! firstLogIn
//            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
//
//            revealViewController().pushFrontViewController(newFrontController, animated: true)
            performSegue(withIdentifier: "loginFirst", sender: self)
            
        }
        
    }
 
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
  
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typePicker {
//            return types_name.count
            return typeBigArray.count
        } else   {
            
//            return secondColumnData2[currentSelection].count
            return (typeBigArray[currentSelection].typesArray.count)
           
        //    return secondColumnData33[currentSelection].count
        
    }
    }        //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typePicker {
          //  self.type_id_label.text = String(type_id33[row])
//            return "\(types_name[row])"
            return "\(typeBigArray[row].t_name ?? "")"
        } else  if pickerView == sericePicker {
          //   self.sub_id_Label.text = String(subservice_id[row])
           // return "\(secondColumnData2[currentSelection][row])"
//            return "\(secondColumnData2[currentSelection][row].sub_s_name ?? "")"
            return "\(typeBigArray[currentSelection].typesArray[row].sub_s_name ?? "")"
        }
        else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView == typePicker {
          currentSelection = row
//            self.typesTF.text = types_name[row]
            self.typesTF.text = typeBigArray[row].t_name
       
            subServicesTF.text = ""
            typesTF.resignFirstResponder()
     
//            self.type_id_label.text = String(type_id33[row])
            self.type_id_label.text = String(typeBigArray[row].t_id!)
        } else if pickerView == sericePicker {
           
//            self.subServicesTF.text = (secondColumnData2[currentSelection][row].sub_s_name) ?? ""
            self.subServicesTF.text = (typeBigArray[currentSelection].typesArray[row].sub_s_name ) ?? ""
        
//            let id = String(secondColumnData2[currentSelection][row].sub_s_id!)
//            let id = String((typeBigArray[row].typesArray.first?.sub_s_id)!)
//             self.sub_id_Label.text = id
                subServicesTF.resignFirstResponder()
          
            
//           let id = String(secondColumnData[currentSelection][row].sub_s_id!)
//            self.sub_id_Label.text = id
            
               
         
         
           
            
        }
    }
    
}

//extension UIImage {
//    func imageWithInsets(insetDimen: CGFloat) -> UIImage {
//        return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
//    }
//
//    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(
//            CGSize(width: self.size.width + insets.left + insets.right,
//                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
//        let origin = CGPoint(x: insets.left, y: insets.top)
//        self.draw(at: origin)
//        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
//        UIGraphicsEndImageContext()
//        return imageWithInsets!
//    }
//
//}





//extension Sequence where Iterator.Element: Hashable {
//    func unique() -> [Iterator.Element] {
//        var seen: Set<Iterator.Element> = []
//        return filter { seen.insert($0).inserted }
//    }
//}

//extension Array {
//  func removeDups<T : Equatable>() -> [Element] where Element == [T] {
//
//    var result = [Element]()
//
//    for element in self{
//      if !result.contains(where: { element == $0 }) {
//        result.append(element)
//      }
//    }
//
//    return result
//  }
//}

extension Array where Element : Equatable{

    func removeDups() -> [Element]{
        var result = [Element]()

        for element in self{
            if !result.contains(where: { element == $0 }) {
                result.append(element)
            }
        }

        return result
    }
}

extension Array where Element : Equatable {
    func allEqual() -> Bool {
        if let firstElem = first {
            return !dropFirst().contains { $0 != firstElem }
        }
        return true
    }
}
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
//extension Array where Element: Equatable {
//    func removingDuplicates() -> Array {
//        return reduce(into: []) { result, element in
//            if !result.contains(element) {
//                result.append(element)
//            }
//        }
//    }
//}


extension Array where Element: Equatable {
  func uniqueElements() -> [Element] {
    var out = [Element]()

    for element in self {
      if !out.contains(element) {
        out.append(element)
      }
    }

    return out
  }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}





