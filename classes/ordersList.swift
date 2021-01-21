//
//  ordersList.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 12/25/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import OneSignal


class ordersList: UIViewController {
  
  
    @IBOutlet weak var barMenu: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
  
    var refresher : UIRefreshControl!
    var order_list = [orders]()
    var newOrder_list = [orders]()
    var data: [orders]?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " طلباتي "
        
        
        
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        if revealViewController() != nil {
            
            
            
            barMenu.target = revealViewController()
            barMenu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
        }
        let userObserver = NotificationCenter.default
        
        userObserver.addObserver(self, selector: #selector(userUpdated), name: Notification.Name("SERVICE VALLEY"), object: nil)
        NotificationCenter.default.addObserver(self,
                                                  selector: #selector(handleAppDidBecomeActiveNotification(notification:)),
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
        
       
      
       
        self.title = " طلباتي "
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        DispatchQueue.main.async {
            self.handleRefresh()
        }
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:"product_id")
        prefs.removeObject(forKey:"service_id")
        prefs.removeObject(forKey:"company_id")
        prefs.removeObject(forKey:"location_id")
        prefs.removeObject(forKey:"type_id")
        prefs.removeObject(forKey:"subservice_id")
        prefs.removeObject(forKey:"b_time")
        prefs.synchronize()
        
        
        let backButton1 = UIBarButtonItem(title: "الرئيسية", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
       DispatchQueue.main.async {
        self.refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: "تحميل")
        self.refresher.addTarget(self, action: #selector (ordersList.handleRefresh), for: UIControl.Event.valueChanged)
        
        self.tableView.addSubview(self.refresher)
        }
        
        tableView.dataSource = self
        tableView.delaysContentTouches = false
        tableView.allowsSelection = false
       // endView.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        
        
        // Do any additional setup after loading the view.
        let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
            print("Received Notification - \(notification?.payload.notificationID) - \(notification?.payload.title)")
            
            self.handleRefresh()
        }
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
           // This block gets called when the user reacts to a notification received
           let payload: OSNotificationPayload = result!.notification.payload

           var fullMessage = payload.body
           print("Message = \(fullMessage)")

           if payload.additionalData != nil {
             if payload.title != nil {
                 let messageTitle = payload.title
                    print("Message Title = \(messageTitle!)")
                self.handleRefresh()
                self.tableView.reloadData()
              }

              let additionalData = payload.additionalData
              if additionalData?["actionSelected"] != nil {
                 fullMessage = fullMessage! + "\nPressed ButtonID: \(additionalData!["actionSelected"])"
                self.handleRefresh()
                self.tableView.reloadData()
              }
           }
        }
    }
    @objc func handleAppDidBecomeActiveNotification(notification: Notification) {
        self.handleRefresh()
        self.tableView.reloadData()
    }

    @objc func userUpdated(_ notification:Notification) {
        // Update your View
        self.handleRefresh()
        self.tableView.reloadData()
    }
    @objc func backTapped(sender: AnyObject) {
//        print("Home Tapped")
//        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "selectCityViewController") as! selectCityViewController
//        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
//        
//        revealViewController.pushFrontViewController(newFrontController, animated: true)
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    }
   
    
    @IBAction func myServices(_ sender: Any) {
        print("AddressHistory Tapped")
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "AddressHistory") as! AddressHistory
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealViewController().pushFrontViewController(newFrontController, animated: true)
    }
    @IBAction func homePress(_ sender: Any) {
        print("Home Tapped")
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealViewController().pushFrontViewController(newFrontController, animated: true)
    }
   
    
    
    
    
