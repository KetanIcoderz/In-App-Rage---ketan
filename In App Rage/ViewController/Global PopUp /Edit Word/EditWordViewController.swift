//
//  EditWordViewController.swift
//  Minnaz
//
//  Created by Apple on 02/04/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages

protocol DismissEditWordDelegate: class {
    func ClickDismissEditWordOption(obj: OCRSelectionObject,Flag : String)
}


class EditWordViewController: UIViewController {

    //Declaration TextFiled
    @IBOutlet weak var tf_CategoryName: UITextField!
    
    //Declaration Button
    @IBOutlet weak var btn_Accept: UIButton!
    
    weak var delegate : DismissEditWordDelegate? = nil
    
    var str_Flag : String = ""
    
    var objGet = OCRSelectionObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tf_CategoryName.text = objGet.str_Title
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : - Other Methods -
    func manageServiceCalling(){
        if objUser!.traslation_DictionaryName == "1"{
            self.Post_TraslationGoogle(strText: tf_CategoryName.text!)
        }else if objUser!.traslation_DictionaryName == "2"{
            self.Post_TraslationLexin(strText: tf_CategoryName.text!)
        }else if objUser!.traslation_DictionaryName == "3"{
            self.Post_TraslationGlosbe(strText: tf_CategoryName.text!)
        }
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.dismiss(animated: true) {
            self.delegate?.ClickDismissEditWordOption(obj: self.objGet, Flag : "")
        }
    }
    @IBAction func btn_Accept(_ sender:Any){
        if tf_CategoryName.text != ""{
            self.manageServiceCalling()
        }else{
            //Alert show for Header
            messageBar.MessageShow(title: "Please enter text", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }
    }
    
    
    // MARK: - Get/Post Method -
    func Post_TraslationGoogle(strText : String){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)translate_google"
        
        let arr_Comment : NSMutableArray = []
        
        //Save data in dictionary
        let dict_Store : NSDictionary = [
            "word" : removeSpecialCharsFromString(text: strText),
            ]
        arr_Comment.add(dict_Store)
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "from_language" : objUser?.traslation_FromName ?? "0",
        ]
        
        
        jsonData.setValue(objUser?.traslation_ToName ?? "0", forKey: "to_language")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "ocrgoogleconvert"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    func Post_TraslationGlosbe(strText : String){
        
        //Declaration URL
        var strURL = "\(GlobalConstants.BaseURL)translate_glosbe_new"
        
        let arr_Comment : NSMutableArray = []
        //Save data in dictionary
        let dict_Store : NSDictionary = [
            "word" : removeSpecialCharsFromString(text: strText.lowercased()),
            ]
        arr_Comment.add(dict_Store)
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "from_language" : objUser?.traslation_FromNameGlobse ?? "0",
        ]
        
        jsonData.setValue(objUser?.traslation_ToNameGlobse ?? "0", forKey: "to_language")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "ocrglosbeconvert"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    func Post_TraslationLexin(strText : String){
        
        if strText != ""{
            
            //Declaration URL
            var strURL = "\(GlobalConstants.BaseURL)translate_lexin"
            if validationforLexinEnglishDictionaryShow() == true{
                strURL = "\(GlobalConstants.BaseURL)translate_lexin_english"
            }
            
            //Create array for meaning
            var arr_Meaning : NSMutableArray = []
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: strText.lowercased()),
                ]
            arr_Meaning.add(dict_Store)
            
            //Convert array in string
            let string = notPrettyString(from : arr_Meaning)
            
            
            //Pass data in dictionary
            var jsonData : NSDictionary =  NSDictionary()
            jsonData = [
                "user_id" : objUser?.user_UserID,
                //                "to_language" : "\(objUser?.traslation_FromName as! String)_\(objUser?.traslation_ToName as! String)",
                "to_language" : objUser?.traslation_ToNameLexin as! String,
                "keyword" : string,
            ]
            
