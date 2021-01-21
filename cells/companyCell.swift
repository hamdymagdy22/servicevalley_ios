//
//  companyCell.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 11/6/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import Cosmos
protocol CompanyCellDelegate {
    
    func handleButtonTapped(at index:IndexPath)

    func handleCompanyTapped(at index:IndexPath)
}
class companyCell: UITableViewCell {
    var delegate: CompanyCellDelegate?
    var indexPath:IndexPath!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var companyCell: UIImageView!
    @IBOutlet weak var madmonView: UIView!
    @IBOutlet weak var madmonLbl: UILabel!
    @IBOutlet weak var madmonCheckImage: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var fromlabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var companyDetailsBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var companyID: UILabel!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var nameView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        self.selectBtn.isEnabled = true
     self.companyDetailsBtn.isEnabled = true
        containerView.layer.cornerRadius = 10
        madmonView.layer.cornerRadius = 0.5 * madmonView.bounds.size.height
        madmonCheckImage.addShadow()
        companyDetailsBtn.layer.cornerRadius = 15
        selectBtn.layer.cornerRadius = 15
        middleView.layer.cornerRadius = 15

        madmonView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        
       
        companyID.isHidden = true
    }
    
    @IBAction func goToOrders(_ sender: UIButton) {
        if (sender.tag == 0) {
            
            self.delegate?.handleButtonTapped(at: indexPath)
           // (sender as? UIButton)?.isEnabled = false
        }
        
    }
    
    @IBAction func goToCompanyDetails(_ sender: UIButton) {
        if (sender.tag == 0) {
            self.delegate?.handleCompanyTapped(at: indexPath)
            // (sender as? UIButton)?.isEnabled = false
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
