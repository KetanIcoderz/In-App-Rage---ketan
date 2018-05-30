//
//  SelectCategoryPopUpViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 30/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages
import IQKeyboardManagerSwift
import SearchTextField

protocol DismissViewDelegate: class {
    func ClickOption(info: NSInteger)
}


class SelectCategoryPopUpViewController: UIViewController {
    
    //Declaration TextFiled
    @IBOutlet weak var tf_SubCategory: SearchTextField!
    @IBOutlet weak var tf_Category: SearchTextField!
    
    //Declaration Button
    @IBOutlet weak var btn_SubCategoryImage: UIButton!
    
    @IBOutlet weak var con_PopUpHeight: NSLayoutConstraint!
    
    @IBOutlet var lbl_Category1Title: UILabel!
    @IBOutlet var lbl_Category2Title: UILabel!
    @IBOutlet var lbl_SubCategory1Title: UILabel!
    @IBOutlet var lbl_SubCategory2Title: UILabel!

    @IBOutlet var lbl_PastCategoryTitle: UILabel!
    @IBOutlet var lbl_PastSubCategoryTitle: UILabel!
    
    @IBOutlet var btn_Category1Title: UIButton!
    @IBOutlet var btn_Category2Title: UIButton!
    @IBOutlet var btn_SubCategory1Title: UIButton!
    @IBOutlet var btn_SubCategory2Title: UIButton!
    
    @IBOutlet var btn_AddCategory: UIButton!
    
    @IBOutlet weak var tbl_Main: UITableView!
    
    var bool_Home : Bool = false
    var bool_CategorySubcategoryShow : Bool = true
    var str_AlertTitle : String = ""
    var str_CategorySelectedID : String = ""
    
    weak var delegate :DismissViewDelegate? = nil
    
    //Layout Constant
    @IBOutlet weak var con_BottomTableView: NSLayoutConstraint!
    
    var arr_Main : NSMutableArray = []
    var arr_MainRecent : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        self.Get_Category()
        
        //Notificaitno event with keyboard show and hide
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(myKeyboardWillHideHandler),
            name: .UIKeyboardWillHide,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(myKeyboardWillShow),
            name: .UIKeyboardWillShow,
            object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController? .setNavigationBarHidden(true, animated: true)
        
