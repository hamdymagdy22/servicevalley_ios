//
//  helper.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/27/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit

class helper: NSObject {
    
    class func saveEmail(token: String){
        let def = UserDefaults.standard
        def.setValue(token, forKey: "email")
        def.synchronize()
    }
    class func getEmail() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
        
    }
    class func getlang() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "lang") as? String
        
    }

    class func getL_name() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "l_name") as? String

    }
    class func getBuildingNo() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "buildingNo") as? String

    }
    class func getflatNo() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "flat") as? String

    }
    class func getL_Description() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "locationDiscription") as? String

    }
    class func getLongitude() -> Double? {
        let def = UserDefaults.standard
        return def.object(forKey: "Longitude") as? Double

    }
    class func getLatitude() -> Double? {
        let def = UserDefaults.standard
        return def.object(forKey: "Latitude") as? Double
        
}
    class func getSelectedSubServies() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "s_id") as? String
        
    }
    class func getUserName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "b_name") as? String
        
    }
    class func getDate() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "b_date") as? String
        
    }
    class func getTime() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "b_time") as? String
        
    }
    class func getUserId() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_id") as? Int
        
    }
    class func getLocationId() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "location_id") as? Int
        
    }
    class func getCompanyId() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "company_id") as? Int
        
    }
    class func getPassword() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "password") as? String
}
    class func getName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "name") as? String
        
    }
    class func getPhone1() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "phone1") as? String
}
    class func getPlayer_id() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "player_id") as? String
    }
    class func getL_id() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "l_id") as? Int
        
    }
    class func getcityName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "cityName") as? String
    }
    class func getaddressName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "addressName") as? String
    }
    class func getstreetName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "streetName") as? String
    }
    class func getbuildingNumber() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "buildingNumber") as? String
    }
    class func getflatNumber() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "flatNumber") as? String
    }
    class func getServiceLogo() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "serviceLogo") as? String
    }
    class func getServiceImage() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "serviceImage") as? String
    }
    class func getServiceName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "serviceName") as? String
    }
    class func getSubServiesName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "subServiesName") as? String
    }
    class func getSubServiceImageName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "subServiceImageName") as? String
    }
   
    


    class func getSubNumber() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "number") as? String

    }
    class func getSubType() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "type") as? String

    }
    class func getSubServ() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "subServ") as? String
        
}
    class func getProduct_id() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "product_id") as? Int
        
    }
    class func getHas_products() -> String? {
           let def = UserDefaults.standard
           return def.object(forKey: "has_products") as? String
           
       }
    class func getSub_id() -> String? {
           let def = UserDefaults.standard
           return def.object(forKey: "subservice_id") as? String
           
       }
       class func getType_id() -> String? {
              let def = UserDefaults.standard
              return def.object(forKey: "type_id") as? String
              
          }

//    class func getstarted_at() -> String? {
//        let def = UserDefaults.standard
//        return def.object(forKey: "started_at") as? String
//
//    }
//    class func getended_at() -> String? {
//        let def = UserDefaults.standard
//        return def.object(forKey: "ended") as? String
//
//    }
//    class func getNameRegister() -> String? {
//        let def = UserDefaults.standard
//        return def.object(forKey: "name") as? String
//
//}
//    class func getUserNameRegister() -> String? {
//        let def = UserDefaults.standard
//        return def.object(forKey: "username") as? String
//
//}
//    class func getPasswordRegister() -> String? {
//        let def = UserDefaults.standard
//        return def.object(forKey: "password") as? String
//
//}
//}
}
