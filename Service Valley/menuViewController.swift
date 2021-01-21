//
//  menuViewController.swift
//  memuDemo
//
//  Created by Mohammed Gamal on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class menuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    
    @IBOutlet var bigView: UIView!
    @IBOutlet weak var tblTableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
  
    @IBOutlet weak var accountName: UILabel!
    var ManuNameArray:Array = [String]()
    var profile_list = [userData]()
    var refresher : UIRefreshControl!
    var iconArray:Array = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
       handleRefresh()
        tblTableView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)

        bigView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
      //  ManuNameArray = ["الرئيسية", "عناويني","","طلباتي","الصفحة الشخصية"]
        
        
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = UIColor.green.cgColor
        imgProfile.layer.cornerRadius = 50
        
        imgProfile.layer.masksToBounds = false
        imgProfile.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        
        
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isLoggedIn() {
            self.ManuNameArray=["الرئيسية","عناويني","تسجيل الخروج","طلباتي","الصفحة الشخصية","اتصل بنا"]
           
        }else
        {
            self.ManuNameArray=["الرئيسية","عناويني","تسجيل الدخول","طلباتي","الصفحة الشخصية","اتصل بنا"]
            
        }
       
    }
    func handleRefresh() {
        
        API.getProfileData{ (error: Error?, profile_List: [userData]?) in
            if let profile_List = profile_List {
                self.profile_list = profile_List
               
              self.accountName.text = self.profile_list.first?.name
                let strin = self.profile_list.first?.photo
                let imageName = "https://servicevalley.net/storage/app/public/user_images/\(strin)"
                let url = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if strin != nil {
                     self.imgProfile.imageFromURL(url: url, indicatorColor: .gray, errorImage: UIImage(named: "Profile-1")!)
                }
                else {
                    self.imgProfile.image = UIImage(named: "Profile-1")
                }
               
                
            }
        }
    }
    fileprivate func isFaceBookLogIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isFaceBookLogIn")
    }
   
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManuNameArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.lblMenuname.text! = ManuNameArray[indexPath.row]
      
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        
        let cell:MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell
        print(cell.lblMenuname.text!)
       
        if cell.lblMenuname.text! == "الرئيسية"
        {
            print("Home Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "selectCityViewController") as! selectCityViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)

            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
            
        }
        if cell.lblMenuname.text! == "عناويني"
        {
            if isLoggedIn(){
                         
                               print("Home Tapped")
                                                      let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                      let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "AddressHistory") as! AddressHistory
                                                      let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)

                                                      revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                           
                       }
                       else{
                           print("AddressHistory Tapped")
                           let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                           let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "firstLogIn") as! firstLogIn
                           let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                           
                           revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                           
                       }
           
           
            
        }
       
       
        if cell.lblMenuname.text! == "تسجيل الدخول"
            
        {
            
            print("AddressHistory Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "firstLogIn") as! firstLogIn
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }
        if cell.lblMenuname.text! == "تسجيل الخروج"
        {
            
            print("AddressHistory Tapped")
            API.logOut ( completion: { (error, success) in
                // Stop loading indicator
                if success==true {
          
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                   UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.removeObject(forKey: "b_name")
                    UserDefaults.standard.removeObject(forKey: "password")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "selectCityViewController") as! selectCityViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
                }
        })
        }
        if cell.lblMenuname.text! == "طلباتي"
        {
            if isLoggedIn(){
              
                                print("AddressHistory Tapped")
                    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ordersList") as! ordersList
                    let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)

                    revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
            }
            else{
                print("AddressHistory Tapped")
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "firstLogIn") as! firstLogIn
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
            }
            
          
        }
       
        if cell.lblMenuname.text! == "الصفحة الشخصية"
        {
            
            if isLoggedIn(){
              
                    print("AddressHistory Tapped")
                    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "profilePage") as! profilePage
                    let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                    
                    revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
            }
            else{
                print("AddressHistory Tapped")
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "firstLogIn") as! firstLogIn
                let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
                
                revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
                
            }
           
        
    }
        if cell.lblMenuname.text! == "اتصل بنا"
        {
            print("Home Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "callUsViewController") as! callUsViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)

            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
          //  UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
            
        }
    /*/    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