//    func elapsedTimeSince(_ startTime: Date) -> String {
//        let elapsed = -startTime.timeIntervalSinceNow
//
//        return self.formatter.string(from: elapsed) ?? "0:00:00"
//    }
//
//    func startTimer() {
//        self.timersActive += 1
//        guard self.timer == nil else {
//            return
//        }
//
//        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] (timer) in
//            if let me = self {
//                for indexPath in me.tableView.indexPathsForVisibleRows ?? [] {
//                    let timer = me.timers[indexPath.row]
//                    if timer.isRunning {
//                        if let cell = me.tableView.cellForRow(at: indexPath) {
//                            cell.textLabel?.text = me.formatter.string(from: timer.elapsed) ?? "0:00:00"
//                        }
//                    }
//                }
//            }
//        })
//    }
//
//    func stopTimer() {
//        self.timersActive -= 1
//        if self.timersActive == 0 {
//            self.timer?.invalidate()
//            self.timer = nil
//        }
//    }
//


   
  
   
    
    @objc func handleRefresh() {
        self.newOrder_list.removeAll()
        self.order_list.removeAll()
        API.getOrders { (error: Error?, order_list:[orders]?) in
            if let order_list = order_list {
                for item in order_list {
                    let url = item.deleted_at
                    if url == ""
                    {
                       self.newOrder_list.append(item)
                    }
                    
                }
               
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
                DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            }
        }
    }
    @objc func didPressButton (sender: UIButton) {
        
        
        
        let indexPath = IndexPath (row: sender.tag, section: 0)
        
        let gg = newOrder_list[indexPath.row].b_id_generator
        let location = orders()
        
        API.cancelOrder (b_id_generator : gg ){ ( error : Error?, success : Bool) in
                       if success {
//                           self.stateImage.layer.borderWidth = 3
//                           self.stateImage.layer.borderColor = UIColor(red:0.87, green:0.04, blue:0.04, alpha:1.0).cgColor
//                           self.firstView.backgroundColor = UIColor(red:0.87, green:0.04, blue:0.04, alpha:1.0)
//                           self.myLabel.isHidden = true
//                           self.thirdView.isHidden = true
//                           self.stateImage.image = UIImage(named: "close")
//                           self.statusLabel.text = "تم إلغاء الطلب"
//                           self.timer?.invalidate()
//                           self.timer = nil
//                           print("ok")
                       
                        self.handleRefresh()

                       }
                           
                       else
                           
                       {
                        print("NO Thing")
                       }


                   }
//        self.handleRefresh()
//
//        print("AddressHistory Tapped")
//        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ordersList") as! ordersList
//        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
//
//        revealViewController().pushFrontViewController(newFrontController, animated: true)
        
        
    }
   
   
 
    }

extension ordersList :  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return newOrder_list.count
    }
