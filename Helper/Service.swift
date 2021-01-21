//
//  Service.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 11/7/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import SwiftyJSON
class Service {
    
    var ms_id: String?
    var ms_name: String?
    var created_at: String?
    var updated_at: String?
    var ms_description: String?
    var ms_icon: String?
    var subServiceArray = [subServices]()
    
    init(ms_id: String?, ms_name: String?, created_at: String?,ms_icon:String?, ms_description: String?,updated_at: String?, subServiceArray: [Any]?) {
        self.ms_id = ms_id
        self.ms_name = ms_name
        self.created_at = created_at
        self.updated_at = updated_at
       self.ms_description = ms_description
        self.ms_icon = ms_icon
        
        if let subServiceArray = subServiceArray as? [[String: AnyObject]] {
            // lets iterate on the raw data
            subServiceArray.forEach({ (subServiceCandidates) in
                // Create category
                let subServiceCategory = subServices(s_id: subServiceCandidates["s_id"] as? Int,
                                                  s_name: subServiceCandidates["s_name"] as? String,
                                                  s_price: subServiceCandidates["s_price"] as? String,
                                                  s_description: subServiceCandidates["s_description"] as? String,
                                                  s_image: subServiceCandidates["s_image"] as? String,
                                                  created_at: subServiceCandidates["created_at"] as? String,
                                                  updated_at: subServiceCandidates["updated_at"] as? String,
                                                  company_id: subServiceCandidates["company_id"] as? String,
                                                  mainservice_id: subServiceCandidates["mainservice_id"] as? String,
                                                  has_products: subServiceCandidates["has_products"] as? Bool)
                // Append to our array
                self.subServiceArray.append(subServiceCategory)
            })
        }
    }
}
    
    
    class subServices {
        var s_id: Int?
        var s_name: String?
        var s_price: String?
        var s_description: String?
        var s_image: String?
        var created_at: String?
        var updated_at: String?
        var company_id: String?
        var mainservice_id: String?
        var has_products: Bool?

        
        init(s_id: Int?, s_name: String?, s_price: String?, s_description: String?,s_image: String?,created_at: String?,updated_at: String?,company_id: String?,mainservice_id: String?,has_products: Bool?) {
            self.s_id = s_id
            self.s_name = s_name
            self.s_description = s_description
            self.s_image = s_image
            self.created_at = created_at
            self.updated_at = updated_at
            self.company_id = company_id
            self.mainservice_id = mainservice_id
             self.has_products = has_products
            
    }
}

