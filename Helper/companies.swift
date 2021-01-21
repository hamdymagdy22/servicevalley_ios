//
//  companies.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 4/15/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import SwiftyJSON
class companiesInfo {
    
    var c_id: Int?
    var c_name: String?
    var c_image: String?
    var c_rate: Int?
    var c_work_started_at: String?
    var c_work_ended_at: String?
    var c_base_price: String?
    var c_guaranteed: String?
    var c_description: String?
    
    var subServiceArray = [subServicesInfo]()
    
    init(c_id: Int?, c_name: String?, c_image: String?, c_rate: Int?,c_work_started_at: String?,c_work_ended_at: String?, c_base_price: String?, c_guaranteed: String?, c_description: String?, subServiceArray: [Any]?) {
        self.c_id = c_id
        self.c_name = c_name
        self.c_image = c_image
        self.c_rate = c_rate
        self.c_work_started_at = c_work_started_at
        self.c_work_ended_at = c_work_ended_at
        self.c_base_price = c_base_price
        self.c_guaranteed = c_guaranteed
        self.c_description = c_description
        
        if let subServiceArray = subServiceArray as? [[String: AnyObject]] {
            // lets iterate on the raw data
            subServiceArray.forEach({ (subServiceCandidates) in
                // Create category
                let subServiceCategory = subServicesInfo(s_id: subServiceCandidates["s_id"] as? Int,
                                                     s_name: subServiceCandidates["s_name"] as? String,
                                                     s_d_price: subServiceCandidates["s_d_price"] as? String,
                                                     s_d_description: subServiceCandidates["s_d_description"] as? String,
                                                     s_image: subServiceCandidates["s_image"] as? String)
                // Append to our array
                self.subServiceArray.append(subServiceCategory)
            })
        }
    }
}


class subServicesInfo {
    var s_id: Int?
    var s_name: String?
    var s_d_price: String?
    var s_d_description: String?
    var s_image: String?
    
    
    init(s_id: Int?, s_name: String?, s_d_price: String?, s_d_description: String?,s_image: String?) {
        self.s_id = s_id
        self.s_name = s_name
        self.s_d_description = s_d_description
        self.s_image = s_image
        self.s_d_price = s_d_price
        
        
    }
}
