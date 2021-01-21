//
//  myAddressCell.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/15/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
protocol AddressCellDelegate {
    
    func handleButtonTapped(at index:IndexPath)
    func didPressButton(at index:IndexPath)
    func handleEditingTapped(at index:IndexPath)
}

class myAddressCell: UITableViewCell {
    var indexPath:IndexPath!
    var delegate: AddressCellDelegate?
    
    @IBOutlet weak var containerView: UIView!
  // @IBOutlet weak var screenShotView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var viewMap: GMSMapView!
    @IBOutlet weak var mainAddressLabel: UILabel!
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var largeAddressLbl: UILabel!
    @IBOutlet weak var buildingNoLbl: UILabel!
    @IBOutlet weak var numberBuildingLbl: UILabel!
    @IBOutlet weak var flatNoLbl: UILabel!
    @IBOutlet weak var numberFlatLbl: UILabel!
    @IBOutlet weak var selectAddressBtn: UIButton!
    @IBOutlet weak var deleteAddressBtn: UIButton!
    @IBOutlet weak var editAddressBtn: UIButton!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var locationID: UILabel!
    
    
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        deleteAddressBtn.isUserInteractionEnabled = true
        largeAddressLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        buildingNoLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        flatNoLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        numberFlatLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
         numberBuildingLbl.textColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
       
        containerView.layer.cornerRadius = 20
        selectAddressBtn.clipsToBounds = true
        deleteAddressBtn.clipsToBounds = true
        editAddressBtn.clipsToBounds = true
        selectAddressBtn.layer.cornerRadius = 0.5 * selectAddressBtn.bounds.size.width
       

        deleteAddressBtn.layer.cornerRadius = 0.5 * deleteAddressBtn.bounds.size.width
        editAddressBtn.layer.cornerRadius = 0.5 * editAddressBtn.bounds.size.width
        viewMap.layer.cornerRadius = 20
        addressView.layer.cornerRadius = 20
        deleteAddressBtn.layer.borderWidth = 3
        deleteAddressBtn.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
        editAddressBtn.layer.borderWidth = 3
        editAddressBtn.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
        selectAddressBtn.layer.borderWidth = 3
        selectAddressBtn.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
     //   chechMarkView.layer.cornerRadius = 25
        
       
        selectAddressBtn.layer.masksToBounds = true
        
        
        upView.layer.cornerRadius = 0.5 * editAddressBtn.bounds.size.width
        upView.layer.borderWidth = 3
        upView.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
        upView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        selectAddressBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
       editAddressBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        deleteAddressBtn.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        
     //   chechMarkView.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
       addressView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        deleteAddressBtn.addTarget(self, action: #selector(deletePress), for: .touchUpInside)
      
    }
    
    @IBAction func selectedAddressTapped(_ sender: UIButton) {
        if (sender.tag == 0) {
            self.delegate?.handleButtonTapped(at: indexPath)
        }
    }
    @IBAction func deletePress(_ sender: UIButton) {
       if (sender.tag == 0) {
        self.delegate?.didPressButton(at: indexPath)
        }
        
    }
    
    @IBAction func editPrees(_ sender: UIButton) {
        if (sender.tag == 0) {
            self.delegate?.handleEditingTapped(at: indexPath)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
