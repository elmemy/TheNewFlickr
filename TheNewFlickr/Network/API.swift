//
//  API.swift
//  TheNewFlickr
//
//  Created by Ahmed Elmemy on 19/07/2021.
//

import Foundation
import SwiftyJSON
import Alamofire
import SwiftEntryKit
import Localize_Swift


//import StatusAlert
class ATApi {
    
    
    //    static let baseUrl = ""
    
    static func fetchObjectMessage<T : Decodable> (controller : UIViewController?,key : String , parameters : [String:Any]? , headers : [String : String]? , completion : @escaping (T ,String)->()){
        
        //        controller?.startAnimating()
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        
        
        
        Alamofire.request(key, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: newHeader).responseJSON { (response) in
            controller?.stopAnimating()
            if response.result.isSuccess {
                
                
                
                let json = JSON(response.data!)
                print(json)
                
                if json["key"].stringValue == "success" {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: json["data"].rawData())
                        
                        completion(object , json["msg"].stringValue)
                        
                    }catch{
                        
                        print(error)
                        
                    }
                    
                    
                }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                    UserDefaults.standard.removeObject(forKey: "user")
                    UserDefaults.resetStandardUserDefaults()
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    AuthenticationRouter.Login(viewController: controller!)
   
                    
                }else{
                    
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    
                    
                }
                
            }else{
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    fetchObject(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                }
            }
        }
        
    }
    
    
    
    
    static func Delete (controller : UIViewController?,key : String , parameters : [String:Any]? , headers : [String : String]? , completion : @escaping (JSON)->()){
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        
        
        controller?.startAnimating()
        
        Alamofire.request( key, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: newHeader).responseJSON { (response) in
            controller?.stopAnimating()
            if response.result.isSuccess {
                
                
                
                let json = JSON(response.data!)
                print(json)
                
                if json["key"].stringValue == "success" {
                    
                    completion(json)
                    
                    let alertMsg = json["msg"].stringValue
                    
                    FloatingAlert.displaySuccess(description: alertMsg)
                    
                    
                }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                    UserDefaults.standard.removeObject(forKey: "user")
                    UserDefaults.resetStandardUserDefaults()
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    AuthenticationRouter.Login(viewController: controller!)
   
                    
                }else{
                    
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    
                    
                }
                
            }else{
                controller?.stopAnimating()
                //                if key == "beta_v2" {
                //                    POST(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                //                    return
                //                }
                controller?.presentRetryMessage {
                    POST(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                }
            }
        }
        
    }

    
    static func POST (controller : UIViewController?,key : String , parameters : [String:Any]? , headers : [String : String]? , completion : @escaping (JSON)->()){
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        
        
        controller?.startAnimating()
        
        Alamofire.request( key, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: newHeader).responseJSON { (response) in
            controller?.stopAnimating()
            if response.result.isSuccess {
                
                
                
                let json = JSON(response.data!)
                print(json)
                
                if json["key"].stringValue == "success" {
                    
                    completion(json)
                    
                    let alertMsg = json["msg"].stringValue
                    
                    if alertMsg != ""{
                        FloatingAlert.displaySuccess(description: alertMsg)
                    }
                    
                    
                    
                }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                    UserDefaults.standard.removeObject(forKey: "user")
                    UserDefaults.resetStandardUserDefaults()
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    AuthenticationRouter.Login(viewController: controller!)
   
                    
                }else{
                    
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    
                    
                }
                
            }else{
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    POST(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                }
            }
        }
        
    }
    
    
    
    static func Get (controller : UIViewController?,key : String , parameters : [String:Any]? , headers : [String : String]? , completion : @escaping (JSON)->()){
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        
        
        controller?.startAnimating()
        
        Alamofire.request( key, method: .get, encoding: JSONEncoding.default, headers: newHeader).responseJSON { (response) in
            controller?.stopAnimating()
            if response.result.isSuccess {
                
                
                
                let json = JSON(response.data!)
                print(json)
                
                if json["key"].stringValue == "success" {
                    
                    completion(json)
                    
                    
                    
                    
                }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                    UserDefaults.standard.removeObject(forKey: "user")
                    UserDefaults.resetStandardUserDefaults()
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    AuthenticationRouter.Login(viewController: controller!)
   
                    
                }else{
                    
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    
                    
                }
                
            }else{
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    POST(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                }
            }
        }
        
    }
    
    
    
    
    static func delete (controller : UIViewController?,key : String , parameters : [String:Any]? , headers : [String : String]? , completion : @escaping (JSON)->()){
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        
        //        controller?.startAnimating()
        
        Alamofire.request( key, method: .delete, encoding: JSONEncoding.default, headers: newHeader).responseJSON { (response) in
            controller?.stopAnimating()
            if response.result.isSuccess {
                
                
                
                let json = JSON(response.data!)
                print(json)
                
                if json["key"].stringValue == "success" {
                    
                    completion(json)
                    
                    
                    
                    
                }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                    UserDefaults.standard.removeObject(forKey: "user")
                    UserDefaults.resetStandardUserDefaults()
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    AuthenticationRouter.Login(viewController: controller!)
   
                    
                }else{
                    
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    
                    
                }
                
            }else{
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    POST(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                }
            }
        }
        
    }
    
    
    static func uploadMuiltiImages ( controller : UIViewController? ,key : String ,headers : [String : String]?, images : [UIImage] , imageParamNames : [String] , maxSizeInMegaByte : Double , parameters : [String: String] , onSuccess : @escaping (JSON) -> Void ){
            
            
        
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        controller?.startAnimating()
        
            Alamofire.upload(multipartFormData: { multipartFormData in
                // import image to request
                
                var imagesData = [Data]()
                
                
                images.forEach { (image) in
                    imagesData.append(image.withMaxSize(megaByte: maxSizeInMegaByte)!.pngData()!)
                    
                    
                }
                
                for i in 0 ..< imagesData.count {
                    multipartFormData.append(imagesData[i], withName: "\(imageParamNames[i])", fileName: "\(Date().timeIntervalSince1970).png", mimeType: "image/png")
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:  key, headers: newHeader,

                encodingCompletion: { encodingResult in
                    
                    switch encodingResult {
                        
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            controller?.stopAnimating()

                            let json = JSON(response.data!)
                            print(json)
                            if json["key"].stringValue == "success" {
                                
                                onSuccess(json)
                                
                                
                            }else{
                                
                                let alertMsg = json["msg"].stringValue
                                FloatingAlert.displayError(description: alertMsg)
                            }
                            
                        }
                    case .failure:
                        controller?.stopAnimating()

                        uploadMuiltiImages(controller: controller, key: key, headers: newHeader, images: images, imageParamNames: imageParamNames, maxSizeInMegaByte: maxSizeInMegaByte, parameters: parameters, onSuccess: onSuccess)

                    }

            })
            
        }
    
    static func fetchObject<T : Decodable> (controller : UIViewController?,key : String , parameters : [String:Any]? , headers : [String : String]? , completion : @escaping (T ,String)->()){
        
        controller?.startAnimating()
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        
        
        
        Alamofire.request(key, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: newHeader).responseJSON { (response) in
            controller?.stopAnimating()
            if response.result.isSuccess {
                
                
                
                let json = JSON(response.data!)
                print(json)
                
                if json["key"].stringValue == "success" {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: json["data"].rawData())
                        
                        completion(object , json["msg"].stringValue)
                        
                        if (json["msg"].stringValue) != ""{
                            FloatingAlert.displaySuccess(description: json["msg"].stringValue)
                            
                        }
                        
                        
                    }catch{
                        
                        print(error)
                        
                    }
                    
                    
                }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                    UserDefaults.standard.removeObject(forKey: "user")
                    UserDefaults.resetStandardUserDefaults()
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    AuthenticationRouter.Login(viewController: controller!)
   
                    
                }else{
                    
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    
                    
                }
                
            }else{
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    fetchObject(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                }
            }
        }
        
    }
    
    
    
    static func fetchObjectGet<T : Decodable> (controller : UIViewController?,key : String , parameters : [String:Any]? , headers : [String : String]? , completion : @escaping (T ,String)->()){
        
        controller?.startAnimating()
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        

        
        Alamofire.request(key, method: .get, encoding: JSONEncoding.default, headers: newHeader).responseJSON { (response) in
            controller?.stopAnimating()
            if response.result.isSuccess {
                
                
                
                let json = JSON(response.data!)
                print(json)
                
                if json["key"].stringValue == "success" {
                    do {
                        
                        let object = try JSONDecoder().decode(T.self, from: json["data"].rawData())
                        
                        completion(object , json["msg"].stringValue)
                        
                    }catch{
                        
                        print(error)
                        
                    }
                    
                    
                }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                    UserDefaults.standard.removeObject(forKey: "user")
                    UserDefaults.resetStandardUserDefaults()
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                    
                    AuthenticationRouter.Login(viewController: controller!)
   
                    
                }else{
                    let alertMsg = json["msg"].stringValue
                    FloatingAlert.displayError(description: alertMsg)
                }
                
            }else{
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    fetchObject(controller: controller, key: key, parameters: parameters, headers: headers, completion: completion)
                }
            }
        }
        
    }
    
    
    static func uploadImages (controller : UIViewController? , key : String ,headers : [String : String]?, images : [UIImage] , imageParamName : String , maxSizeInMegaByte : Double , parameters : [String: String] , onSuccess : @escaping (JSON) -> Void ){
        
        
        controller?.startAnimating()
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        
        
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
            
            var imagesData = [Data]()
            
            
            images.forEach { (image) in
                imagesData.append(image.withMaxSize(megaByte: maxSizeInMegaByte)!.pngData()!)
            }
            
            for imageData in imagesData {
                multipartFormData.append(imageData, withName: "\(imageParamName)", fileName: "\(Date().timeIntervalSince1970).png", mimeType: "image/png")
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to:  key, headers: newHeader,
        
        encodingCompletion: { encodingResult in
            
            switch encodingResult {
            
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    controller?.stopAnimating()
                    let json = JSON(response.data!)
                    print(json)
                    if json["key"].stringValue == "success" {
                        
                        onSuccess(json)
                        
                        
                    }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                        UserDefaults.standard.removeObject(forKey: "user")
                        UserDefaults.resetStandardUserDefaults()
                        let alertMsg = json["msg"].stringValue
                        FloatingAlert.displayError(description: alertMsg)
                        
                        AuthenticationRouter.Login(viewController: controller!)
       
                        
                    }else{
                        
                        let alertMsg = json["msg"].stringValue
                        FloatingAlert.displayError(description: alertMsg)
                    }
                    
                }
            case .failure:
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    uploadImages(controller: controller, key: key, headers: newHeader, images: images, imageParamName: imageParamName, maxSizeInMegaByte: maxSizeInMegaByte, parameters: parameters, onSuccess: onSuccess)
                }
            }
            
        })
        
    }
    
    
    
    static func uploadAudio (controller : UIViewController? , key : String ,headers : [String : String]?, songName:String, songData_:Data , audioParamName : String , parameters : [String: String] , onSuccess : @escaping (JSON) -> Void ){
        
        
        
        
//        controller?.startAnimating()
        
        var newHeader = headers
        
        if headers == nil {
            newHeader = [:]
        }
        
        if Localize.currentLanguage() == "en" {
            newHeader?["lang"] = "en"
        }else if Localize.currentLanguage() == "ar"{
            newHeader?["lang"] = "ar"
        }else{
            newHeader?["lang"] = "ur"
        }
        if UserModel.getUser()?.token != nil{
            newHeader?["Authorization"] = ("Bearer " + UserModel.getUser()!.token! )
        }
        
        
        
//        controller?.startAnimating()
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
            
            multipartFormData.append(songData_ as Data, withName: "\(audioParamName)", fileName: songName, mimeType: "audio/m4a")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: key, headers: newHeader,
        
        encodingCompletion: { encodingResult in
            
            switch encodingResult {
            
            case .success(let upload, _, _):
                upload.responseJSON { response in
//                    controller?.stopAnimating()
                    let json = JSON(response.data!)
                    print(json)
                    if json["key"].stringValue == "success" {
                        
                        onSuccess(json)
                        
                        
                    }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                        UserDefaults.standard.removeObject(forKey: "user")
                        UserDefaults.resetStandardUserDefaults()
                        let alertMsg = json["msg"].stringValue
                        FloatingAlert.displayError(description: alertMsg)
                        
                        AuthenticationRouter.Login(viewController: controller!)
       
                        
                    }else{
                        
                        
                        
                        
                        
                        let alertMsg = json["msg"].stringValue
                        FloatingAlert.displayError(description: alertMsg)
                        
                        
                    }
                    
                }
            case .failure:
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    uploadAudio(controller: controller, key: key, headers: headers, songName: songName, songData_: songData_, audioParamName: audioParamName, parameters: parameters, onSuccess: onSuccess)
                }
            }
            
        })
        
    }
    
    
    static func uploadPDF (controller : UIViewController? , key : String ,headers : [String : String], pdfURL : URL? , fileParameterName : String  , parameters : [String: String] , onSuccess : @escaping (JSON) -> Void ){
        
        controller?.startAnimating()
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            
            if let _ = pdfURL {
                
                let fileName = pdfURL!.lastPathComponent
                
                do {
                    
                    let pdfData = try Data(contentsOf: pdfURL!)
                    
                    multipartFormData.append(pdfData, withName: fileParameterName, fileName: fileName, mimeType:"application/pdf")
                    
                }
                catch{
                    print(error)
                }
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: key, headers: headers,
        
        encodingCompletion: { encodingResult in
            
            switch encodingResult {
            
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    controller?.stopAnimating()
                    let json = JSON(response.data!)
                    print(json)
                    if json["key"].stringValue == "success" {
                        
                        onSuccess(json)
                        
                        
                    }else if(json["key"].stringValue == "is_banned") ||  (json["key"].stringValue == "not_active") ||  (json["key"].stringValue == "not_accepted"){
                        UserDefaults.standard.removeObject(forKey: "user")
                        UserDefaults.resetStandardUserDefaults()
                        let alertMsg = json["msg"].stringValue
                        FloatingAlert.displayError(description: alertMsg)
                        
                        AuthenticationRouter.Login(viewController: controller!)
       
                        
                    }else{
                        
                        
                        let alertMsg = json["msg"].stringValue
                        FloatingAlert.displayError(description: alertMsg)
                        
                    }
                    
                }
            case .failure:
                controller?.stopAnimating()
                controller?.presentRetryMessage {
                    uploadPDF(controller: controller, key: key, headers: headers, pdfURL: pdfURL, fileParameterName: fileParameterName, parameters: parameters, onSuccess: onSuccess)
                }
            }
            
        })
        
    }
    
    
    
    
    
}