        IQKeyboardManager.sharedManager().enable = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Custome class keyboard handler method
    @objc func myKeyboardWillHideHandler(_ notification: NSNotification) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowAnimatedContent], animations: {
            self.con_BottomTableView.constant = 0
            
            self.view .layoutIfNeeded()
        }, completion: nil)
    }
    @objc func myKeyboardWillShow(_ notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        self.view .layoutIfNeeded()
        
        //Scrollview animation when keyboard open
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowAnimatedContent], animations: {
            //Set constant with screen size
            self.con_BottomTableView.constant = keyboardHeight
            
            self.view .layoutIfNeeded()
        }, completion: nil)
        
    }
    
    //MARK: - Other Method -
    func commanMethod(){
//        // Start visible even without user's interaction as soon as created - Default: false
//        tf_Category.startVisibleWithoutInteraction = true
//        tf_SubCategory.startVisibleWithoutInteraction = true
//        
//    tf_Category.filterStrings(["hello","bye","bye","dsfbye","berye","b34ye","byfde","bdfye","bysdfe","bye","bye","sdfsbye","dfgbye","hjfbye","betye","4353bye","by435e","brtyye","byhrte","bye","bydsfe","bye","bye","bye"])
//        tf_SubCategory.filterStrings(["hello","bye","bye","dsfbye","berye","b34ye","byfde","bdfye","bysdfe","bye","bye","sdfsbye","dfgbye","hjfbye","betye","4353bye","by435e","brtyye","byhrte","bye","bydsfe","bye","bye","bye"])
    }
    func FillData(){
        
        lbl_Category1Title.text = ""
        lbl_Category2Title.text = ""
        lbl_SubCategory1Title.text = ""
        lbl_SubCategory2Title.text = ""
        
        str_CategorySelectedID = "0"
        
        //Hide show button
        arr_MainRecent.count > 0 ? (btn_Category1Title.isHidden = false) : (btn_Category1Title.isHidden = true)
        arr_MainRecent.count > 1  ? (btn_Category2Title.isHidden = false) : (btn_Category2Title.isHidden = true)
        btn_SubCategory1Title.isHidden = true
        btn_SubCategory2Title.isHidden = true
        lbl_PastCategoryTitle.isHidden = true
        
        if arr_MainRecent.count > 0{
            lbl_PastCategoryTitle.isHidden = false
            
            let objTemp = arr_MainRecent[0] as! SelectCategoryPopUpObject
            
            lbl_Category1Title.text = objTemp.str_CategoryName
        }
        if arr_MainRecent.count > 1{
            let objTemp = arr_MainRecent[1] as! SelectCategoryPopUpObject
            
            lbl_Category2Title.text = objTemp.str_CategoryName
        }
        
//        //Fill array
//        tf_Category.startVisibleWithoutInteraction = true
//        tf_SubCategory.startVisibleWithoutInteraction = true

        var arr_Temp : NSMutableArray = []
        for count in 0..<arr_Main.count {
            
            let objTemp = arr_Main[count] as! SelectCategoryPopUpObject
            
            arr_Temp.add(objTemp.str_CategoryName)
        }
        
        tf_Category.filterStrings(arr_Temp as! [String])
        tf_Category.userStoppedTypingHandler = {
            if  self.con_PopUpHeight.constant != 225{
                self.con_PopUpHeight.constant = 225
                self.tf_SubCategory.text = ""
                self.lbl_SubCategory1Title.text = ""
                self.lbl_SubCategory2Title.text = ""
            }
            } as (() -> Void)
        
//        tf_Category.users
        // Handle item selection - Default behaviour: item title set to the text field
        tf_Category.itemSelectionHandler = { filteredResults, itemPosition in
            
            // Just in case you need the item position
            var item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            
            self.tf_Category.text = item.title
            
            //Update index path with hall array
            self.manageSubCategoryObject(index : self.getIndexPath(compareString : item.title) , arr_Get : self.arr_Main)
        }
    }
    func manageSubCategoryObject(index : Int, arr_Get : NSMutableArray){
        
         self.con_PopUpHeight.constant = 400
        
//        self.tf_Category.isUserInteractionEnabled = false
//        self.btn_AddCategory.isUserInteractionEnabled = false
        
        self.lbl_SubCategory1Title.text = ""
        self.lbl_SubCategory2Title.text = ""
        self.lbl_PastSubCategoryTitle.isHidden = true
        
        let arr_Temp : NSMutableArray = []
        let objTemp = arr_Get[index] as! SelectCategoryPopUpObject
        
        self.str_CategorySelectedID = objTemp.str_CategoryId
        
        for count in 0..<objTemp.arr_SubCategory.count {
            
            let objTemp = objTemp.arr_SubCategory[count] as! SelectCategoryPopUpObject
            arr_Temp.add(objTemp.str_CategoryName)
        }
        
        self.tf_SubCategory.filterStrings(arr_Temp as! [String])
        
        //Hide show button
        objTemp.arr_SubCategory.count > 0 ? (self.btn_SubCategory1Title.isHidden = false) : (self.btn_SubCategory1Title.isHidden = true)
        objTemp.arr_SubCategory.count > 1  ? (self.btn_SubCategory2Title.isHidden = false) : (self.btn_SubCategory2Title.isHidden = true)
        
        if objTemp.arr_SubCategory.count > 0{
            self.lbl_PastSubCategoryTitle.isHidden = false
            
            let objTemp = objTemp.arr_SubCategory[0] as! SelectCategoryPopUpObject
            
            self.lbl_SubCategory1Title.text = objTemp.str_CategoryName
        }
        if objTemp.arr_SubCategory.count > 1{
            let objTemp = objTemp.arr_SubCategory[1] as! SelectCategoryPopUpObject
            
            self.lbl_SubCategory2Title.text = objTemp.str_CategoryName
        }
    }
    func getIndexPath(compareString : String) -> Int{
        for count in 0..<arr_Main.count {
            
            let objTemp = arr_Main[count] as! SelectCategoryPopUpObject
            if objTemp.str_CategoryName == compareString{
                return count
            }
        }
        
        return 0
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
         dismiss(animated:true, completion: nil)
    }
    @IBAction func btn_Done(_ sender:Any){
        if tf_Category.text != "" && tf_SubCategory.text != ""{
            
            self.Post_AddSubUpdateCategory()
            
        }else if tf_Category.text == ""{
                con_PopUpHeight.constant = 225
        }else if tf_Category.text != ""{
             self.Post_AddUpdateCategory()
        }
    }
    @IBAction func btn_Category1Title(_ sender:Any){
        let objTemp = arr_MainRecent[0] as! SelectCategoryPopUpObject
        
        tf_Category.text = objTemp.str_CategoryName
        str_CategorySelectedID = objTemp.str_CategoryId
        
        self.manageSubCategoryObject(index :0, arr_Get : arr_MainRecent)
    }
    @IBAction func btn_Category2Title(_ sender:Any){
        let objTemp = arr_MainRecent[1] as! SelectCategoryPopUpObject
        
        tf_Category.text = objTemp.str_CategoryName
        str_CategorySelectedID = objTemp.str_CategoryId
        
        self.manageSubCategoryObject(index :1, arr_Get : arr_MainRecent)
    }
    @IBAction func btn_SubCategory1Title(_ sender:Any){
        tf_SubCategory.text = lbl_SubCategory1Title.text
    }
    @IBAction func btn_SubCategory2Title(_ sender:Any){
        tf_SubCategory.text = lbl_SubCategory2Title.text
    }

    // MARK: - Get/Post Service -
    func Get_Category(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)get_category"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "get_category"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    func Post_AddUpdateCategory(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)add_category"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "category_name" : tf_Category.text,
            "parent_id" : "0",
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "add_category"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    func Post_AddSubUpdateCategory(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)add_category"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "category_name" : tf_SubCategory.text,
            "parent_id" : str_CategorySelectedID,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "add_subcategory"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
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

