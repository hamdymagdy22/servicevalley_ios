//
//  types.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/29/20.
//  Copyright © 2020 Parth Changela. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class types  {
    
    

    var service_id: Int?
    var t_name: String?
    var t_id: Int?
   
    var typesArray = [type_subservices]()
    
    init(service_id: Int?, t_name: String?, t_id: Int?, typesArray: [Any]?) {
        self.service_id = service_id
        self.t_name = t_name
        self.t_id = t_id
          
        
        if let typesArray = typesArray as? [[String: AnyObject]] {
            // lets iterate on the raw data
            typesArray.forEach({ (subServiceCandidates) in
                // Create category
                let subServiceCategory = type_subservices(sub_s_id: subServiceCandidates["sub_s_id"] as? Int,
                                                  sub_s_name: subServiceCandidates["sub_s_name"] as? String,
                                                  sub_s_price: subServiceCandidates["sub_s_price"] as? String,
                                                  sub_s_notes: subServiceCandidates["sub_s_notes"] as? String,
                                                  service_id: subServiceCandidates["service_id"] as? Int,
                                                  company_id: subServiceCandidates["company_id"] as? Int,
                                                  type_name: subServiceCandidates["type_name"] as? String
                                                 )
                // Append to our array
                self.typesArray.append(subServiceCategory)
            })
        }
    }
}
class type_subservices: Hashable{
    static func == (lhs: type_subservices, rhs: type_subservices) -> Bool {
        return lhs.sub_s_name == rhs.sub_s_name
    }
    
//    static func == (lhs: type_subservices, rhs: type_subservices) -> Bool {
//        return lhs.sub_s_name == rhs.sub_s_name
//    }
    
        var sub_s_id: Int?
        var sub_s_name: String?
    var hashValue: Int { get { return sub_s_name.hashValue } }
        var sub_s_price: String?
        var sub_s_notes: String?
        var service_id: Int?
        var company_id: Int?
        var type_name: String?
       

        
        init(sub_s_id: Int?, sub_s_name: String?, sub_s_price: String?, sub_s_notes: String?,service_id: Int?,company_id: Int?,type_name: String?) {
            self.sub_s_id = sub_s_id
            self.sub_s_name = sub_s_name
            self.sub_s_price = sub_s_price
            self.sub_s_notes = sub_s_notes
            self.service_id = service_id
            self.company_id = company_id
            self.type_name = type_name
            
            
    }
   

}


//class types2 {
//
//    var service_id: Int?
//    var t_name: String?
//    var t_id: Int?
//
//    var typesArray = [type_subservices2]()
//
//    init(service_id: Int?, t_name: String?, t_id: Int?, typesArray: [Any]?) {
//        self.service_id = service_id
//        self.t_name = t_name
//        self.t_id = t_id
//
//
//        if let typesArray = typesArray as? [[String: AnyObject]] {
//            // lets iterate on the raw data
//            typesArray.forEach({ (subServiceCandidates) in
//                // Create category
//                let subServiceCategory = type_subservices2(sub_s_id: subServiceCandidates["sub_s_id"] as? Int,
//                                                  sub_s_name: subServiceCandidates["sub_s_name"] as? String,
//                                                  sub_s_price: subServiceCandidates["sub_s_price"] as? String,
//                                                  sub_s_notes: subServiceCandidates["sub_s_notes"] as? String,
//                                                  service_id: subServiceCandidates["service_id"] as? Int,
//                                                  company_id: subServiceCandidates["company_id"] as? Int,
//                                                  type_name: subServiceCandidates["type_name"] as? String
//                                                 )
//                // Append to our array
//                self.typesArray.append(subServiceCategory)
//            })
//        }
//    }
//}
//class type_subservices2 :Equatable{
//    static func == (lhs: type_subservices2, rhs: type_subservices2) -> Bool {
//        return lhs.sub_s_name == rhs.sub_s_name
//    }
//
//
//        var sub_s_id: Int?
//        var sub_s_name: String?
//        var sub_s_price: String?
//        var sub_s_notes: String?
//        var service_id: Int?
//        var company_id: Int?
//        var type_name: String?
//
//
//
//        init(sub_s_id: Int?, sub_s_name: String?, sub_s_price: String?, sub_s_notes: String?,service_id: Int?,company_id: Int?,type_name: String?) {
//            self.sub_s_id = sub_s_id
//            self.sub_s_name = sub_s_name
//            self.sub_s_price = sub_s_price
//            self.sub_s_notes = sub_s_notes
//            self.service_id = service_id
//            self.company_id = company_id
//            self.type_name = type_name
//
//
//    }
//}

