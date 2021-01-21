//
//  API.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/9/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ArabicCollectionFlow: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        self.scrollDirection = .horizontal
    }
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
class API: NSObject {
   
    
    class func login ( email: String, password : String, completion: @escaping (_ error : Error?, _ success: Bool,_ state :Bool)->Void) {
        let url = "https://servicevalley.net/api/loginUser"
        let parameters = ["email" :  email,
                          "password": password]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    completion (error, false, false)
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    guard let userData = value as? [String : [Any]] else {
                        completion(nil, false, false)
                        return
                    }
                    guard let array  = userData["userData"] else {
                        completion(nil, false, false)
                        return
                    }
                    
                    let exist = array.count == 0
                    if exist {
                        
                        let def = UserDefaults.standard
                        def.setValue(email, forKey: "email")
                        def.synchronize()
                        completion(nil, true, true)
                        return
                    } else {
                        let def = UserDefaults.standard
                        def.setValue(email, forKey: "email")
                        def.synchronize()
                        completion (nil, true,false)
                        return
                    }
                    
                }
        }
}
    class func getUserData (email: String, password : String,player_id:String,completion: @escaping (_ error : Error?, _ user_list: [userData])->Void) {
        
        
        
        
        let lang = "ar"
        let url = "https://servicevalley.net/api/loginUser"
        let parameters = ["email" :  email,
                          "password":password,
                          "lang" : lang,
                          "player_id" : player_id ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["userData"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var user_list = [userData]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let user = userData()
                        user.id = data["id"]?.int ?? 0
                        user.email = data["email"]?.string ?? ""
                        user.name = data["name"]?.string ?? ""
                        user.phone1 = data["phone1"]?.string ?? ""
                        
                        user_list.append(user)
                        
                    }
                    completion(nil, user_list)
                    
                }
        }
    }

    class   func register (player_id:String,completion: @escaping (_ error : Error?, _ success: Bool,_ state :Bool)->Void) {
     
        guard let email = helper.getEmail()
            
            else {
                completion ( nil , false, false )
                return
        }
        guard let name = helper.getUserName()
            
            else {
                completion ( nil , false, false )
                return
        }
        
        guard let password = helper.getPassword()
            
            else {
                completion ( nil , false, false )
                return
        }
        guard let phone1 = helper.getPhone1()
            
            else {
                completion ( nil , false, false )
                return
        }
        
    let url = "https://servicevalley.net/api/registerUser"
    let parameters = ["name" : name,
                      "email" : email,
                      "password" : password,
                      "phone1": phone1,
                      "player_id" : player_id]
    
    Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        .validate(statusCode: 200..<300)
        .responseJSON { responce in
            switch responce.result
            {
            case .failure(let error):
                completion (error, false, false)
                
                print(error)
                
            case.success(let value):
                print(value)
                guard let userData = value as? [String : [Any]] else {
                    print("value")
                    completion(nil, false, false)
                    return
                }
                guard let array  = userData["userData"] else {
                    completion(nil, false, false)
                    return
                }
                
                let exist = array.count == 0
                if exist {
                    
                    let def = UserDefaults.standard
                    def.setValue(email, forKey: "email")
                    def.synchronize()
                    completion(nil, true, true)
                    return
                } else {
                    let def = UserDefaults.standard
                    def.setValue(email, forKey: "email")
                    def.synchronize()
                    completion (nil, true,false)
                    return
                }
            }
    }
}
    class func getUserLocations (completion: @escaping (_ error : Error?, _ location_list: [userLocations])->Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , [] )
            return
        }
        let lang = "ar"
        
