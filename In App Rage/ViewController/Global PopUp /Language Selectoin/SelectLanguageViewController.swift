//
//  SelectLanguageViewController.swift
//  Minnaz
//
//  Created by Apple on 22/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SwiftMessages

protocol DismissSelectLanguageDelegate: class {
    func ClickLanguageOption(info: NSInteger)
}


class SelectLanguageViewController: UIViewController {
    
    @IBOutlet var lblFrom: UILabel!
    @IBOutlet var lblTo: UILabel!
    
    @IBOutlet var lbl_FromRecentTitle: UILabel!
    @IBOutlet var lbl_ToRecentTitle: UILabel!
    
    @IBOutlet var lbl_ToLangauge1Title: UILabel!
    @IBOutlet var lbl_ToLangauge2Title: UILabel!
    @IBOutlet var lbl_FromLangauge1Title: UILabel!
    @IBOutlet var lbl_FromLangauge2Title: UILabel!
    
    @IBOutlet var btn_From: UIButton!
    @IBOutlet var btn_To: UIButton!
    @IBOutlet var btn_ToLangauge1Title: UIButton!
    @IBOutlet var btn_ToLangauge2Title: UIButton!
    @IBOutlet var btn_FromLangauge1Title: UIButton!
    @IBOutlet var btn_FromLangauge2Title: UIButton!
    
    //Other Comman
    var objSave = SelectLanguageObject()
    
    @IBOutlet var vw_PopUp: UIView!
    
    weak var delegate :DismissSelectLanguageDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vw_PopUp.isHidden = true
        self.Get_Langauge()
//        self.FillData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Other Comman -
    func CommanMethod(){
        
    }
    func FillData(){
//        objSave = SelectLanguageObject()
//        objSave.str_ToSelected = ""
//        objSave.str_FromSelected = ""
//        objSave.str_ToOption1 = ""
//        objSave.str_ToOption2 = ""
//        objSave.str_FromOption1 = ""
//        objSave.str_FromOption2 = ""
        
        //Hide show button
        objSave.str_ToOption1 == "" ? (btn_ToLangauge1Title.isHidden = true) : (btn_ToLangauge1Title.isHidden = false)
        objSave.str_ToOption2 == "" ? (btn_ToLangauge2Title.isHidden = true) : (btn_ToLangauge2Title.isHidden = false)
        objSave.str_FromOption1 == "" ? (btn_FromLangauge1Title.isHidden = true) : (btn_FromLangauge1Title.isHidden = false)
        objSave.str_FromOption2 == "" ? (btn_FromLangauge2Title.isHidden = true) : (btn_FromLangauge2Title.isHidden = false)
        
        if objSave.str_ToOption1 == "" && objSave.str_ToOption2 == ""{
            lbl_ToRecentTitle.isHidden = true
        }else{
            lbl_ToRecentTitle.isHidden = false
        }
        
        if objSave.str_FromOption1 == "" && objSave.str_FromOption2 == ""{
            lbl_FromRecentTitle.isHidden = true
        }else{
            lbl_FromRecentTitle.isHidden = false
        }

        lblTo.text = objSave.str_ToSelected == "" ? "Select Language" : (objSave.str_ToSelected)
        lblFrom.text = objSave.str_FromSelected == "" ? "Select Language" : (objSave.str_FromSelected)
        lbl_ToLangauge1Title.text = objSave.str_ToOption1
        lbl_ToLangauge2Title.text = objSave.str_ToOption2
        lbl_FromLangauge1Title.text = objSave.str_FromOption1
        lbl_FromLangauge2Title.text = objSave.str_FromOption2
    }
//    func removeSelectedObject(arr_Get : NSMutableArray,RomveObject : String) -> NSMutableArray{
//        var arr_Save : NSMutableArray = []
//        for count in 0..<arr_Get.count{
//            if arr_Get[count] as! String != RomveObject {
//                arr_Save.add(arr_Get[count])
//            }
//        }
//
//        return arr_Save
//    }
    
