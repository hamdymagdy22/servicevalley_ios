//
//  profilePage.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 4/21/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import Alamofire

class profilePage: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    var imagePicker : UIImagePickerController = UIImagePickerController()
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var barBtn: UIBarButtonItem!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordChangeBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var myAddressesBtn: UIButton!
    @IBOutlet weak var emailChangeBtn: UIButton!
    
    var profile_list = [userData]()
    var refresher : UIRefreshControl!
    var selectedImage: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "الحساب الشخصي"
    }
   
    @IBAction func homePageTapped(_ sender: Any) {
       UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "SWRevealViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            
            
            barBtn.target = revealViewController()
            barBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
             self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealWidth = 0
           
            
            
        }
        if isFaceBookLogIn(){
            
            self.passwordChangeBtn.isUserInteractionEnabled = false
        }
        imagePicker.delegate = self
       // let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
       // userPic.isUserInteractionEnabled = true
     //   userPic.addGestureRecognizer(singleTap)
        let titleColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor , NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 19)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
       
        handleRefresh()
        self.view.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
         userPic.layer.cornerRadius = userPic.frame.height/2
        userPic.layer.masksToBounds = false
        userPic.clipsToBounds = true
        passwordChangeBtn.layer.cornerRadius = 15
        editProfileBtn.layer.cornerRadius = 15
        myAddressesBtn.layer.cornerRadius = 15
        emailChangeBtn.layer.cornerRadius = 15
        passwordChangeBtn.backgroundColor = UIColor.white
        editProfileBtn.backgroundColor = UIColor.white
        myAddressesBtn.backgroundColor = UIColor.white
        emailChangeBtn.backgroundColor = UIColor.white
    //    addPic.layer.cornerRadius = addPic.frame.height/2
        

        

        // Do any additional setup after loading the view.
    }
    
    @objc func tapDetected() {
        let alertController : UIAlertController = UIAlertController(title: "Title", message: "Select Camera or Photo Library", preferredStyle: .actionSheet)
        let cameraAction : UIAlertAction = UIAlertAction(title: "Camera", style: .default, handler: {(cameraAction) in
            print("camera Selected...")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) == true {
                
                self.imagePicker.sourceType = .camera
                self.present()
                
            }else{
                self.present(self.showAlert(Title: "Title", Message: "Camera is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)
                
            }
            
        })
        
        let libraryAction : UIAlertAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(libraryAction) in
            
            print("Photo library selected....")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) == true {
                
                self.imagePicker.sourceType = .photoLibrary
                self.present()
                
            }else{
                
                self.present(self.showAlert(Title: "Title", Message: "Photo Library is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)
            }
        })
        
        let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel , handler: {(cancelActn) in
            print("Cancel action was pressed")
        })
        
        alertController.addAction(cameraAction)
        
        alertController.addAction(libraryAction)
        
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    func present(){
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
   
    
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.png")
        // extract image from the picker and save it
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let data = pickedImage.jpegData(compressionQuality: 0.2)
            try! data?.write(to:imagePath!)
            
        }
        uploadImage(path: imagePath!)
        self.dismiss(animated: true, completion: nil)
    }
    
    
