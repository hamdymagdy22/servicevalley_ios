//
//  mainTableViewCell.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/24/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import KImageView
import SDWebImage
protocol CategoryRowDelegate:class {
    func cellTapped(data:IndexPath)
}


class mainTableViewCell: UITableViewCell {
    var indexPath:IndexPath!
    weak var delegate:CategoryRowDelegate?
    weak var navigationController: UINavigationController?
   
   
    @IBOutlet weak var services: UICollectionView!
  //  @IBOutlet weak var serviceName: UILabel!
    var service_list = [Service]()
    var subService_list = [subServices]()
    var subService_list_Two = [subServices]()
    func collectionReloadData(){
           DispatchQueue.main.async(execute: {
               self.services.reloadData()
           })
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        services.delegate = self
        services.dataSource = self
        collectionReloadData()
      //  services.reloadData()
        services.layer.cornerRadius = 15
     //   handleRefresh()
       // services.semanticContentAttribute = .forceRightToLeft
        
       // services.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
        services.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
        
        self.services.register(UINib(nibName: "FirstCellService", bundle: nil), forCellWithReuseIdentifier: "FirstCellCollectionViewCell")
       
      //  self.services.register(insideCollectionViewCell.self, forCellWithReuseIdentifier: "insideCollectionViewCell")
       // serviceName.set(image: UIImage(named: "service_valley_icon")
        if self.subService_list.count > 0 {
            self.services.scrollToItem(at: //scroll collection view to indexpath
                NSIndexPath.init(row:(self.services?.numberOfItems(inSection: 0))!-1, //get last item of self collectionview (number of items -1)
                    section: 0) as IndexPath //scroll to bottom of current section
                , at: UICollectionView.ScrollPosition.bottom, //right, left, top, bottom, centeredHorizontally, centeredVertically
                animated: true)
          //  services.collectionViewLayout = ArabicCollectionFlow()
        }
        
    }
//    @objc public func handleRefresh() {
//
//
//        API.getServicesData{ (error: Error?, services:[Service]?) in
//            if let services = services {
//                self.service_list = services
//                self.subService_list = (self.service_list.first?.subServiceArray)!
//              self.services.reloadData()
//
//    }
//        }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
}

extension mainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (service_list[section].subServiceArray.count+1)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0 ){
            let cell : FirstCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCellCollectionViewCell", for: indexPath) as! FirstCellCollectionViewCell
             cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            cell.bigView.layer.cornerRadius = 15
            cell.picView.roundCorners(corners: [ .bottomRight, .bottomLeft], radius: 15)
            cell.diamondView.addDiamondMask(cornerRadius: 7)
            cell.diamondView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
            cell.bigView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
            
            var strin = self.service_list[indexPath.row].ms_icon
            
            if  strin == nil {
                strin = "Service%20Valley%20Icon.png"
            }
            
            // self.imageView.image = UIImage(data: data)
           let imageName = "https://servicevalley.net/storage/app/public/mainservices_images/\(strin!)"
            let url = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
          //  let myURL = URL(string: url!)
            
            cell.imgBar.sd_setImage(with: URL(string:url!), placeholderImage: UIImage(named: "service_valley_logo"))
            cell.serviceName.text = self.service_list[indexPath.row].ms_name
            
            
            cell.isUserInteractionEnabled = false
            
             cell.layoutIfNeeded()
            return cell
        }
            
        else
        
         {
            
             let cell : insideCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "insideCollectionViewCell", for: indexPath) as! insideCollectionViewCell
           // cell.serviceImage.image = nil
      
        let ff =  URL(string: "http://servicevalley.net/loginCompany/Service%20Valley%20Icon.png")
            var strin = self.service_list[indexPath.section].subServiceArray[indexPath.item-1].s_image
            
        if  strin == nil {
            strin = "Service%20Valley%20Icon.png"
        }
            let imageName = "https://servicevalley.net/storage/app/public/pro_images/\(strin!)"
             let url = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            cell.serviceImage.sd_setImage(with: URL(string: url!), placeholderImage: UIImage(named: "service_valley_logo"))
        //  let url = URL(string: "https://servicevalley.net/storage/app/public/pro_images/"+strin! )

        // let url = URL(string: "https://servicevalley.net/storage/app/public/pro_images/"+strin)
 //cell.serviceImage.image = nil
        cell.collectionMainView.layer.cornerRadius = 15
            cell.collectionMainView.clipsToBounds = true
            cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        cell.serviceNameLbl.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
            

        cell.serviceNameLbl.text = self.service_list[indexPath.section].subServiceArray[indexPath.item-1].s_name
            cell.has_Product.text = String(self.service_list[indexPath.section].subServiceArray[indexPath.item-1].has_products!)
        
         
            cell.subServiceImageName.text = self.service_list[indexPath.section].subServiceArray[indexPath.item-1].s_image
        let x : Int =  self.service_list[indexPath.section].subServiceArray[indexPath.item-1].s_id!
        var mm = String(x)
         
            
        cell.subServiesID.text = mm
       cell.subServiesID.isHidden = true
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            cell.subServiceImageName.isHidden = true
            cell.serviceLogo.isHidden = true
            cell.servicePic.isHidden = true
            cell.mainServiceName.isHidden = true
            cell.has_Product.isHidden = true
            cell.serviceLogo.text = self.service_list[indexPath.section].ms_icon
            cell.mainServiceName.text = self.service_list[indexPath.section].ms_name
           
           // cell.subServiceImageName.text = self.service_list[indexPath.section].subServiceArray[indexPath.row].s_image
            cell.layoutIfNeeded()
            
            
        return cell
    }
        
    }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
            let selectedCell = collectionView.cellForItem(at: indexPath) as! insideCollectionViewCell
            let selectedSubServies = selectedCell.subServiesID.text
        let subServiesName = selectedCell.serviceNameLbl.text
     let serviesName = selectedCell.mainServiceName.text
    let serviceLogo = selectedCell.serviceLogo.text
       
    let subServiceImageName = selectedCell.subServiceImageName.text
    let has_products = selectedCell.has_Product.text
        
            let def = UserDefaults.standard
        
        def.setValue(selectedSubServies, forKey: "s_id")
    def.setValue(serviesName, forKey: "serviceName")
     def.setValue(serviceLogo, forKey: "serviceLogo")
    
        def.setValue(subServiesName, forKey: "subServiesName")
        def.setValue(subServiceImageName, forKey: "subServiceImageName")
    def.setValue(has_products, forKey: "has_products")
        def.synchronize()
    

        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
   
    

    
    // cell size
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width : CGFloat
        let height : CGFloat

        if indexPath.row == 0 {
            // First section
            width = 254
            height = 136

            return CGSize(width: width, height: height)

        }

        else

        {
            width =  242
            height = 136
            return CGSize(width: width, height: height)
        }


    }
    
}

extension UILabel {
    func set(image: UIImage) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentStr)
        
        let textString = NSAttributedString(string: text!, attributes: [NSAttributedString.Key.font: self.font])
        mutableAttributedString.append(textString)
        
        self.attributedText = mutableAttributedString
    }
}


extension UIApplication {
 
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}


extension UserDefaults {
    func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        set(imageData, forKey: key)
    }
}

    