            //Create object for webservicehelper and start to call method
            let webHelper = WebServiceHelper()
            webHelper.strMethodName = "translate_lexin"
            webHelper.methodType = "post"
            webHelper.strURL = strURL
            webHelper.dictType = jsonData
            webHelper.dictHeader = NSDictionary()
            webHelper.delegateWeb = self
            webHelper.serviceWithAlert = false
            webHelper.startDownload()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension EditWordViewController : WebServiceHelperDelegate{
    
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "ocrgoogleconvert"{
            let arr_Translation = response["translation"] as! NSArray
            
//             let objTemp = OCRSelectionObject()
            
            let dict_Translation = arr_Translation[0] as! NSDictionary
            
            let arr_Image = dict_Translation["image_array"] as! NSArray
            //Image set
            if arr_Image.count != 0{
                objGet.str_Image = arr_Image[0] as! String
            }
            
            objGet.arr_ConvertString = []
            
            objGet.str_Title = dict_Translation["word"] as! String
            
            objGet.str_convert = dict_Translation["translation"] as! String
            
            objGet.arr_ConvertString.add(dict_Translation["translation"] as! String)
            
            
            var bool_ReloadImage : Bool = false
            if dict_Translation["translation"] as! String == ""{
                messageBar.MessageShow(title: "The word \"\(dict_Translation["word"] as! String)\" is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }else{
//                objGet = objTemp
                
                objGet.str_Title = tf_CategoryName.text!
                self.dismiss(animated: true) {
                    self.delegate?.ClickDismissEditWordOption(obj: self.objGet, Flag : self.str_Flag)
                }
            }
            
        }else if strRequest == "ocrglosbeconvert"{
            
            let arr_responseData = response["result"] as! NSArray
            
            let dict_response = arr_responseData[0] as! NSDictionary
            
            let arr_Translation = dict_response["translate_array"] as! NSArray
            let arr_Meaning = dict_response["meaning_array"] as! NSArray
            let arr_Example = dict_response["exmaple_array"] as! NSArray
            let arr_Image = dict_response["image_array"] as! NSArray
            
//            let objTemp = OCRSelectionObject()
            
            //Image set
            if arr_Image.count != 0{
                objGet.str_Image = arr_Image[0] as! String
            }
            
            objGet.arr_Traslation = []
            objGet.arr_Meaning = []
            objGet.arr_Example = []
            objGet.arr_Inflection = []
            objGet.arr_Image = []
            objGet.arr_Synonym = []
            objGet.arr_AnotherWord = []
            objGet.arr_ConvertString = []
            
            for count in 0..<arr_Translation.count {
                //Traslation
                let arr_Translation2 = arr_Translation[count] as! NSArray
                
                if arr_Translation2.count != 0{
                    
                    var arr_Temp : NSMutableArray = []
                    for count2 in 0..<arr_Translation2.count {
                        arr_Temp.add(arr_Translation2[count2] as! String)
                    }
                    objGet.arr_Traslation.add(arr_Temp)
                    
                    objGet.arr_ConvertString.add(arr_Translation2[0] as! String)
                }else{
                    objGet.arr_Traslation.add([])
                    objGet.arr_ConvertString.add("")
                }
                
                for count in 0..<arr_Meaning.count {
                    //Traslation
                    let arr_Meaning2 = arr_Meaning[count] as! NSArray
                    
                    if arr_Meaning2.count != 0{
                        
                        var arr_Temp : NSMutableArray = []
                        for count2 in 0..<arr_Meaning2.count {
                            arr_Temp.add(arr_Meaning2[count2] as! String)
                        }
                        objGet.arr_Meaning.add(arr_Temp)
                    }else{
                        objGet.arr_Meaning.add([])
                    }
                }
                
                objGet.arr_Example.add([])
                objGet.arr_Inflection.add([])
                objGet.arr_Image.add([])
                objGet.arr_Synonym.add([])
                objGet.arr_AnotherWord.add([])
            }
            
//
//            objGet.arr_ConvertString = []
//            var bool_ReloadImage : Bool = false
//            for count in 0..<arr_Translation.count {
//                objGet.arr_ConvertString.add(arr_Translation[count] as! String)
//            }
            
            if objGet.arr_ConvertString.count == 0{
                messageBar.MessageShow(title: "The word \"\(dict_response["word"] as! String)\" is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }else{
//                objGet = objTemp
                objGet.str_Title = tf_CategoryName.text!
                self.dismiss(animated: true) {
                    self.delegate?.ClickDismissEditWordOption(obj: self.objGet, Flag : self.str_Flag)
                }
            }
        }
//        else if strRequest == "translate_lexin"{
//            let arr_responseData = response["result"] as! NSArray
//
//            if arr_responseData.count != 0{
//                let dict_responseData = arr_responseData[0] as! NSDictionary
//
//
//                let arr_Translation = dict_responseData["translate_array"] as! NSArray
//                let arr_Meaning = dict_responseData["meaning_array"] as! NSArray
//                let arr_Example = dict_responseData["exmaple_array"] as! NSArray
//                let arr_Image = dict_responseData["image_array"] as! NSArray
//
////                let objTemp = OCRSelectionObject()
//
//                objGet.arr_ConvertString = []
//
//                for count in 0..<arr_Translation.count {
//                    objGet.arr_ConvertString.add(arr_Translation[count] as! String)
//                }
//
//                //Image set
//                if arr_Image.count != 0{
//                    objGet.str_Image = arr_Image[0] as! NSString
//                }
//
//                var bool_ReloadImage : Bool = false
//                if objGet.arr_ConvertString.count == 0{
//                    messageBar.MessageShow(title: "The word \"\(dict_responseData["word"] as! NSString)\" is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
//                }else{
////                    objGet = objTemp
//
//                    objGet.str_Title = tf_CategoryName.text!
//                    self.dismiss(animated: true) {
//                        self.delegate?.ClickDismissEditWordOption(obj: self.objGet, Flag : self.str_Flag)
//                    }
//                }
//            }
//        }
        else if strRequest == "translate_lexin"{
            let arr_responseData = response["result"] as! NSArray
            
            if arr_responseData.count != 0{
                let dict_responseData = arr_responseData[0] as! NSDictionary
                
                let arr_Inflection = dict_responseData["inflection_array"] as! NSArray
                let arr_Image = dict_responseData["image_array"] as! NSArray
                let arr_Synonym = dict_responseData["synonym_array"] as! NSArray
                let arr_Another = dict_responseData["another_word_item"] as! NSArray
                
                let arr_Translation = dict_responseData["translate_array"] as! NSArray
                let arr_Meaning = dict_responseData["meaning_array"] as! NSArray
                let arr_Example = dict_responseData["exmaple_array"] as! NSArray
                
                
                var bool_Match : Bool = false
                if arr_Translation.count != 0 {
                    
//                    let obj : OCRSelectionObject = arr_Main[btn_Click!.tag] as! OCRSelectionObject
                    
                    objGet.arr_Traslation = []
                    objGet.arr_Meaning = []
                    objGet.arr_Example = []
                    objGet.arr_Inflection = []
                    objGet.arr_Image = []
                    objGet.arr_Synonym = []
                    objGet.arr_AnotherWord = []
                    objGet.arr_ConvertString = []
                    
                    for count in 0..<arr_Translation.count {
                        //Traslation
                        let arr_Translation2 = arr_Translation[count] as! NSArray
                        
                        if arr_Translation2.count != 0{
                            bool_Match = true
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Translation2.count {
                                arr_Temp.add(arr_Translation2[count2] as! String)
                            }
                            objGet.arr_Traslation.add(arr_Temp)
                            
                            objGet.arr_ConvertString.add(arr_Translation2[0] as! String)
                        }else{
                            objGet.arr_Traslation.add([])
                            objGet.arr_ConvertString.add("")
                        }
                    }
                    
                    for count in 0..<arr_Meaning.count {
                        //Traslation
                        let arr_Meaning2 = arr_Meaning[count] as! NSArray
                        
                        if arr_Meaning2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Meaning2.count {
                                arr_Temp.add(arr_Meaning2[count2] as! String)
                            }
                            objGet.arr_Meaning.add(arr_Temp)
                        }else{
                            objGet.arr_Meaning.add([])
                        }
                    }
                    
                    
                    for count in 0..<arr_Example.count {
                        //Traslation
                        let arr_Example2 = arr_Example[count] as! NSArray
                        
                        if arr_Example2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Example2.count {
                                arr_Temp.add(arr_Example2[count2] as! String)
                            }
                            objGet.arr_Example.add(arr_Temp)
                        }else{
                            objGet.arr_Example.add([])
                        }
                    }
                    
                    
                    for count in 0..<arr_Inflection.count {
                        //Traslation
                        let arr_Inflection2 = arr_Inflection[count] as! NSArray
                        
                        if arr_Inflection2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Inflection2.count {
                                arr_Temp.add(arr_Inflection2[count2] as! String)
                            }
                            objGet.arr_Inflection.add(arr_Temp)
                        }else{
                            objGet.arr_Inflection.add([])
                        }
                    }
                    
                    //Image
                    if arr_Image.count != 0{
                        objGet.str_Image = arr_Image[0] as! String
                        
                        for i in 0..<arr_Image.count {
                            objGet.arr_Image.add(arr_Image[i] as! String)
                        }
                    }
                    
                    for count in 0..<arr_Synonym.count {
                        //Traslation
                        let arr_Synonym2 = arr_Synonym[count] as! NSArray
                        
                        if arr_Synonym2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Synonym2.count {
                                arr_Temp.add(arr_Synonym2[count2] as! String)
                            }
                            objGet.arr_Synonym.add(arr_Temp)
                        }else{
                            objGet.arr_Synonym.add([])
                        }
                    }
                    
                    
                    for count in 0..<arr_Another.count {
                        //Traslation
                        let arr_Another2 = arr_Another[count] as! NSArray
                        
                        if arr_Another2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Another2.count {
                                arr_Temp.add(arr_Another2[count2] as! String)
                            }
                            objGet.arr_AnotherWord.add(arr_Temp)
                        }else{
                            objGet.arr_AnotherWord.add([])
                        }
                    }
                    
                }
                
                if bool_Match == false{
                    messageBar.MessageShow(title: "The word \"\(dict_responseData["word"] as! NSString)\" is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                }else{
                    //                    objGet = objTemp
                    
                    objGet.str_Title = tf_CategoryName.text!
                    self.dismiss(animated: true) {
                        self.delegate?.ClickDismissEditWordOption(obj: self.objGet, Flag : self.str_Flag)
                    }
                }
            }
            
        }
        
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        if strRequest == "ocrgoogleconvert" || strRequest == "ocrglosbeconvert"{
            messageBar.MessageShow(title: "The word is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }
        print(error)
    }
}
