//
//  models.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 10/28/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import Foundation

class userLocations: NSObject {
    
  var  l_id: Int = 0
   var l_name: String = ""
  var  l_url: String = ""
   var l_longitude: Double = 0
   var l_latitude: Double = 0
  var  l_area: String = ""
  var  l_governorate: String = ""
  var  l_block: String = ""
  var  l_building_number: String = ""
  var  l_flat_number: String = ""
  var  l_description: String = ""
   var user_id:Int = 0
   var created_at: String = ""
   var updated_at: String = ""
}
class companies: NSObject {
    
    var  c_id: Int = 0
    var c_name: String = ""
    var  c_image: String = ""
    var c_rate: String = ""
    var c_work_hours: String = ""
    var  c_base_price: String = ""
    var  c_description: String = ""
    var  s_id: Int = 0
    var  s_name: String = ""
    var  s_price: String = ""
    var  s_description: String = ""
    var s_image:String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var  c_location: String = ""
    var company_id: Int = 0
    var mainservice_id: Int = 0
    var  c_work_started_at: String = ""
  var  c_work_ended_at: String = ""
  var  c_guaranteed: String = ""
   var s_d_id:Int = 0
   var s_d_description: String = ""
  var  s_d_price: String = ""
    var service_id:Int = 0
    var total:Int = 0
 
    
}
class orders:NSObject{
 var   b_id_generator:Int = 0
  var   b_name: String = ""
  var   b_date: String = ""
 var    b_time: String = ""
 var    b_status: String = ""
  var   b_status2: String = ""
 var    location_id:Int = 0
 var    company_id:Int = 0
 var    user_id:Int = 0
 var    service_id:Int = 0
 var    offer_id:Int = 0
  var   s_name: String = ""
 var    created_at: String = ""
 var    deleted_at: String = ""
 var    flag: String = ""
    
    
}
class userData:NSObject{
    var   id:Int = 0
    var   name: String = ""
    var   email: String = ""
    var    password: String = ""
    var    phone1: String = ""
    var    phone2: String = ""
    var    l_description: String = ""
    var    l_flag: String = ""
    var    l_name: String = ""
    

    var    photo: String = ""
}
class photoGallery: NSObject {
    
    var  g_id: Int = 0
    var g_name: String = ""
    var  g_image:  String = ""
    
}
class cities: NSObject {
    
    var  city_id: Int = 0
    var city_name: String = ""
    
    
}
class servicesType: NSObject {
    
    var  service_id: Int = 0
    var t_name: String = ""
    var  t_id: Int = 0
   
}
class subServiceSelected: NSObject {
    
    var  service_id: Int = 0
    var sub_s_name: String = ""
    var  sub_s_id: Int = 0
    
}

class products: NSObject {
    
    var  pro_id: Int = 0
    var pro_name: String = ""
    var  pro_image: String = ""
    var pro_description: String = ""
    var pro_price: String = ""
    var  pro_status: Int = 0
    var  service_id:  Int = 0
    var company_id: Int = 0
    
    var  deleted_at: String = ""
    var  created_at: String = ""
    var  updated_at: String = ""
    var  c_name: String = ""
    var  c_image: String = ""
 
    
    
    
}