    // MARK: - Button Event -
    @IBAction func btn_InterChange(_ sender: UIButton) {
        
        if objSave.str_ToSelected != ""{
        
            var str_ValueStore : String = objSave.str_ToSelected
            var str_ValueStore2 : String = objSave.str_ToIDSelected
            
            objSave.str_ToSelected = objSave.str_FromSelected
            objSave.str_ToIDSelected = objSave.str_FromIDSelected
            
            objSave.str_FromSelected = str_ValueStore
            objSave.str_FromIDSelected = str_ValueStore2
            
            self.FillData()
        }
    }
    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_DoneLanguageSelection(_ sender: Any) {
//        let defaults = UserDefaults.standard
//        defaults.set("English", forKey: LANGUAGE_KEY)
//        self.dismiss(animated: true, completion: nil)
        
        if((lblFrom.text?.isEmpty)! || lblFrom.text == "Select Language"){
            //Alert show for Header
            messageBar.MessageShow(title: "Please select from language", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            
        }else if((lblTo.text?.isEmpty)! || lblTo.text == "Select Language"){
            //Alert show for Header
            messageBar.MessageShow(title: "Please select to language", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }else{
            self.Post_Language()
//            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btn_From(_ sender: Any) {

        if objSave.arr_LanguageTitle.count != 0 {
            let str_Title = lblFrom.text
            
            let picker = ActionSheetStringPicker(title: "From Language", rows: objSave.arr_LanguageTitle as! [Any], initialSelection:selectedIndex(arr: objSave.arr_LanguageTitle as NSArray, value: (str_Title as? NSString)!), doneBlock: { (picker, indexes, values) in
                
                if values as! String == self.lblTo.text as! String{
                    self.objSave.str_ToSelected = ""
                    self.objSave.str_ToIDSelected = ""
                }
                
                let objTemp = self.objSave.arr_Language[indexes] as! SelectLanguageObject
                self.objSave.str_FromSelected = objTemp.str_Lang_Title
                self.objSave.str_FromIDSelected = objTemp.str_Lang_ID
                
                self.FillData()
                
            }, cancel: {ActionSheetStringPicker in return}, origin: btn_From)
            
            picker?.setDoneButton(UIBarButtonItem(title: "SELECT", style: .plain, target: nil, action: nil))
            picker?.toolbarButtonsColor = UIColor.black
            
            picker?.show()
        }
    }
    
    @IBAction func btn_To(_ sender: Any) {

       if objSave.arr_LanguageTitle.count != 0 {
            let str_Title = lblTo.text
            
            let picker = ActionSheetStringPicker(title: "To Language", rows: objSave.arr_LanguageTitle as! [Any], initialSelection:selectedIndex(arr: objSave.arr_LanguageTitle as NSArray, value: (str_Title as? NSString)!), doneBlock: { (picker, indexes, values) in
                
                if values as! String == self.lblFrom.text as! String{
                    self.objSave.str_FromSelected = ""
                    self.objSave.str_FromIDSelected = ""
                }
                
                let objTemp = self.objSave.arr_Language[indexes] as! SelectLanguageObject
                self.objSave.str_ToSelected = objTemp.str_Lang_Title
                self.objSave.str_ToIDSelected = objTemp.str_Lang_ID
                
                self.FillData()
                
            }, cancel: {ActionSheetStringPicker in return}, origin: btn_To)
            
            picker?.setDoneButton(UIBarButtonItem(title: "SELECT", style: .plain, target: nil, action: nil))
            picker?.toolbarButtonsColor = UIColor.black
            
            picker?.show()
        }
        
    }
    
    @IBAction func btn_ToLangauge1Title(_ sender: Any) {
        
        objSave.str_ToSelected = objSave.str_ToOption1
        objSave.str_ToIDSelected = objSave.str_ToIDOption1
        self.FillData()

        if objSave.str_FromSelected == objSave.str_ToOption1{
            lblFrom.text = "Select Language"
        }
    }
    
    @IBAction func btn_ToLangauge2Title(_ sender: Any) {
        objSave.str_ToSelected = objSave.str_ToOption2
        objSave.str_ToIDSelected = objSave.str_ToIDOption2
        self.FillData()
        
        if objSave.str_FromSelected == objSave.str_ToOption2{
            lblFrom.text = "Select Language"
        }
    }
    
    @IBAction func btn_FromLangauge1Title(_ sender: Any) {
        
        objSave.str_FromSelected = objSave.str_FromOption1
        objSave.str_FromIDSelected = objSave.str_FromIDOption1
        self.FillData()
        
        if objSave.str_ToSelected == objSave.str_FromOption1{
            lblTo.text = "Select Language"
        }
    }
    
    @IBAction func btn_FromLangauge2Title(_ sender: Any) {
        
        objSave.str_FromSelected = objSave.str_FromOption2
        objSave.str_FromIDSelected = objSave.str_FromIDOption2
        self.FillData()
        
        if objSave.str_ToSelected == objSave.str_FromOption2{
            lblTo.text = "Select Language"
        }
    }
    
    
    func Get_Langauge(){
                
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)get_language"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "get_language"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    func Post_Language(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)update_language"

        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "from_language_id" : objSave.str_FromIDSelected,
            "to_language_id" : objSave.str_ToIDSelected,
        ]

        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "update_language"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = true
        webHelper.startDownload()
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

//MARK: - Object Decalration -
class SelectLanguageObject: NSObject {
    
    var str_ToSelected : String = ""
    var str_FromSelected : String = ""
    
    var str_ToIDSelected : String = ""
    var str_FromIDSelected : String = ""
    
    var str_ToOption1 : String = ""
    var str_ToOption2 : String = ""
    var str_FromOption1 : String = ""
    var str_FromOption2 : String = ""
    
    var str_ToIDOption1 : String = ""
    var str_ToIDOption2 : String = ""
    var str_FromIDOption1 : String = ""
    var str_FromIDOption2 : String = ""
    
    var arr_Language : NSMutableArray = []
    var arr_LanguageTitle : NSMutableArray = []
    var str_Lang_ID : String = ""
    var str_Lang_Title : String = ""
    var str_Lang_Abbrivation : String = ""
    var str_Lang_DictionaryId: String = ""
}


extension SelectLanguageViewController : WebServiceHelperDelegate{
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "get_language" {
            
            vw_PopUp.isHidden = false
            
            let dict_result = response["lanugage_detail"] as! NSDictionary
            let arr_Language = dict_result["languages"] as! NSArray
            
            objSave = SelectLanguageObject()
            
            objSave.arr_Language = []
            objSave.arr_LanguageTitle = []
            for count in 0..<arr_Language.count {
                
                let objTemp = SelectLanguageObject()
                
                let dictData = arr_Language[count] as! NSDictionary
                
                objTemp.str_Lang_ID = String(dictData["language_id"] as! Int)
                objTemp.str_Lang_Title = dictData["title"]  as? String ?? ""
                objTemp.str_Lang_Abbrivation = dictData["abbrivation"]  as? String ?? ""
                objTemp.str_Lang_DictionaryId = dictData["dictionary_id"]  as? String ?? ""
                
                objSave.arr_Language.add(objTemp)
                objSave.arr_LanguageTitle.add(dictData["title"]  as? String ?? "")
            }
            
            
            //Manage dictionary
            let arr_From = dict_result["From_languages"] as! NSArray
            let arr_To = dict_result["To_languages"] as! NSArray
            if arr_To.count != 0{
                //From Lanaguage
                let dict_ToDictonary = arr_To[0] as! NSDictionary
                
                objSave.str_ToSelected = dict_ToDictonary["title"] as! String
                objSave.str_ToIDSelected = String(dict_ToDictonary["language_id"] as! Int)
            }
            if arr_From.count != 0{
                //To Lanaguage
                let dict_FromDictonary = arr_From[0] as! NSDictionary
                
                objSave.str_FromSelected = dict_FromDictonary["title"] as! String
                objSave.str_FromIDSelected = String(dict_FromDictonary["language_id"] as! Int)
            }
            
            if arr_To.count > 1{
                //From Lanaguage
                let dict_ToDictonary = arr_To[1] as! NSDictionary
                
                objSave.str_ToOption1 = dict_ToDictonary["title"] as! String
                objSave.str_ToIDOption1 = String(dict_ToDictonary["language_id"] as! Int)
            }
            
            if arr_From.count > 1{
                //To Lanaguage
                let dict_FromDictonary = arr_From[1] as! NSDictionary
                
                objSave.str_FromOption1 = dict_FromDictonary["title"] as! String
                objSave.str_FromIDOption1 = String(dict_FromDictonary["language_id"] as! Int)
            }
            
            if arr_To.count > 2{
                //From Lanaguage
                let dict_ToDictonary = arr_To[2] as! NSDictionary
                
                objSave.str_ToOption2 = dict_ToDictonary["title"] as! String
                objSave.str_ToIDOption2 = String(dict_ToDictonary["language_id"] as! Int)
            }
            
            if arr_From.count > 2{
                //To Lanaguage
                let dict_FromDictonary = arr_From[2] as! NSDictionary
                
                objSave.str_FromOption2 = dict_FromDictonary["title"] as! String
                objSave.str_FromIDOption2 = String(dict_FromDictonary["language_id"] as! Int)
            }
            
            self.FillData()
        }else if strRequest == "update_language" {
            userObjectUpdate(dict_Get : response)
            
            self.dismiss(animated: true) {
                self.delegate?.ClickLanguageOption(info: 1)
            }
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        
        //        self.completedServiceCalling()
        //        self.reloadData()
    }
}