extension UIImage {
    
    func withMaxSize(megaByte : Double ) -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        //let megaByte = 1000.0
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / (megaByte * 1000.0)
        
        while imageSizeKB > (megaByte * 1000.0) {
            guard let resizedImage = resizingImage.resized(withPercentage: 0.5),
                  let imageData = resizedImage.pngData() else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / (megaByte * 1000.0)
        }
        
        return resizingImage
    }
    
    fileprivate func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    func imageWithInsets(insetDimen: CGFloat) -> UIImage {
        return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
    }
    
    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
        UIGraphicsEndImageContext()
        return imageWithInsets!
    }
    
    
}
func showErrorMsg (msg : String) {
    
    
    FloatingAlert.displayError(description: msg)
}


func showSuccesMsg (msg : String) {
    FloatingAlert.displaySuccess(description: msg)
}

class FloatingAlert  {
    
    static func displayError (description : String) {
        
        let image = EKProperty.ImageContent(image: #imageLiteral(resourceName: "logo_one"), size: CGSize(width: 32, height: 32))
        
        
        
        displayNotficationAlert(_title: "", _description: description , image: image, shadowColor: .SecondaryColor)
    }
    
    
    static func displaySuccess (description : String) {
        
        let image = EKProperty.ImageContent(image: #imageLiteral(resourceName: "logo_one"), size: CGSize(width: 32, height: 32))

        
        
        displayNotficationAlert(_title: "", _description: description , image: image, shadowColor: .green)
        
    }
    
    static func displayNotification (description : String) {
        let image = EKProperty.ImageContent(image: #imageLiteral(resourceName: "logo"), size: CGSize(width: 32, height: 32))
        displayNotficationAlert(_title: "Notification".localized(), _description: description , image: image, shadowColor: .green , color: .color(color: .init(.green)) )
    }
    
    private static func displayNotficationAlert (_title : String , _description : String, image : EKProperty.ImageContent , shadowColor : UIColor , color : EKAttributes.BackgroundStyle = .color(color: .init(UIColor.SecondaryColor))) {
        
        
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = color
        
        
        attributes.positionConstraints.verticalOffset += 12
        
        attributes.entranceAnimation = .init(
            translate: .init(duration: 0.7, anchorPosition: .top, spring: .init(damping: 0.5, initialVelocity: 2)),
            scale: .init(from: 1, to: 1, duration: 0.7),
            fade: .init(from: 0.8, to: 1, duration: 0.3))
        
        attributes.shadow = .active(with: .init(color: .init(.lightGray), opacity: 1, radius: 5, offset: .zero))
        
        attributes.statusBar = .dark
        
        
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        let minEdge = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: minEdge), height: .intrinsic)
        
        var title = EKProperty.LabelContent(text: _title ,style: .init(font: AppFonts.medium(size: 16), color: .init(.BackGroundColor)))
        
        
        
        var description = EKProperty.LabelContent(text: _description ,style: .init(font: AppFonts.medium(size: 16), color: .init(.BackGroundColor)))
        
        
        
        if Localize.currentLanguage() == "en" {
            title.style.alignment = .left
            description.style.alignment = .left
        }else{
            title.style.alignment = .right
            description.style.alignment = .right
        }
        
        
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
        
    }
    
    
}

extension UIViewController {
    func startAnimating  () {
        view.activityStartAnimating(activityColor: UIColor.SecondaryColor, backgroundColor: UIColor.black.withAlphaComponent(0.5))
    }
    
    func stopAnimating() {
        view.activityStopAnimating()
    }
    
    
    func presentRetryMessage (completionHandler : @escaping () -> Void) {
        
        let alert = UIAlertController(title: "Network error!", message: "There is an error in network please try again", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Try again", style: .default){
            (action) in
            completionHandler()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
        
    }
}
