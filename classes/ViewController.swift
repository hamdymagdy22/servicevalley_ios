//
//  ViewController.swift
//  memuDemo
//
//  Created by Mohammed Gamal on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit
import ImageSlideshow
import OneSignal


class ViewController: UIViewController ,UISearchBarDelegate,SWRevealViewControllerDelegate{
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    var jsonArray: [String] = []
    var gallaris_list = [photoGallery]()
   var refresher : UIRefreshControl!
    @IBOutlet weak var slideBackView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var slideshow: ImageSlideshow!
    @IBOutlet weak var homePageBtn: UIBarButtonItem!
    
   
   // let localSource = [ImageSource(imageString: "img1")!, ImageSource(imageString: "img2")!, ImageSource(imageString: "img3")!, ImageSource(imageString: "img4")!]
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    var service_list = [Service]()
    var subService_list = [subServices]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " الخدمات "
        DispatchQueue.global().async {
        self.handleRefresh()
        }
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            
            btnMenuButton.target = revealViewController()
            
            btnMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(animated:))
            
            self.revealViewController().delegate = self
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
            
            
    }
        slideBackView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        
        let backButton1 = UIBarButtonItem(title: " رجوع ", style: .plain, target: self, action: #selector(backTapped))
        backButton1.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 18)!], for: UIControl.State.normal)
        navigationItem.leftBarButtonItem = backButton1
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
      
        DispatchQueue.global().async {
        self.handleRefresh()
            self.getCompanyWorkgallaries()
        }
         
      
        tableView.delegate = self
        tableView.dataSource = self
        // setup refresher
        slideshow.layer.cornerRadius = 15
        slideBackView.layer.cornerRadius = 15
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (ViewController.handleRefresh), for: UIControl.Event.valueChanged)
        refresher.addTarget(self, action: #selector (ViewController.getCompanyWorkgallaries), for: UIControl.Event.valueChanged)
        tableView.addSubview(refresher)
        slideshow.slideshowInterval = 5.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
       // slideshow.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap))
        slideshow.addGestureRecognizer(recognizer)
        // outletes
       
        //    self.tableView.reloadData()
        self.collectionReloadData()
        // self.handleRefresh()
    }
    func collectionReloadData(){
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    @IBAction func homePress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func backTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
   
    @objc public func handleRefresh() {

        
        API.getServicesData{ (error: Error?, services:[Service]?) in
            if let services = services {
                self.service_list = services
                self.subService_list = (self.service_list.first?.subServiceArray)!
                if (self.refresher) != nil {
                    self.refresher.endRefreshing()
                }
                    self.tableView.reloadData()
               
              //  self.handleRefresh()
            }
        }
        
    }
    
    @objc func getCompanyWorkgallaries() {
        
        jsonArray.removeAll()
        
        API.getAllPhotoGallaries  {(error: Error?, gallaris_list:[photoGallery]?) in
            if let gallaris_list = gallaris_list {
                self.gallaris_list = gallaris_list
                
                for item in gallaris_list {
                    let imageUrl = item.g_image
                    let url1 = "http://servicevalley.net/storage/app/public/gallary_images/\(imageUrl)"
                  
                     let url = url1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    self.jsonArray.append(url ?? "" )
                }
                let arr =  self.jsonArray.map { AFURLSource(urlString: $0 as! String)!}
                self.slideshow.setImageInputs(arr)
                if let refresher = self.refresher{
                    refresher.endRefreshing()
                }
            }
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // Do what ever you want
        handleRefresh()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return service_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath) as! mainTableViewCell
        
        cell.delegate = self as? CategoryRowDelegate
       
       
        cell.services.tag = indexPath.row
      //  cell.serviceName.text = service_list[indexPath.row].ms_name
        cell.service_list = [service_list[indexPath.item]]
        cell.services.collectionViewLayout.invalidateLayout()
       // cell.services.reloadData()
   cell.collectionReloadData()
        cell.services.contentOffset = .zero
       // self.tableView.reloadData()
        //cell.subService_list = [subService_list[indexPath.row]]
      //  cell.serviceName.set(image: UIImage(named: "service_valley_icon")!)
        return cell
    }
    
    
    func cellTapped(){
        print("AddressHistory Tapped")
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "AddressHistory") as! AddressHistory
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealViewController().pushFrontViewController(newFrontController, animated: true)
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 150
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == true {
            
            handleRefresh()
            
        }
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        service_list.first?.subServiceArray = searchText.isEmpty ? (service_list.first?.subServiceArray)!: (service_list.first?.subServiceArray.filter({(service: subServices) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return service.s_name!.range(of: searchText, options: .caseInsensitive) != nil
        }))!
        
        tableView.reloadData()
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        return (section%2 == 0) ? "Games":"Love"
//    }
    
}


