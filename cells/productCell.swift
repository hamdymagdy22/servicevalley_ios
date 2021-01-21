//
//  productCell.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/24/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
protocol productCellDelegate {
    
    
    
    func handleProductTapped(at index:IndexPath)
}
class productCell: UITableViewCell {
    var delegate: productCellDelegate?
    var indexPath:IndexPath!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var productNameView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var product_id: UILabel!
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        product_id.isHidden = true
        // Initialization code
        // self.buyBtn.isEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buyTapped(_ sender: UIButton) {
        if (sender.tag == 0) {
            
            self.delegate?.handleProductTapped(at: indexPath)
           
        }
    }
    
}