//    func numberOfSections(in tableView: UITableView) -> Int
//    {
//        var numOfSections: Int = 0
//        if newOrder_list.count == 0
//        {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
//            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            noDataLabel.text          = "لا توجد لك طلبات بعد "
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row > newOrder_list.count-1){
               return UITableViewCell()
             }
           else{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell") as! MyCustomCell
       
        
        cell.delegate = self as? orderCellDelegate
        cell.tag = indexPath.row
         cell.indexPath = indexPath
        cell.deleteOrder.tag = indexPath.row
        cell.deleteOrder.addTarget(self, action: #selector(didPressButton(sender:)  ), for: .touchUpInside)
        cell.dateLabel.text = newOrder_list[indexPath.row].b_date
        cell.timeLabel.text = newOrder_list[indexPath.row].b_time
        cell.timeOfBooking.text = String(newOrder_list[indexPath.row].b_id_generator)
        cell.descriptionLabel.text = newOrder_list[indexPath.row].s_name
     //   cell.expiryTimeInterval = 10
        let state = newOrder_list[indexPath.row].b_status2
        let orderID = newOrder_list[indexPath.row].b_id_generator
       
        cell.stateImage.layer.cornerRadius = cell.stateImage.frame.height/2
        cell.statusLabel.text = newOrder_list[indexPath.row].b_status
        
        cell.myLabel.isHidden = false
        cell.thirdView.isHidden = false
        cell.thirdView.backgroundColor = UIColor(red:1.00, green:0.97, blue:0.00, alpha:1.0)
     
        
       
        
       

        if state == "pending"
        {
           // cell.myLabel.isHidden = false
            cell.stateImage.image = UIImage(named: "hourglass")
            cell.firstView.backgroundColor = UIColor(red:1.00, green:0.55, blue:0.03, alpha:1.0)
            
          cell.stateImage.layer.borderWidth = 3
            let timeStampr = newOrder_list[indexPath.row].created_at
            cell.stateImage.layer.borderColor =  UIColor(red:1.00, green:0.55, blue:0.03, alpha:1.0).cgColor
         
            
            let currentDate = Date().localString()
            let formatter = DateFormatter()
           // formatter.defaultDate = Calendar.current.startOfDay(for: Date())
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "dd/MM/yyyy, h:mm a"
            
            // ar_SA
          //  var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "UTC" }
            //print(localTimeZoneAbbreviation)
           // formatter.locale = Locale.init(identifier: localTimeZoneAbbreviation)
            formatter.timeZone = TimeZone(secondsFromGMT: 10800)
            
            if let gg = formatter.date(from: currentDate){
                print(gg)

                let currentMilliseconds = Int(gg.timeIntervalSince1970 * 1000)
               print(currentMilliseconds)

                let formatters = DateFormatter()
              //  formatters.defaultDate = Calendar.current.startOfDay(for: Date())
                formatters.locale = Locale(identifier: "en_US_POSIX")
                formatters.dateFormat = "yyyy-MM-dd HH:mm:ss"
                formatter.timeZone = TimeZone(secondsFromGMT: 10800)
                //   Asia/Riyadh


                if let  date = formatters.date(from: timeStampr){
                    print(date)

                    let milliseconds = Int(date.timeIntervalSince1970  * 1000)
                    print(milliseconds)

                   let createdAt = ( milliseconds + 1400000 - 246100)

                                   // let createdAt = ( milliseconds + 1200000 - 44000 )
                    print(createdAt)

                let result = createdAt - currentMilliseconds

                    let finalResult = result / 1000
                print(finalResult)

                cell.expiryTimeInterval = Double(finalResult)



                }


            }
            
        
            
           

        }
        
        if state == "cancelled"
        {
            cell.myLabel.isHidden = true
//            cell.timer.stop()
//UIColor(red:0.87, green:0.04, blue:0.04, alpha:1.0)
            cell.stateImage.image = UIImage(named: "close")
            
            cell.stateImage.layer.borderWidth = 3
           cell.stateImage.layer.borderColor = UIColor(red:0.87, green:0.04, blue:0.04, alpha:1.0).cgColor
            cell.firstView.backgroundColor = UIColor(red:0.87, green:0.04, blue:0.04, alpha:1.0)
            cell.thirdView.isHidden = true
            cell.deleteOrder.isUserInteractionEnabled = false
        }
        if state == "booked"
        {
//            cell.timer.stop()
            // UIColor(red:1.00, green:0.55, blue:0.03, alpha:1.0)
            cell.myLabel.isHidden = true
            cell.thirdView.isHidden = true
cell.stateImage.layer.borderWidth = 3
            cell.stateImage.image = UIImage(named: "yesoo")
             cell.firstView.backgroundColor = UIColor(red:0.03, green:0.62, blue:0.53, alpha:1.0)
            cell.stateImage.layer.borderColor = UIColor(red:0.03, green:0.62, blue:0.53, alpha:1.0).cgColor
            cell.deleteOrder.isUserInteractionEnabled = false


        }
       
       
       
        
        return cell
        }
        
        }
    func fireCellsUpdate() {
        let notification = Notification(name: Notification.Name(rawValue: "CustomCellUpdate"), object: nil)
        NotificationCenter.default.post(notification)
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
  
}

    

extension ordersList : UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        
        return Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}
extension Date {
    func localString(dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short) -> String {
        return DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}