//MARK: - UITextField Delegates -
extension SelectCategoryPopUpViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if tf_SubCategory == textField{
            tbl_Main.setContentOffset(CGPoint(x:0,y:100), animated: true)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            
        return true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}




//MARK: - Object Decalration -
class SelectCategoryPopUpObject : NSObject {
    
    var str_CategoryId : String = ""
    var str_CategoryName : String = ""
    var str_UserId : String = ""
    var str_ParentId : String = ""
    
    var arr_SubCategory : NSMutableArray = []
    
    var str_ToOption1 : String = ""
    var str_ToOption2 : String = ""
    var str_FromOption1 : String = ""
    var str_FromOption2 : String = ""
    
    var str_ToIDOption1 : String = ""
    var str_ToIDOption2 : String = ""
    var str_FromIDOption1 : String = ""
    var str_FromIDOption2 : String = ""
    
    var arr_Recentcategory : NSMutableArray = []
}


extension SelectCategoryPopUpViewController : WebServiceHelperDelegate{
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "get_category" {
            
            let arr_Category = response["category_detail"] as! NSArray
            let arr_Recent = response["recent_used_category"] as! NSArray
                        
            arr_Main = []
            for count in 0..<arr_Category.count {
                
                let objTemp = SelectCategoryPopUpObject()
                
                let dictData = arr_Category[count] as! NSDictionary
                
                objTemp.str_CategoryId = String(dictData["category_id"] as! Int)
                objTemp.str_CategoryName = dictData["category_name"]  as? String ?? ""
                objTemp.str_UserId = dictData["user_id"]  as? String ?? ""
                objTemp.str_ParentId = dictData["parent_id"]  as? String ?? ""
                
                let arr_SubCategoryGet = dictData["sub_category"] as! NSArray
                
                objTemp.arr_SubCategory = []
                for count2 in 0..<arr_SubCategoryGet.count {
                    let dictSub = arr_SubCategoryGet[count2] as! NSDictionary
                    
                    let objTemp2 = SelectCategoryPopUpObject()
                    
                    objTemp2.str_CategoryId = String(dictSub["category_id"] as! Int)
                    objTemp2.str_CategoryName = dictSub["category_name"]  as? String ?? ""
                    objTemp2.str_UserId = dictSub["user_id"]  as? String ?? ""
                    objTemp2.str_ParentId = dictSub["parent_id"]  as? String ?? ""
                    
                    objTemp.arr_SubCategory.add(objTemp2)
                }
                
                arr_Main.add(objTemp)
            }
            
            arr_MainRecent = []
            for count in 0..<arr_Recent.count {
                
                let objTemp = SelectCategoryPopUpObject()
                
                let dictData = arr_Recent[count] as! NSDictionary
                
                objTemp.str_CategoryId = String(dictData["category_id"] as! Int)
                objTemp.str_CategoryName = dictData["category_name"]  as? String ?? ""
                objTemp.str_UserId = dictData["user_id"]  as? String ?? ""
                objTemp.str_ParentId = dictData["parent_id"]  as? String ?? ""
                
                let arr_SubCategoryGet = dictData["sub_category"] as! NSArray
                
                objTemp.arr_SubCategory = []
                for count2 in 0..<arr_SubCategoryGet.count {
                    let dictSub = arr_SubCategoryGet[count2] as! NSDictionary

                    let objTemp2 = SelectCategoryPopUpObject()

                    objTemp2.str_CategoryId = String(dictSub["category_id"] as! Int)
                    objTemp2.str_CategoryName = dictSub["category_name"]  as? String ?? ""
                    objTemp2.str_UserId = dictSub["user_id"]  as? String ?? ""
                    objTemp2.str_ParentId = dictSub["parent_id"]  as? String ?? ""

                    objTemp.arr_SubCategory.add(objTemp2)
                }
                
                arr_MainRecent.add(objTemp)
            }
            
            self.FillData()
        }else if strRequest == "add_category"{
            if bool_CategorySubcategoryShow == false{
                self.dismiss(animated: true) {
                    self.delegate?.ClickOption(info: 1)
                }
            }else{
                btn_SubCategoryImage.isHidden = false
                con_PopUpHeight.constant = 400
            }
            
            let dict_Category = response["selected_category"] as! NSDictionary
            if dict_Category != nil{
                let str_CategoryIDGet = String(response["new_category_id"] as! Int)
                str_CategorySelectedID = str_CategoryIDGet
                
                let arr_SubCategory = dict_Category["sub_category"] as? NSArray ?? []

                var arr_Temp : NSMutableArray = []
                for count in 0..<arr_SubCategory.count {
                    
                    let objTemp = arr_SubCategory[count] as! NSDictionary
                    arr_Temp.add(objTemp["category_name"]  as? String ?? "")
                }
                
                self.tf_SubCategory.filterStrings(arr_Temp as! [String])
                
                self.lbl_SubCategory1Title.text = ""
                self.lbl_SubCategory2Title.text = ""
                
                //Hide show button
                arr_SubCategory.count > 0 ? (self.btn_SubCategory1Title.isHidden = false) : (self.btn_SubCategory1Title.isHidden = true)
                arr_SubCategory.count > 1  ? (self.btn_SubCategory2Title.isHidden = false) : (self.btn_SubCategory2Title.isHidden = true)
                
                self.lbl_PastSubCategoryTitle.isHidden = true
                tf_Category.endEditing(true)
                if response["message"] as! String != "Category added successfully"{
                    if arr_SubCategory.count > 0{
                         self.lbl_PastSubCategoryTitle.isHidden = false
                        self.lbl_SubCategory1Title.text = arr_Temp[0] as! String
                    }
                    if arr_SubCategory.count > 1{
                        self.lbl_SubCategory2Title.text = arr_Temp[1] as! String
                    }
                }else{
                    arr_Temp = []
                    self.tf_SubCategory.filterStrings(arr_Temp as! [String])
                }
            }
            
        }else if strRequest == "add_subcategory"{
            
            //Save category and sub category in usermodule object
            let Dict_Category = response["selected_category"] as! NSDictionary
            if Dict_Category["category_name"] as? String ?? "" != ""{
                objUser?.category_SelectedCatId = String(Dict_Category["category_id"] as! Int)
                objUser?.category_SelectedCat = Dict_Category["category_name"] as! String
                
                let arr_SubCategory = Dict_Category["sub_category"] as! NSArray
                if arr_SubCategory.count != 0{
                    let dict_SubCategory = arr_SubCategory[0] as! NSDictionary
                    
                    objUser?.category_SelectedSubCatId = String(dict_SubCategory["category_id"] as! Int)
                    objUser?.category_SelectedSubCat = dict_SubCategory["category_name"] as! String
                }
            }
            
            //Save User Object
            saveCustomObject(objUser!, key: "userobject");
            
            if bool_Home == true{
                self.dismiss(animated: true) {
                    self.delegate?.ClickOption(info: 1)
                }
            }else{
                dismiss(animated:true, completion: nil)
            }
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        
        //        self.completedServiceCalling()
        //        self.reloadData()
    }
}