func uploadImage(path:URL){
 //let imgData = userPic.image!.jpegData(compressionQuality: 1.5)
   let image = userPic.image
    let imgData = userPic.image!.pngData()
//    let base64String = convertToBase64(image: image!)
  //  print(base64String)
//    let strBase1 = base64String.replacingOccurrences(of: "+", with: "%2B", options: NSString.CompareOptions.literal, range: nil)
//    let str =  strBase1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  
 
    let url = ("https://servicevalley.net/api/uploadImg")
   
    
   
    var parameters : [String:Any] = [:]
    parameters["email"] = "andrew@andrew.com"
    parameters["photo"] = path
    parameters["lang"] = "ar"
    

    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
        for (key, value) in parameters {
            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
        }
        
       
        multipartFormData.append(imgData!, withName: "image_url", fileName: "image.png", mimeType: "image/png")
      
        
    }, usingThreshold: UInt64.init(), to: url, method: .post) { (result) in
        switch result {
        case .success(let upload, _, _):
            
            upload.responseString { response in
                
                print(response.result)
                print("Response : ", response.result.value!)
                
                if response.result.isSuccess
                {
                    let JSON = response.result.value! as? NSDictionary
                    
                    print("EditJSON : ", JSON!)
                }
            }
        case .failure(let encodingError):
            print(encodingError)
        }
    }
    }

    
    func postData(path:URL){
        let imageData = userPic.image!.jpegData(compressionQuality: 0.2)
        
       // let parameters = ["email":"andrew@andrew.com", "photo": imageData] as [String : Any]

        let url = "https://servicevalley.net/api/uploadImg" /* your API url */

        let headers = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "Cache-Control": "no-cache",
            "Postman-Token": "cab7b50f-16f6-4717-b12d-3dc7d3f878d0"
        ]
        let parameters = [
            [
                "name": "photo",
                "filename": path
            ],
            [
                "name": "email",
                "value": "andrew@andrew.com"
            ]
        ]

        let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"

        var body = ""
        var error: NSError? = nil
        for param in parameters {
            let paramName = param["name"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
          if let filename = param["filename"] {
              // let contentType = param["content-type"]!
            //  let fileContent = String(contentsOfFile: filename, encoding: String.Encoding.utf8)
                if (error != nil) {
                    print(error)
                }
                body += "; filename=\"\(filename)\"\r\n"
            var mimetype = "image/jpg"
               body += "Content-Type: \(mimetype)\r\n\r\n"
               // body += fileContent
            } else if let paramValue = param["value"] {
                body += "\r\n\r\n\(paramValue)"
            }
        }

        let request = NSMutableURLRequest(url: NSURL(string: "https://servicevalley.net/api/uploadImg")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                print(json)
                
                DispatchQueue.main.async{
                    //    self.myActivityIndicator.stopAnimating()
                    self.userPic.image = nil
                }
                
            }
            catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    func convertToBase64(image: UIImage) -> String {
        return image.pngData()!.base64EncodedString()
    }

    
//    func uploadImageOne(){
//
//        // User "authentication":
//        let imageData = userPic.image!.jpegData(compressionQuality: 0.2)
//
//        let parameters = ["email":"andrew@andrew.com", "photo": imageData] as [String : Any]
//
//            // Image to upload:
//            let imageToUploadURL = Bundle.main.url(forResource: "tree", withExtension: "png")
//
//             // Server address (replace this with the address of your own server):
//             let url = "https://servicevalley.net/api/uploadImg"
//
//            // Use Alamofire to upload the image
//        var headers: HTTPHeaders = [:]
//
//
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//
//                for (key, value) in parameters {
//                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//                }
//                if((imageData) != nil){
//                multipartFormData.append(imageData!, withName: "file", fileName: "fileNameImage.png", mimeType: "image/png")
//                }
//
//        },
//            to: url,
//            headers: headers,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseString{ response in
//                        let JSON = response
//                        debugPrint(JSON)
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//        }
//        )
//
//
//    }
//

    func myImageUploadRequest()
    {

        let myUrl = URL(string: "https://servicevalley.net/api/uploadImg")!;
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");

        let request = NSMutableURLRequest(url:myUrl);
        request.httpMethod = "POST";
        let imageData = userPic.image!.jpegData(compressionQuality:0.2)
        let dataImage = imageData!.base64EncodedString(options: .lineLength64Characters)
        let lang = "ar"
  let param = [
           "email"    : "andrew@andrew.com",
            "photo" : convertToBase64(image: userPic.image!)
          ]

        let boundary = generateBoundaryString()

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if(imageData==nil)  { return; }

        request.httpBody = self.createBodyWithParameters(parameters:param, filePathKey:"file", imageDataKey: imageData! as NSData  , boundary:boundary) as Data


       // myActivityIndicator.startAnimating();

        let session = URLSession.shared
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                print(json)
                
                DispatchQueue.main.async{
                //    self.myActivityIndicator.stopAnimating()
                    self.userPic.image = nil
                }
                
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData()

        for (key, value) in parameters! {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
    }
        body.appendString(string: "--\(boundary)\r\n")
        var mimetype = "image/jpg"
        let defFileName = ""
       let imageData = userPic.image!.jpegData(compressionQuality: 0.2)

        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(defFileName)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func showAlert(Title : String!, Message : String!)  -> UIAlertController {
        
        let alertController : UIAlertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let okAction : UIAlertAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            print("User pressed ok function")
            
        }
        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        return alertController
    }
    
    func handleRefresh() {
        
        API.getProfileData{ (error: Error?, profile_List: [userData]?) in
            if let profile_List = profile_List {
                self.profile_list = profile_List
                self.userName.text = self.profile_list.first!.name
                self.addressLbl.text = self.profile_list.first!.l_name
                self.phoneLbl.text = self.profile_list.first!.phone1
                self.passwordLbl.text = "**********"
                self.emailLbl.text = self.profile_list.first!.email
                let strin = self.profile_list.first!.photo
                self.userPic.imageFromURL(url: "https://servicevalley.net/storage/app/public/user_images/\(strin)", indicatorColor: .gray, errorImage: UIImage(named: "Profile-1")!)

}
}
}
    fileprivate func isFaceBookLogIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isFaceBookLogIn")
    }
    
    @IBAction func goToAddress(_ sender: Any) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "AddressHistory") as! AddressHistory
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        
        revealViewController().pushFrontViewController(newFrontController, animated: true)
    }
    
}
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
}
}
