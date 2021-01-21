//
//  insideCollectionViewCell.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/24/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit

class insideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionMainView: UIView!
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var serviceNameLbl: UILabel!
    @IBOutlet weak var subServiesID: UILabel!
    @IBOutlet weak var serviceLogo: UILabel!
    @IBOutlet weak var servicePic: UILabel!
    @IBOutlet weak var subServiceImageName: UILabel!
    @IBOutlet weak var mainServiceName: UILabel!
    @IBOutlet weak var has_Product: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
        
        serviceImage.image = nil
    }
}
