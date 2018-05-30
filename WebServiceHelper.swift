//
//  WebServiceHelper.swift
//  HealthyBlackMen
//
//  Created by ketan_icoderz on 11/05/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import SwiftMessages

var webservice_Nool_Load : Bool = false

// MARK: - Protocol -
@objc protocol WebServiceHelperDelegate{
    func appDataDidSuccess(_ data: Any, request strRequest: String)
    func appDataDidFail(_ error: Error, request strRequest: String)
}

class WebServiceHelper: NSObject {

    var strMethodName = ""
    weak var delegate: WebServiceHelper?
    var strURL = ""
    var jsonString = ""
    var methodType : String = ""
    var dictType : NSDictionary = [:]
    var dictHeader : NSDictionary = [:]
    var indicatorShowOrHide : Bool = true
    var serviceWithAlert : Bool = false
    var serviceWithAlertErrorMessage : Bool = false
    var imageUpload : UIImage!
    var imageUploadName : String = ""
    
    var arr_MutlipleimagesAndVideo : NSMutableArray = []
    var arr_MutlipleimagesAndVideoType : NSMutableArray = []
    var arr_MutlipleimagesAndVideoName : NSMutableArray = []
    
    var delegateWeb:WebServiceHelperDelegate?
    
    // MARK: - StartDowload Method -
    func startDownload(){
        
        if NetworkReachabilityManager()!.isReachable {
        
            do {
                
                webservice_Nool_Load = true
                
                //Indication show hide with varible when user calling service
                (self.indicatorShowOrHide == true) ? (indicatorShow()) : (indicatorHide())
                
                var jsonData = try JSONSerialization.data(withJSONObject: self.dictType, options: .prettyPrinted)
                if jsonString != ""{
                    jsonData = jsonString.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                }
                var str_Value = String(data: jsonData, encoding: .utf8)
                
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                if let dictFromJSON = decoded as? [String:String] {
                    //print(dictFromJSON)
                }
                
                //Base user for calling service
                let urlInNSString : NSString = self.strURL as NSString
                let StringConvertInUTFform = urlInNSString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
                let strUrl = URL(string: StringConvertInUTFform as String)!
                var request = URLRequest(url: strUrl)
                
                //Declaration for service for get,post or other..
                (methodType == "post") ? (request.httpMethod = HTTPMethod.post.rawValue) : (request.httpMethod = HTTPMethod.get.rawValue)
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

                //Pass header when header data will come
                var jsonHeader : NSDictionary =  dictHeader
                
//                //If true only user already login in app
//                if ((loadCustomObject(withKey: "userobject")) != nil){
//                    //If accesstocken get than only
//                    if objUser?.str_AccessToken.characters.count != 0 {
//                        jsonHeader = [
//                            "Authorization" : "Bearer \(objUser?.str_AccessToken as! String)",
//                        ]
//                    }
//                }
                //Declaratin for Serialization
                print("URL :\n\(strURL)\n============\n\n\(dictType)\nKey : \(jsonHeader)")
                
                if(jsonHeader.count != 0){
                    var arrKey = jsonHeader.allKeys
                    for i in (0...arrKey.count-1){
                        let key : NSString = arrKey[i] as! String as NSString
                        let value : NSString = jsonHeader[key] as! NSString
                        request.setValue(value as String, forHTTPHeaderField: key as String)
                    }
                }
                
                //Pass paramater with value data
                if methodType == "post"{
                    
                    request.httpBody = jsonData
                }
                
                //Calling service
                let manager = Alamofire.SessionManager.default
                manager.session.configuration.timeoutIntervalForRequest = 10
                
                manager.request(request).responseJSON {
                    (response) in
                                    
                    //Redirect caling view if success
                    if !(response.result.error != nil){
                        //Check condition for response success or not and notificatino show with coming alert in service response
                        if self.validationForServiceResponse(response.result.value ?? ""){
                            webservice_Nool_Load = false
                            self.delegateWeb?.appDataDidSuccess(response.result.value ?? "", request: self.strMethodName)
                        }else{
                            let err = NSError(domain: "data not found", code: 401, userInfo: nil)
                            
                            webservice_Nool_Load = false
                            self.delegateWeb?.appDataDidFail(err, request: self.strMethodName)
                        }
                    }else{
                        
//                        //Alert show for Header
//                        messageBar.MessageShow(title: "Sorry, internet connection not available, please try again.", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                        
                        webservice_Nool_Load = false
                        let err = NSError(domain: "data not found", code: 401, userInfo: nil)
                       self.delegateWeb?.appDataDidFail(err, request: self.strMethodName)
                        indicatorHide()
                    }
                }
            } catch {
                
                //Alert show for Header
                messageBar.MessageShow(title: GlobalConstants.appName as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            
                webservice_Nool_Load = false
                self.validationForServiceResponse(error.localizedDescription)
                print(error.localizedDescription)
            }
        }else{
            webservice_Nool_Load = false

             let err = NSError(domain: "data not found", code: 401, userInfo: nil)
             self.delegateWeb?.appDataDidFail(err, request: self.strMethodName)
            
            
            //Alert show for Header
            messageBar.MessageShow(title: "Sorry, internet connection not available, please try again.", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }
    }
    
    func startDownloadWithImage(){
        do {
            
            webservice_Nool_Load = true
            
            //Indication show hide with varible when user calling service
            (self.indicatorShowOrHide == true) ? (indicatorShow()) : (indicatorHide())
            
            //Declaratin for Serialization
           // print(self.dictType)
            let jsonData = try JSONSerialization.data(withJSONObject: self.dictType, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let dictFromJSON = decoded as? [String:String] {
               // print(dictFromJSON)
            }
            
            //Base user for calling service
            let strUrl = URL(string: self.strURL)!
            var request = URLRequest(url: strUrl)
            
            //Declaration for service for get,post or other..
            request.httpMethod = HTTPMethod.post.rawValue
            
            //Pass paramater with value data
            request.httpBody = jsonData
            
            var imgData: Data?
            if (imageUpload.size.width != 0)
            {
                imgData = UIImageJPEGRepresentation(imageUpload!, 0.2)!
            }
            
            //Calling service
            Alamofire.upload(multipartFormData:{ multipartFormData in
                if (imgData != nil){
                    multipartFormData.append(imgData!, withName: self.imageUploadName,fileName: "\(self.imageUploadName).jpg", mimeType: "image/jpg")
                }
                for (key, value) in self.dictType  {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key as! String)
                }
            },
             usingThreshold:UInt64.init(),
             to:strUrl,
             method:.post,
             headers:dictHeader as? HTTPHeaders,
             encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON(completionHandler: { response in
                        //Redirect caling view if success
                        if !(response.result.error != nil){
                            //Check condition for response success or not and notificatino show with coming alert in service response
                            
                            webservice_Nool_Load = false
                            if self.validationForServiceResponse(response.result.value ?? ""){
                                self.delegateWeb?.appDataDidSuccess(response.result.value ?? "", request: self.strMethodName)
                            }
                        }else{
                            webservice_Nool_Load = false
                            indicatorHide()
                        }
                    })
                case .failure(let encodingError):
                    indicatorHide()
                    print("en eroor :", encodingError)
                    webservice_Nool_Load = false
                }
            })
        } catch {
            
            webservice_Nool_Load = false
            //Alert show for Header
            messageBar.MessageShow(title: GlobalConstants.appName as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            
            self.validationForServiceResponse(error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    
    func startUploadingMultipleImagesAndVideo(){
        do {
            webservice_Nool_Load = true
            
            //Indication show hide with varible when user calling service
            (self.indicatorShowOrHide == true) ? (indicatorShow()) : (indicatorHide())
            
            //Declaratin for Serialization
//            print(self.dictType)
            print(self.arr_MutlipleimagesAndVideo.count)
            let jsonData = try JSONSerialization.data(withJSONObject: self.dictType, options: .prettyPrinted)
            
            //Base user for calling service
            let strUrl = URL(string: self.strURL)!
            var request = URLRequest(url: strUrl)
            
            //Declaration for service for get,post or other..
            request.httpMethod = HTTPMethod.post.rawValue
            
            //Pass paramater with value data
            request.httpBody = jsonData
            
            //Calling service
            Alamofire.upload(multipartFormData:{ multipartFormData in
                
                for i in (0..<self.arr_MutlipleimagesAndVideo.count){
                    
                    if self.arr_MutlipleimagesAndVideoName[i] as! String != ""{
                        let imageData = self.arr_MutlipleimagesAndVideo[i]
                        let imgData : Data? = imageData as! Data
                        print(imgData)
                        
                        if (imgData != nil){
                            if self.arr_MutlipleimagesAndVideoType[i] as? String == "photo"{
                                multipartFormData.append(imgData!, withName: "\(self.arr_MutlipleimagesAndVideoName[i])",fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                            }else{
                                multipartFormData.append(imgData!, withName: "\(self.arr_MutlipleimagesAndVideoName[i])",fileName: "\(Date().timeIntervalSince1970).mov", mimeType: "application/octet-stream")
                            }
                        }
                    }
                }
                
                for (key, value) in self.dictType  {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key as! String)
                }
            },
             usingThreshold:UInt64.init(),
             to:strUrl,
             method:.post,
             headers:dictHeader as? HTTPHeaders,
             encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON(completionHandler: { response in
                        //Redirect caling view if success
                        if !(response.result.error != nil){
                            //Check condition for response success or not and notificatino show with coming alert in service response
                            
                            webservice_Nool_Load = false
                            
                            if self.validationForServiceResponse(response.result.value ?? ""){
                                self.delegateWeb?.appDataDidSuccess(response.result.value ?? "", request: self.strMethodName)
                            }
                        }else{
                            webservice_Nool_Load = false
                            
                            indicatorHide()
                        }
                    })
                case .failure(let encodingError):
                    indicatorHide()
                    print("en eroor :", encodingError)
                    webservice_Nool_Load = false
                }
            })
        } catch {
            
            //Alert show for Header
            messageBar.MessageShow(title: GlobalConstants.appName as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            
            self.validationForServiceResponse(error.localizedDescription)
            print(error.localizedDescription)
            
            webservice_Nool_Load = false
        }
    }
    
    
    
    // MARK: - Other Method -
    func validationForServiceResponse(_ data: Any) -> Bool{
        indicatorHide()
        
        let response = data as! NSDictionary
        
        if response["code"] != nil{
            let responseKey = response["code"]! as! Int
            
            //101 invalide user or already registartion with current credincial
            switch responseKey {
            case 100,101,102,401:
                if self.serviceWithAlert || self.serviceWithAlertErrorMessage {
                    //Alert show for Header
                    messageBar.MessageShow(title: response["message"]! as! String as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                }
                return false
                break
                
            default:
                if self.serviceWithAlert {
                    //Alert show for Header
                    
                  messageBar.MessageShow(title: response["message"]! as! String as NSString, alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
                    
//                    
                }
                break
            }
        }
        return true
    }
}