//        guard let lang = helper.getlang() else {
//            completion ( nil , [] )
//            return
//        }
        
        let url = "https://servicevalley.net/api/getUserLocations"
        let parameters = ["email" :  email,
                          "lang" : lang ]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["userLocations"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var location_list = [userLocations]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let userLocation = userLocations()
                        userLocation.l_id = data["l_id"]?.int ?? 0
                        userLocation.l_name = data["l_name"]?.string ?? ""
                       userLocation.l_longitude = data["l_longitude"]?.double ?? 0
                        userLocation.l_latitude = data["l_latitude"]?.double ?? 0
                        userLocation.l_building_number = data["l_building_number"]?.string ?? ""
                        userLocation.l_flat_number = data["l_flat_number"]?.string ?? ""
                        userLocation.l_description = data["l_description"]?.string ?? ""
                        userLocation.user_id = data["user_id"]?.int ?? 0
                        
                        location_list.append(userLocation)
                        
                    }
                    completion(nil, location_list)
                    
                }
        }
    }
    class func addNewAddress(completion: @escaping (_ error : Error?, _ addNewLocation: userLocations?)->Void){
        guard let email = helper.getEmail() else {
            completion ( nil , nil )
            return
        }
        guard let l_name = helper.getL_name() else {
            completion ( nil , nil )
            return
        }
    
        guard let longitude = helper.getLongitude() else {
            completion ( nil , nil )
            return
        }
        guard let latitude = helper.getLatitude() else {
            completion ( nil , nil )
            return
        }
        guard let l_description = helper.getL_Description() else {
            completion ( nil , nil )
            return
        }
        guard let building_No = helper.getBuildingNo() else {
            completion ( nil , nil )
            return
        }
        guard let flat_No = helper.getflatNo() else {
            completion ( nil , nil )
            return
        }
        
        let url = "https://servicevalley.net/api/addUserLocation"
        let parameters = [ "email" :  email,
                           "l_name": l_name,
                           "l_building_number":building_No,
                           "l_flat_number": flat_No,
                           "l_longitude":longitude,
                           "l_latitude": latitude,
                           "l_description":l_description] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .validate(statusCode: 200..<900)
            
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion (error,nil )
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let data = json["userLocations"].dictionary  else  {return}
                    let newUserLocation = userLocations()
                    newUserLocation.l_id = data["l_id"]?.int ?? 0
                    newUserLocation.l_name = data["l_name"]?.string ?? ""
                    newUserLocation.l_longitude = data["l_longitude"]?.double ?? 0
                    newUserLocation.l_latitude = data["l_latitude"]?.double ?? 0
                    newUserLocation.l_building_number = data["l_building_number"]?.string ?? ""
                    newUserLocation.l_flat_number = data["l_flat_number"]?.string ?? ""
                   newUserLocation.l_description = data["l_description"]?.string ?? ""
                   newUserLocation.user_id = data["user_id"]?.int ?? 0
                    
                    completion (nil, newUserLocation)
                    
                }
        }
    }
    
    
    class func deleteAddress(l_id : Int, completion: @escaping (_ error : Error?, _ success: Bool)->Void){
//        guard let lang = helper.getlang() else {
//            completion ( nil , false )
//            return
//        }

        let lang = "en"
        let url = "https://servicevalley.net/api/deleteUserLocation"
        let parameters = ["l_id": l_id,
                          "lang" : lang] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            
            .responseString { response in
                
                switch response.result
                {
                case .failure(let error):
                    if response.response?.statusCode == 200 {
                        completion(nil, true)
                    } else {
                        completion (error,false )
                        print(error)
                    }
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let status = json["status"].toInt, status == 1 else {
                        completion(nil , false)
                        return
                    }
                    
                    
                    
                    completion (nil, true)
                    
                }
        }
        
        
        
    }
    
    class func getCompanies (completion: @escaping (_ error : Error?, _ company_list: [companies])->Void) {
       
        
       
        guard let service_id = helper.getSelectedSubServies() else {
            completion ( nil , [] )
            return
        }
        guard let number = helper.getSubNumber() else {
            completion ( nil , [] )
            return
        }
        guard let subservice_name = helper.getSubServ() else {
                   completion ( nil , [] )
                   return
               }
        guard let type_name = helper.getSubType() else {
            completion ( nil , [] )
            return
        }
       
        
         let lang = "ar"
       let sort = "total"
        let url = "https://servicevalley.net/api/companies"
       
        let parameters = ["service_id" :  service_id,
                          "lang" : lang,
                         "num" : number,
                         "sort":sort,
            "subservice_name" : subservice_name,
            "type_name":type_name] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):

                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companies"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var company_list = [companies]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let company = companies()
                        company.c_id = data["c_id"]?.int ?? 0
                        company.c_name = data["c_name"]?.string ?? ""
                        company.c_image = data["c_image"]?.string ?? ""
                        company.c_location = data["c_location"]?.string ?? ""
                        company.c_rate = data["c_rate"]?.string ?? ""
                        company.c_work_started_at = data["c_work_started_at"]?.string ?? ""
                         company.c_work_ended_at = data["c_work_ended_at"]?.string ?? ""
                        company.c_guaranteed = data["c_guaranteed"]?.string ?? ""
                        company.c_base_price = data["c_base_price"]?.string ?? ""
                        company.c_description = data["c_description"]?.string ?? ""
                        company.s_d_id = data["s_d_id"]?.int ?? 0
                        company.s_d_description = data["s_d_description"]?.string ?? ""
                        company.s_d_price = data["s_d_price"]?.string ?? ""
                        company.company_id = data["company_id"]?.int ?? 0
                        company.mainservice_id = data["mainservice_id"]?.int ?? 0
                       company.service_id = data["service_id"]?.int ?? 0
                        company.s_name = data["s_name"]?.string ?? ""
                        company.s_image = data["s_image"]?.string ?? ""
                         company.total = data["total"]?.int ?? 0
                        company_list.append(company)
                        
                    }
                    completion(nil, company_list)
                    
                }
        }
    }

    class func getCompanies2 (completion: @escaping (_ error : Error?, _ company_list: [companies])->Void) {
        
        
        guard let service_id = helper.getSelectedSubServies() else {
            completion ( nil , [] )
            return
        }
        guard let number = helper.getSubNumber() else {
            completion ( nil , [] )
            return
        }
        guard let subservice_name = helper.getSubServ() else {
                         completion ( nil , [] )
                         return
                     }
              guard let type_name = helper.getSubType() else {
                  completion ( nil , [] )
                  return
                
              }
        
      
        
        let lang = "ar"
        let url = "https://servicevalley.net/api/companies2"
        let sort = "total"
        let parameters = ["service_id" :  service_id,
                      "lang" : lang,
                     "num" : number,
                     "sort":sort,
        "subservice_name" : subservice_name,
        "type_name":type_name] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companies"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var company_list = [companies]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let company = companies()
                        company.c_id = data["c_id"]?.int ?? 0
                        company.c_name = data["c_name"]?.string ?? ""
                        company.c_image = data["c_image"]?.string ?? ""
                        company.c_location = data["c_location"]?.string ?? ""
                        company.c_rate = data["c_rate"]?.string ?? ""
                        company.c_work_started_at = data["c_work_started_at"]?.string ?? ""
                        company.c_work_ended_at = data["c_work_ended_at"]?.string ?? ""
                        company.c_guaranteed = data["c_guaranteed"]?.string ?? ""
                        company.c_base_price = data["c_base_price"]?.string ?? ""
                        company.c_description = data["c_description"]?.string ?? ""
                        company.s_d_id = data["s_d_id"]?.int ?? 0
                        company.s_d_description = data["s_d_description"]?.string ?? ""
                        company.s_d_price = data["s_d_price"]?.string ?? ""
                        company.company_id = data["company_id"]?.int ?? 0
                        company.mainservice_id = data["mainservice_id"]?.int ?? 0
                        company.service_id = data["service_id"]?.int ?? 0
                        company.s_name = data["s_name"]?.string ?? ""
                        company.s_image = data["s_image"]?.string ?? ""
                        company.total = data["total"]?.int ?? 0
                        company_list.append(company)
                        
                    }
                    completion(nil, company_list)
                    
                }
        }
    }
    class func getCompanies3 (completion: @escaping (_ error : Error?, _ company_list: [companies])->Void) {
        
        
        guard let service_id = helper.getSelectedSubServies() else {
            completion ( nil , [] )
            return
        }
        guard let number = helper.getSubNumber() else {
            completion ( nil , [] )
            return
        }
        guard let long = helper.getLongitude() else {
            completion ( nil , [] )
            return
        }
        guard let lat = helper.getLatitude() else {
                   completion ( nil , [] )
                   return
               }
        guard let subservice_name = helper.getSubServ() else {
                   completion ( nil , [] )
                   return
               }
        guard let type_name = helper.getSubType() else {
            completion ( nil , [] )
            return
        }
        
        
        
      
        
        let lang = "ar"
        let url = "https://servicevalley.net/api/companies"
        let sort = "nearest"
        let parameters = ["service_id" :  service_id,
                          "lang" : lang,
                          "num" : number,
                          "sort" : sort,
                          "long" : long,
                          "lat" : lat,
                         "subservice_name" : subservice_name,
                          "type_name":type_name] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companies"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var company_list = [companies]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let company = companies()
                        company.c_id = data["c_id"]?.int ?? 0
                        company.c_name = data["c_name"]?.string ?? ""
                        company.c_image = data["c_image"]?.string ?? ""
                        company.c_location = data["c_location"]?.string ?? ""
                        company.c_rate = data["c_rate"]?.string ?? ""
                        company.c_work_started_at = data["c_work_started_at"]?.string ?? ""
                        company.c_work_ended_at = data["c_work_ended_at"]?.string ?? ""
                        company.c_guaranteed = data["c_guaranteed"]?.string ?? ""
                        company.c_base_price = data["c_base_price"]?.string ?? ""
                        company.c_description = data["c_description"]?.string ?? ""
                        company.s_d_id = data["s_d_id"]?.int ?? 0
                        company.s_d_description = data["s_d_description"]?.string ?? ""
                        company.s_d_price = data["s_d_price"]?.string ?? ""
                        company.company_id = data["company_id"]?.int ?? 0
                        company.mainservice_id = data["mainservice_id"]?.int ?? 0
                        company.service_id = data["service_id"]?.int ?? 0
                        company.s_name = data["s_name"]?.string ?? ""
                        company.s_image = data["s_image"]?.string ?? ""
                        company.total = data["total"]?.int ?? 0
                        company_list.append(company)
                        
                    }
                    completion(nil, company_list)
                    
                }
        }
    }
    class func getProducts (completion: @escaping (_ error : Error?, _ product_list: [products])->Void) {
        
        
        
        guard let service_id = helper.getSelectedSubServies() else {
            completion ( nil , [] )
            return
        }
        guard let company_id = helper.getCompanyId() else {
            completion ( nil , [] )
            return
        }
        
        let lang = "ar"
        let url = "https://servicevalley.net/api/getAllProducts"
        let num = "1"
        let parameters = ["service_id" :  service_id,
                          "company_id":company_id,
                          "lang" : lang] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["products"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var product_list = [products]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let product = products()
                        product.pro_id = data["pro_id"]?.int ?? 0
                        product.pro_name = data["pro_name"]?.string ?? ""
                        product.pro_image = data["pro_image"]?.string ?? ""
                        product.pro_description = data["pro_description"]?.string ?? ""
                        product.pro_price = data["pro_price"]?.string ?? ""
                        product.deleted_at = data["deleted_at"]?.string ?? ""
                        product.created_at = data["created_at"]?.string ?? ""
                        product.updated_at = data["updated_at"]?.string ?? ""
                        product.pro_status = data["pro_status"]?.int ?? 0
                        product.company_id = data["company_id"]?.int ?? 0
                        
                        product.service_id = data["service_id"]?.int ?? 0
                        product.c_name = data["c_name"]?.string ?? ""
                        product.c_image = data["c_image"]?.string ?? ""
                      
                        product_list.append(product)
                        
                    }
                    completion(nil, product_list)
                    
                }
        }
    }
    
    class func getServicesData (completion: @escaping (_ error : Error?, _ services: [Service])->Void) {
        //        guard let lang = helper.getLang() else {
        //            completion ( nil , [] )
        //            return
        //        }
        let lang = "ar"
        
        let url = "https://servicevalley.net/api/homepage"
        let parameters = ["lang" :  lang]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["services"].array else
                    {
                        completion (nil, [] )
                        return
                    }
                    
                    var services = [Service]()
                    for serviceJSON in dataArr {
                        guard let service = serviceJSON.dictionary else {return}
                        let serviceObject = Service(ms_id: (service["ms_id"]?.string),
                                                      ms_name: (service["ms_name"]?.string),
                                                      created_at: (service["created_at"]?.string),
                                                      ms_icon: (service["ms_icon"]?.string),
                                                      ms_description: (service["ms_description"]?.string),
                                                      updated_at: (service["updated_at"]?.string),
                                                      subServiceArray: service["subservices"]?.arrayObject)
                      
                        services.append(serviceObject)
                    }
                    completion(nil, services)
                    
                }
                
        }
    }

    class func addNewOrders (completion: @escaping (_ error : Error?, _ order_list: [orders])->Void) {
        
        guard let b_name = helper.getUserName() else {
            completion ( nil , [] )
            return
        }
        guard let b_time = helper.getTime() else {
            completion ( nil , [] )
            return
        }
        guard let b_date = helper.getDate() else {
            completion ( nil , [] )
            return
        }
        guard let location_id = helper.getLocationId() else {
            completion ( nil , [] )
            return
        }
        guard let user_id = helper.getUserId() else {
            completion ( nil , [] )
            return
        }
        guard let company_id = helper.getCompanyId() else {
            completion ( nil , [] )
            return
        }
        guard let service_id = helper.getSelectedSubServies() else {
            completion ( nil , [] )
            return
        }
        guard let subservice_id = helper.getSub_id() else {
                   completion ( nil , [] )
                   return
               }
        guard let number = helper.getSubNumber() else {
            completion ( nil , [] )
            return
        }
        guard let type_id = helper.getType_id() else {
                        completion ( nil , [] )
                        return
                    }
    let product_id = helper.getProduct_id()
        
        let type_id2:Int? = Int(type_id)
            
    
        let subservice_id2:Int? = Int(subservice_id)
    //    let product_id2 = Int(product_id)
    
       
        let lang = "ar"
        let url = "https://servicevalley.net/api/addOrder"
        let parameters = ["b_date" :  b_date,
                          "lang" : lang,
                          "b_name": b_name,
                          "b_time": b_time,
                          "user_id" : user_id,
                          "subservice_id": subservice_id2 ?? "",
                          "type_id" : type_id2 ?? "",
                          "b_num" : number,
                          
                          "location_id": location_id,
                          "company_id": company_id,
                          "service_id":service_id,
                          "product_id" : product_id  ?? ""] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["orders"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var order_list = [orders]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let order = orders()
                        order.b_id_generator = data["b_id_generator"]?.int ?? 0
                        order.b_name = data["b_name"]?.string ?? ""
                        order.b_date = data["b_date"]?.string ?? ""
                        order.b_time = data["b_time"]?.string ?? ""
                        order.b_status = data["b_status"]?.string ?? ""
                        order.location_id = data["location_id"]?.int ?? 0
                        order.company_id = data["company_id"]?.int ?? 0
                        order.user_id = data["user_id"]?.int ?? 0
                        order.service_id = data["service_id"]?.int ?? 0
                        order.offer_id = data["offer_id"]?.int ?? 0
                        order.s_name = data["s_name"]?.string ?? ""
                        order.created_at = data["created_at"]?.string ?? ""
                        order.deleted_at = data["deleted_at"]?.string ?? ""
                        order.flag = data["flag"]?.string ?? ""
                        
                        order_list.append(order)
                        
                    }
                    completion(nil, order_list)
                    
                }
        }
    }
    
    class func getOrders (completion: @escaping (_ error : Error?, _ order_list: [orders])->Void) {
        
        guard let user_id = helper.getUserId() else {
            completion ( nil , [] )
            return
        }
        let lang = "ar"
        let url = "https://servicevalley.net/api/history"
        let parameters = ["user_id" : user_id,
                          "lang" : lang] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["orders"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var order_list = [orders]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let order = orders()
                        order.b_id_generator = data["b_id_generator"]?.int ?? 0
                        order.b_name = data["b_name"]?.string ?? ""
                        order.b_date = data["b_date"]?.string ?? ""
                        order.b_time = data["b_time"]?.string ?? ""
                        order.b_status = data["b_status"]?.string ?? ""
                         order.b_status2 = data["b_status2"]?.string ?? ""
                        order.location_id = data["location_id"]?.int ?? 0
                        order.company_id = data["company_id"]?.int ?? 0
                        order.user_id = data["user_id"]?.int ?? 0
                        order.service_id = data["service_id"]?.int ?? 0
                        order.offer_id = data["offer_id"]?.int ?? 0
                        order.s_name = data["s_name"]?.string ?? ""
                        order.created_at = data["created_at"]?.string ?? ""
                        order.deleted_at = data["deleted_at"]?.string ?? ""
                        order.flag = data["flag"]?.string ?? ""
                        
                        order_list.append(order)
                        
                    }
                    completion(nil, order_list)
                    
                }
        }
    }
    class func deleteOrder(b_id_generator : Int, completion: @escaping (_ error : Error?, _ success: Bool)->Void){
        guard let email = helper.getEmail() else {
            completion ( nil , false )
            return
        }
        guard let b_name = helper.getUserName() else {
            completion ( nil , false )
            return
        }
        
         let lang = "en"
        let url = "https://servicevalley.net/api/deleteOrder"
        let parameters = ["b_id_generator": b_id_generator,
                          "lang" :lang,
                          "email":email] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            
            .responseString { response in
                
                switch response.result
                {
                case .failure(let error):
                    if response.response?.statusCode == 200 {
                        completion(nil, true)
                    } else {
                        completion (error,false )
                        print(error)
                    }
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
//                    guard let status = json["status"].toInt, status == 1 else {
//                        completion(nil , false)
//                        return
//                    }
                    
                    
                    
                    completion (nil, true)
                    
                }
        }
        
        
        
    }
    
    class func getCompanyDetails (completion: @escaping (_ error : Error?, _ companyInfo_List: [companiesInfo])->Void) {
        guard let company_id = helper.getCompanyId() else {
            completion ( nil , [] )
            return
        }
        let lang = "ar"
        
        let url = "https://servicevalley.net/api/companyDetails"
        let parameters = ["lang" :  lang,
                          "company_id":company_id] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["companies"].array else
                    {
                        completion (nil, [] )
                        return
                    }
                    
                    var companyInfo_List = [companiesInfo]()
                    for serviceJSON in dataArr {
                        guard let service = serviceJSON.dictionary else {return}
                        let serviceObject = companiesInfo(c_id: (service["c_id"]?.int),
                                                    c_name: (service["c_name"]?.string),
                                                    c_image: (service["c_image"]?.string),
                                                    c_rate: (service["c_rate"]?.int),
                                                    c_work_started_at: (service["c_work_started_at"]?.string),
                                                    c_work_ended_at: (service["c_work_ended_at"]?.string),
                                                    c_base_price: (service["c_base_price"]?.string),
                                                    c_guaranteed: (service["c_guaranteed"]?.string),
                                                    c_description: (service["c_description"]?.string),
                                                    subServiceArray: service["subservices"]?.arrayObject)
                        
                        companyInfo_List.append(serviceObject)
                    }
                    completion(nil, companyInfo_List)
                    
                }
                
        }
    }
    class func getProfileData (completion: @escaping (_ error : Error?, _ profile_list: [userData])->Void) {
        
        
        
        guard let email = helper.getEmail() else {
            completion ( nil , [] )
            return
        }
        let lang = "ar"
        let url = "https://servicevalley.net/api/getProfileData"
        let parameters = ["email" :  email,
                          "lang" : lang ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["userData"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var profile_list = [userData]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let profile = userData()
                        profile.id = data["id"]?.int ?? 0
                        profile.name = data["name"]?.string ?? ""
                        profile.email = data["email"]?.string ?? ""
                        profile.password = data["password"]?.string ?? ""
                        profile.phone1 = data["phone1"]?.string ?? ""
                        profile.phone2 = data["phone2"]?.string ?? ""
                        profile.photo = data["photo"]?.string ?? ""
                        profile.l_description = data["l_description"]?.string ?? ""
                        profile.l_name = data["l_name"]?.string ?? ""
                    profile_list.append(profile)
                    }
                    completion(nil, profile_list)
                    
                }
        }
    }
    class func  updateUserData (newEmail: String, newName: String , newPhone: String , newPassword:String, oldEmail: String , oldPhone: String ,
                                oldName: String , oldPassword: String ,  completion: @escaping (_ error : Error?,  _ user_list: [userData])->Void) {
        
        let lang = "ar"
       
        let url = "https://servicevalley.net/api/editProfile"
        let parameters = ["email" :  oldEmail,
                          "newemail": newEmail,
                          "name": oldName,
                          "newname":newName,
                          "phone1": oldPhone,
                          "newphone1": newPhone,
                          "lang":lang,
                          "password":oldPassword,
                          "newpassword":newPassword  ]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["userData"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var user_list = [userData]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let user = userData()
                        user.id = data["id"]?.int ?? 0
                        user.name = data["name"]?.string ?? ""
                        user.email = data["email"]?.string ?? ""
                        user.password = data["password"]?.string ?? ""
                        user.phone1 = data["phone1"]?.string ?? ""
                        user.phone2 = data["phone2"]?.string ?? ""
                        user.photo = data["photo"]?.string ?? ""
                        user.l_description = data["l_description"]?.string ?? ""
                        user.l_name = data["l_name"]?.string ?? ""
                    
                        
                        print(user)
                        
                        user_list.append(user)
                        
                    }
                    completion(nil, user_list)
                    
                }
        }
    }
    class func getProfileData2 (email: String,completion: @escaping (_ error : Error?, _ profile_list: userData?)->Void) {
        
        
        let lang = "ar"
        let url = "https://servicevalley.net/api/getProfileData"
        let parameters = ["email" :  email,
                          "lang" : lang ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let data = json["userData"].dictionary  else  {return}
                    
                    let profile = userData()
                    profile.id = data["id"]?.int ?? 0
                    profile.name = data["name"]?.string ?? ""
                    profile.email = data["email"]?.string ?? ""
                    profile.password = data["password"]?.string ?? ""
                    profile.phone1 = data["phone1"]?.string ?? ""
                    profile.phone2 = data["phone2"]?.string ?? ""
                    profile.photo = data["photo"]?.string ?? ""
                    profile.l_description = data["l_description"]?.string ?? ""
                    
                    completion(nil, profile)
                    
                }
                
        }
    }
    class func logOut ( completion: @escaping (_ error : Error?, _ success: Bool)->Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , false )
            return
        }
        
        guard let player_id = helper.getPlayer_id() else {
            completion ( nil , false )
            return
        }
        
        let url = "https://servicevalley.net/api/logoutUser"
        let parameters = ["email" :  email,
                          "player_id": player_id]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseString { responce in
                switch responce.result
                {
                    
                case .failure(let error):
                    completion (error, false)
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    
                    
                    completion (nil, true)
                }
        }
    }
    class func editAddress(l_name : String, l_building_number:String,l_flat_number:String,l_area:String,l_flag:String,l_description:String,  completion: @escaping (_ error : Error?, _ success: Bool)->Void){
      
        guard let email = helper.getEmail() else {
            completion ( nil , false )
            return
        }
        guard let l_id = helper.getL_id() else {
            completion ( nil , false )
            return
        }
        guard let longitude = helper.getLongitude() else {
            completion ( nil , false )
            return
        }
        guard let latitude = helper.getLatitude() else {
            completion ( nil , false )
            return
        }
        
        let l_flag = "0"
        
        let lang = "ar"
        let url = "https://servicevalley.net/api/updateUserLocation"
        let parameters = ["email" :  email,
                          "lang" : lang,
                          "l_id": l_id,
                          "l_name": l_name,
                          "l_building_number" : l_building_number,
                          "l_flat_number": l_flat_number,
                          "l_area": l_area,
                          "l_flag":l_flag,
                              "l_description":l_description] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            
            .responseString { response in
                
                switch response.result
                {
                case .failure(let error):
                    if response.response?.statusCode == 200 {
                        completion(nil, true)
                    } else {
                        completion (error,false )
                        print(error)
                    }
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    
                    completion (nil, true)
                    
                }
        }
        
        
        
    }
    
    class func cancelOrder( b_id_generator: Int ,  completion: @escaping (_ error : Error?, _ success: Bool)->Void){
        
      
        let lang = "ar"
        let url = "https://servicevalley.net/api/cancelStatus"
        let parameters = [
                          "b_id_generator":b_id_generator,
                          "lang":lang] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            
            .responseString { response in
                
                switch response.result
                {
                case .failure(let error):
                    if response.response?.statusCode == 200 {
                        completion(nil, true)
                    } else {
                        completion (error,false )
                        print(error)
                    }
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    
                    completion (nil, true)
                }
        }
        
        
        
    }
    class func getAllPhotoGallaries (completion: @escaping (_ error : Error?, _ gallaris_list: [photoGallery])->Void) {
        
        
        
        
        let url = "https://servicevalley.net/api/getAllPhotoGallery"
        
        let parameters = [:] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    
                    let json = JSON(value)
                    
                    guard let dataArr = json["photoGallery"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var gallaris_list = [photoGallery]()
                    
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = photoGallery()
                        
                        person.g_id = data["g_id"]?.int ?? 0
                        person.g_name = data["g_name"]?.string ?? ""
                        
                        person.g_image = data["g_image"]?.string ?? ""
                        
                        gallaris_list.append(person)
                        
                    }
                    
                    completion(nil, gallaris_list)
                    
                }
                
        }
        
    }
    
    class func getCities (completion: @escaping (_ error : Error?, _ city_list: [cities])->Void) {
//        guard let email = helper.getEmail() else {
//            completion ( nil , [] )
//            return
//        }
        let lang = "ar"
        
        //        guard let lang = helper.getlang() else {
        //            completion ( nil , [] )
        //            return
        //        }
        
        let url = "http://servicevalley.net/api/get/cities"
        let parameters = ["lang" : lang ]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["cities"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var city_list = [cities]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let city = cities()
                        city.city_id = data["city_id"]?.int ?? 0
                        city.city_name = data["city_name"]?.string ?? ""
                       
                        
                        city_list.append(city)
                        
                    }
                    completion(nil, city_list)
                    
                }
        }
    }
    class func getSersType (completion: @escaping (_ error : Error?, _ service_Type: [servicesType])->Void) {
        
        
        
        
        let url = "https://servicevalley.net/api/getTypes"
        let lang = "ar"
        guard let service_id = helper.getSelectedSubServies() else {
            completion ( nil , [] )
            return
        }
        let parameters = [
            "service_id":service_id,
            "lang":lang] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["types"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    var service_Type = [servicesType]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = servicesType()
                        person.service_id = data["service_id"]?.int ?? 0
                        person.t_name = data["t_name"]?.string ?? ""
                         person.t_id = data["t_id"]?.int ?? 0
                        
                        service_Type.append(person)
                        
                    }
                    completion(nil, service_Type)
                    
                }
        }
    }
    class func getServicesType (completion: @escaping (_ error : Error?, _ service_Type: [types])->Void) {
        
        
        
        
        let url = "https://servicevalley.net/api/getTypes"
        let lang = "ar"
        guard let service_id = helper.getSelectedSubServies() else {
            completion ( nil , [] )
            return
        }
        let parameters = [
            "service_id":service_id,
            "lang":lang] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                                   
                                   print(error)
                                   
                               case.success(let value):
                                   
                                   print(value)
                                   let json = JSON(value)
                                   guard let dataArr = json["types"].array else
                                   {
                                       completion (nil, [] )
                                       return
                                   }
                                   
                                   var services = [types]()
                                   for serviceJSON in dataArr {
                                       guard let service = serviceJSON.dictionary else {return}
                                       let serviceObject = types(service_id: (service["service_id"]?.int),
                                                                     t_name: (service["t_name"]?.string),
                                                                     t_id: (service["t_id"]?.int),
                                                                     
                                                                     typesArray: service["type_subservices"]?.arrayObject)
                                     
                                       services.append(serviceObject)
                                   }
                                   completion(nil, services)
                                   
                               }
                               
                       }
                   }
    class func getSubServicesSelected (completion: @escaping (_ error : Error?, _ subServices_selected: [subServiceSelected])->Void) {
        
        
        
        
        let url = "https://servicevalley.net/api/getSubservices"
        
        let lang = "ar"
        guard let service_id = helper.getSelectedSubServies() else {
            completion ( nil , [] )
            return
        }
        let parameters = [
            "service_id":service_id,
            "lang":lang] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["subservices"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    var subServices_selected = [subServiceSelected]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let person = subServiceSelected()
                        person.service_id = data["service_id"]?.int ?? 0
                        person.sub_s_name = data["sub_s_name"]?.string ?? ""
                        person.sub_s_id = data["sub_s_id"]?.int ?? 0
                        
                        subServices_selected.append(person)
                        
                    }
                    completion(nil, subServices_selected)
                    
                }
        }
    }
    class func checkNumber(phone: String, completion: @escaping (_ error : Error?, _ success: Bool)->Void) {
             let url = "http://servicevalley.net/api/validatePhoneNumber"
             let parameters = ["phone" :  phone ]
             Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
             
                 .validate(statusCode: 200..<900)
                  .responseJSON { response in
                             
                             switch response.result
                             {
                             case .failure(let error):
                              
                                     completion (error,false )
                                     print(error)
                                 
                                 
                             case.success(let value):
                                print(value)
                             let json = JSON(value)
                                 
                             
                                if let  ww = json["unique"].bool {
                                    print(ww)
                                       completion (nil,true )
                                }
                                else
                                {
                                    completion (nil,false )
                                }
                     }
                     
}
}
}
