//
//  DictionaryViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 16/11/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import Popover
import SwiftMessages
import IQKeyboardManagerSwift
import EmptyDataSet_Swift
import AutoScrollLabel

class DictionaryViewController: UIViewController,DismissViewDelegate,DismissSelectLanguageDelegate {
    
    //Other Declaration
    var isGoogleSelected: Bool =  false
    var boolResult: Bool =  false
    
    var arr_SearchData: [OCRSelectionObject] = []
    var arr_DictionarySelection : NSMutableArray = []
    
    var arr_StoreGoogle: [OCRSelectionObject] = []
    var arr_StoreLexin: [OCRSelectionObject] = []
    var arr_StoreGlobas: [OCRSelectionObject] = []
    
    @IBOutlet weak var txtWord: UITextField!
    
    @IBOutlet weak var cv_Dictionary: UICollectionView!
    
    @IBOutlet weak var tbl_Main: UITableView!
    
    @IBOutlet weak var btnTranslate: UIButton!
    @IBOutlet weak var btnVolume: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btn_More: UIButton!
    
    @IBOutlet weak var btn_SaveFavorite : UIButton!
    @IBOutlet weak var btn_SaveFavorite2: CBAutoScrollLabel!
    
    @IBOutlet var viewGooglePopup: UIView!
    @IBOutlet var viewShowTablePopup: UIView!
    @IBOutlet var viewShowMeaning: UIView!
    @IBOutlet var viewShowFavorite: UIView!
    @IBOutlet var vw_FooterTable: UIView!
    @IBOutlet weak var vw_SaveFavorite : UIView!
    @IBOutlet weak var vw_DataHeader : UIView!
    
    @IBOutlet var img_HeaderHideView: UIImageView!
    @IBOutlet weak var img_SaveFavorite : UIImageView!
    
    @IBOutlet var tablePopup: UITableView!
    
    //Image Picker
    let picker = UIImagePickerController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commanMethod()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        btn_SaveFavorite.isHidden = true
        if objUser?.category_SelectedSubCat == ""{
            btn_SaveFavorite.isHidden = true
            btn_SaveFavorite2.isHidden = true
            img_SaveFavorite.isHidden = true
            vw_SaveFavorite.isHidden = true
            
            btn_SaveFavorite.setTitle("", for: .normal)
            btn_SaveFavorite2.text = ""
        }else{
//            btn_SaveFavorite.isHidden = false
            btn_SaveFavorite2.isHidden = false
            img_SaveFavorite.isHidden = false
            vw_SaveFavorite.isHidden = false
            
            btn_SaveFavorite.setTitle("\(objUser?.category_SelectedCat as! String)/\(objUser?.category_SelectedSubCat as! String)", for: .normal)
            btn_SaveFavorite2.text = "\(objUser?.category_SelectedCat as! String)/\(objUser?.category_SelectedSubCat as! String)"
        }
        
        //Text editing manager
        IQKeyboardManager.sharedManager().enable = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = false
        
        //Manage Collection view object
        arr_DictionarySelection = selectedDictionary()
        cv_Dictionary.reloadData()
        
        btn_SaveFavorite2.scrollLabelIfNeeded()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //Text editing manager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func commanMethod() {
        
        picker.delegate = self
        
        btnTranslate.isEnabled = true
        btnVolume.isEnabled = false
        btnFavorite.isEnabled = false
        btn_SaveFavorite.isEnabled = false
        vw_SaveFavorite.alpha = 0.5
        btn_SaveFavorite.alpha = 0.5
        btn_SaveFavorite2.alpha = 0.5
        
        tbl_Main.emptyDataSetDelegate = self
        tbl_Main.emptyDataSetSource = self
        
        btn_SaveFavorite.titleLabel?.font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 17))
        
        btn_SaveFavorite2.textColor = UIColor.white
        btn_SaveFavorite2.font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 17))!
        btn_SaveFavorite2.scrollDirection = CBAutoScrollDirection.left
    }
    
    func ClickOption(info: NSInteger) {
        if info == 1 {
            btn_SaveFavorite.isHidden = true
            if objUser?.category_SelectedSubCat == ""{
                btn_SaveFavorite.isHidden = true
                btn_SaveFavorite2.isHidden = true
                img_SaveFavorite.isHidden = true
                vw_SaveFavorite.isHidden = true
                btn_SaveFavorite.setTitle("", for: .normal)
                btn_SaveFavorite2.text = ""
                
            }else{
//                btn_SaveFavorite.isHidden = false
                btn_SaveFavorite2.isHidden = false
                img_SaveFavorite.isHidden = false
                vw_SaveFavorite.isHidden = false
                btn_SaveFavorite.setTitle("\(objUser?.category_SelectedCat as! String)/\(objUser?.category_SelectedSubCat as! String)", for: .normal)
                btn_SaveFavorite2.text = "\(objUser?.category_SelectedCat as! String)/\(objUser?.category_SelectedSubCat as! String)"
            }
        }
        
    }
    func ClickLanguageOption(info: NSInteger) {
        if info == 1 {
            if langSelectedOrNot() == true{
                
                //Temp value remove
                arr_StoreGoogle = []
                arr_StoreLexin = []
                arr_StoreGlobas = []
                
                //Manage Collection view object
                arr_DictionarySelection = selectedDictionary()
                manageSelectedeDictionaryAsaFirst()
                cv_Dictionary.reloadData()
                tbl_Main.reloadData()
                
                self.manageServiceCalling()
            }
        }
    }
    
    func showCameraOption() {
        self.picker.navigationBar.tintColor = UIColor.white
        let alert = UIAlertController(title: GlobalConstants.appName, message: "Choose a picture", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                self.picker.allowsEditing = true
                self.picker.sourceType = .camera
                
                self.present(self.picker, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (action) in
            self.picker.allowsEditing = true
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func manageServiceCalling(){
        self.view.endEditing(true)
        
        if arr_DictionarySelection.count != 0{
            if objUser!.traslation_DictionaryName == "1"{
                self.Post_TraslationGoogle(strText: txtWord.text!)
            }else if objUser!.traslation_DictionaryName == "2"{
                self.Post_TraslationLexin(strText: txtWord.text!)
            }else if objUser!.traslation_DictionaryName == "3"{
                self.Post_TraslationGlosbe(strText: txtWord.text!)
            }
        }
    }
    
    func validateScreenWithTextChange() {
        if (arr_SearchData.count == 0) {
            btnVolume.isEnabled = false
            btnFavorite.isEnabled = false
            vw_FooterTable.isHidden = true
            vw_DataHeader.isHidden = true
            btn_SaveFavorite.isEnabled = false
            vw_SaveFavorite.alpha = 0.5
            btn_SaveFavorite.alpha = 0.5
            btn_SaveFavorite2.alpha = 0.5
        }else {
            btnVolume.isEnabled = true
            btnFavorite.isEnabled = true
            vw_FooterTable.isHidden = false
            vw_DataHeader.isHidden = false
            btn_SaveFavorite.isEnabled = true
            vw_SaveFavorite.alpha = 1.0
            btn_SaveFavorite.alpha = 1.0
            btn_SaveFavorite2.alpha = 1.0
            
        }
        
        
        //Manage button volume
        if objUser?.traslation_Play != "1"{
            btnVolume.isEnabled = false
        }else{
            //For speak word they have show when text in textfield
            if txtWord.text != ""{
                btnVolume.isEnabled = true
            }else{
                btnVolume.isEnabled = false
            }
        }
    }
    func reloadView(){
        cv_Dictionary.reloadData()
        tbl_Main.reloadData()
    }
    
    // MARK: - Button Event -
    @IBAction func translateClick(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SelectLanguageViewController") as! SelectLanguageViewController
        view.delegate = self
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
        
        self.view.endEditing(true)
        txtWord.resignFirstResponder()
    }
    @IBAction func otherDictClick(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    @IBAction func cameraClikck(_ sender: UIButton) {
        self.view.endEditing(true)
        self.showCameraOption()
    }
    @IBAction func moreClick(_ sender: UIButton) {
        if btn_More.isSelected == true{
            btn_More.isSelected = false
        }else{
            btn_More.isSelected = true
            
            let when = DispatchTime.now() + 0.3
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.tbl_Main.setContentOffset(CGPoint(x: 0, y: 160), animated: true)
            }
        }
        tbl_Main.reloadData()
        self.view.endEditing(true)
        //    viewShowTablePopup.isHidden = !viewShowTablePopup.isHidden
    }
    @IBAction func lessClick(_ sender: UIButton) {
        self.view.endEditing(true)
        viewShowTablePopup.isHidden = !viewShowTablePopup.isHidden
    }
    
    
    @IBAction func showMeaningHideClick(_ sender: UIButton) {
        self.view.endEditing(true)
        viewShowMeaning.isHidden = !viewShowMeaning.isHidden
    }
    @IBAction func favoriteSaveClick(_ sender: UIButton) {
        txtWord.resignFirstResponder()
        if btn_SaveFavorite2.isHidden == true{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
            view.bool_Home = true
            view.delegate = self
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            present(view, animated: true)
        }else{
            
            self.Post_Review()
        }
    }
    @IBAction func favoriteSaveClick2(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
        view.bool_Home = true
        view.delegate = self
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
    }
    @IBAction func favoriteSaveClick3(_ sender: UIButton) {
        if objUser?.category_SelectedSubCat != ""{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
            view.bool_Home = true
            view.delegate = self
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            present(view, animated: true)
        }
    }
    
    @IBAction func favoriteHiddenClick(_ sender: UIButton) {
        self.view.endEditing(true)
        viewShowFavorite.isHidden = !viewShowFavorite.isHidden
        
    }
    @IBAction func favoritePopupDoneClick(_ sender: UIButton) {
//        btn_SaveFavorite.isHidden = false
        btn_SaveFavorite2.isHidden = false
        img_SaveFavorite.isHidden = false
        vw_SaveFavorite.isHidden = false
        
        self.view.endEditing(true)
        viewShowFavorite.isHidden = !viewShowFavorite.isHidden
    }
    @IBAction func btn_Volume(_ sender: UIButton) {
//        if (arr_SearchData.count != 0) {
//            let obj = arr_SearchData[0]
        
//            playMusic(str_TraslationText : obj.str_Title,Language : objUser?.traslation_ToName ?? "en")
            playMusic(str_TraslationText : txtWord.text! ,Language : objUser?.traslation_FromName ?? "en")
//        }
    }
    
    // MARK: - Get/Post Method -
    func Post_TraslationGoogle(strText : String){
        
        if strText != ""{
            
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
            
            self.reloadView()
        }
    }
    
    func Post_TraslationGlosbe(strText : String){
        
        if strText != ""{
            //Declaration URL
            //            let strURL = "https://glosbe.com/gapi/translate?from=\(objUser?.traslation_FromNameGlobse as! String)&dest=\(objUser?.traslation_ToNameGlobse as! String)&format=json&phrase=\(strText.lowercased())&pretty=true"
            //
            //            //Create object for webservicehelper and start to call method
            //            let webHelper = WebServiceHelper()
            //            webHelper.strMethodName = "ocrglosbeconvert"
            //            webHelper.methodType = "get"
            //            webHelper.strURL = strURL
            //            webHelper.dictType = NSDictionary()
            //            webHelper.dictHeader = NSDictionary()
            //            webHelper.delegateWeb = self
            //            webHelper.serviceWithAlert = true
            //            webHelper.startDownload()
            
            
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
            
            self.reloadView()
        }
        
        
    }
    
    func Post_UpdateDictionary(str_Language : String){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)update_dictionary"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "dictionary_name" : str_Language,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "update_dictionary"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
        
        self.reloadView()
    }
    func Post_OnlyUpdateDictionary(str_Language : String){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)update_dictionary"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "dictionary_name" : str_Language,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "update_dictionary2"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.indicatorShowOrHide = false
        webHelper.startDownload()
        
        self.reloadView()
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
            
            self.reloadView()
        }
    }
    
    func Post_Review(){
        
        if arr_SearchData.count != 0{
            //Declaration URL
            let strURL = "\(GlobalConstants.BaseURL)add_card"
            
            //make array for image comment
            let arr_Comment : NSMutableArray = []
            let arr_Image : NSMutableArray = []
            let arr_ImageType : NSMutableArray = []
            let arr_ImageName : NSMutableArray = []
            
            
            //Create array for meaning
            var arr_Meaning : NSMutableArray = []
            for j in (0..<Int(arr_SearchData.count)){
                var obj = arr_SearchData[j]
                let dict_Store : NSDictionary = [
                    "meaning" : obj.str_convert.lowercased(),
                    ]
                arr_Meaning.add(dict_Store)
            }
            
            var objCard = arr_SearchData[0]
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title),
                "meaning_array" : arr_Meaning,
                "is_replace" : "0",
                "card_id" : "0",
//                "is_replace" : objCard.str_CardID == "0" ? "0" : "1",
//                "card_id" : objCard.str_CardID,
                ]
            arr_Comment.add(dict_Store)
            
            objCard.str_Image = (GlobalConstants.img_Temp) as String
            if objCard.str_Image != ""{
                //Image save in array
                let url = URL(string: objCard.str_Image as! String)
                
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                let image_Save : UIImage = UIImage(data: data!)!
                let imgData = UIImageJPEGRepresentation(image_Save, 0.75)
                
                arr_Image.add(imgData)
                arr_ImageType.add("photo")
                arr_ImageName.add("image0")
            }else{
                arr_Image.add("")
                arr_ImageType.add("photo")
                arr_ImageName.add("image0")
            }
            
            
            
            //Convert array in string
            let string = notPrettyString(from : arr_Comment)
            
            //Pass data in dictionary
            var jsonData : NSMutableDictionary =  NSMutableDictionary()
            jsonData = [
                "user_id" : objUser?.user_UserID ?? "0",
                "keyword" : string ?? "",
                "category_id" : objUser?.category_SelectedCatId ?? "0",
                "sub_category_id" : objUser?.category_SelectedSubCatId ?? "0",
                "from_language_id" : objUser?.traslation_FromId ?? "0",
                "dictionary_id" : objUser?.traslation_DictionaryName ?? "0",
                "store_type" : "0",
            ]
            
            jsonData.setValue(objUser?.traslation_ToID ?? "0", forKey: "to_language_id")
            
            
            //Create object for webservicehelper and start to call method
            let webHelper = WebServiceHelper()
            webHelper.strMethodName = "add_card"
            webHelper.methodType = "post"
            webHelper.strURL = strURL
            webHelper.dictType = jsonData
            webHelper.dictHeader = NSDictionary()
            webHelper.delegateWeb = self
            webHelper.serviceWithAlert = true
            webHelper.arr_MutlipleimagesAndVideo = arr_Image
            webHelper.arr_MutlipleimagesAndVideoType = arr_ImageType
            webHelper.arr_MutlipleimagesAndVideoName = arr_ImageName
            webHelper.imageUploadName = "image"
            webHelper.startUploadingMultipleImagesAndVideo()
            
            self.reloadView()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ocr" {
            let viewSelectedImage = segue.destination as? OCRSelectionViewController
            viewSelectedImage?.getImage  = sender as! UIImage
        }
    }
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        
        //If user already search word than remove result type start
        if arr_SearchData.count != 0{
            //Temp value remove
            arr_StoreGoogle = []
            arr_StoreLexin = []
            arr_StoreGlobas = []
            
            boolResult = false
            arr_SearchData = []
            tbl_Main.reloadData()
        }
        
        //Validation for hide show depened on result array
        self.validateScreenWithTextChange()
        
        
        if (sender.text?.isEmpty)! {
            img_HeaderHideView.isHidden = false
        }else {
            img_HeaderHideView.isHidden = true
        }
    }
}
extension DictionaryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if langSelectedOrNot() == false{
            messageBar.MessageShow(title: "Please select language first", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if langSelectedOrNot() == true{
            manageSelectedeDictionaryAsaFirst()
            cv_Dictionary.reloadData()
            
            self.manageServiceCalling()
        }else{
            messageBar.MessageShow(title: "Please select language first", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }
        
        return true
    }
    
}


class DictinaryCollectionCell : UICollectionViewCell {
    
    @IBOutlet var img_Icon: UIImageView!
    @IBOutlet var img_Selected: UIImageView!
    @IBOutlet var img_SelectedFront: UIImageView!
}


//MARK: - Collection View -
extension DictionaryViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return arr_DictionarySelection.count
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 50, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DictinaryCollectionCell
        
        cell.img_Selected.isHidden = true
        cell.img_SelectedFront.isHidden = true
        
        let obj : DictionaryManageObject = arr_DictionarySelection[indexPath.row] as! DictionaryManageObject
        
        cell.img_Icon.image = UIImage(named:obj.str_Image)
        

        if obj.str_Image == "icon_Dictionary2" && validationforLexinEnglishDictionaryShow() == true{
            cell.img_Icon.image = UIImage(named:"icon_Dictionary2-1")
        }
        
        if Int(objUser!.traslation_DictionaryName)! == Int(obj.str_IdentifierId){
            cell.img_SelectedFront.isHidden = false
            cell.img_Icon.image = UIImage(named:"\(obj.str_Image)_Sel")

            if obj.str_Image == "icon_Dictionary2" && validationforLexinEnglishDictionaryShow() == true{
                cell.img_Icon.image = UIImage(named:"icon_Dictionary2_Sel-1")
            }
            
            if arr_SearchData.count != 0{
                cell.img_Selected.isHidden = false
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let obj : DictionaryManageObject = arr_DictionarySelection[indexPath.row] as! DictionaryManageObject

        objUser?.traslation_DictionaryName = obj.str_IdentifierId
        
        if obj.str_Title == "Laxin" && arr_StoreLexin.count != 0{
            arr_SearchData = arr_StoreLexin
            tbl_Main.reloadData()
            cv_Dictionary.reloadData()
            self.Post_OnlyUpdateDictionary(str_Language : obj.str_Title)
        }else if obj.str_Title == "Glosbe" && arr_StoreGlobas.count != 0{
            arr_SearchData = arr_StoreGlobas
            tbl_Main.reloadData()
            cv_Dictionary.reloadData()
            self.Post_OnlyUpdateDictionary(str_Language : obj.str_Title)
        }else if obj.str_Title == "Google" && arr_StoreGoogle.count != 0{
            arr_SearchData = arr_StoreGoogle
            tbl_Main.reloadData()
            cv_Dictionary.reloadData()
            self.Post_OnlyUpdateDictionary(str_Language : obj.str_Title)
        }else{
            arr_SearchData = []
            tbl_Main.reloadData()
            
            let obj : DictionaryManageObject = arr_DictionarySelection[indexPath.row] as! DictionaryManageObject
            self.Post_UpdateDictionary(str_Language : obj.str_Title)
        }
        
        
        
        //        if langSelectedOrNot() == true{
        //
        //        }else{
        //            messageBar.MessageShow(title: "Please select language first", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        //        }
        //        cv_Dictionary.reloadData()
    }
}



class TablePopup: UITableViewCell {
    // MARK: - Table Cell -
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    @IBOutlet var img_More: UIImageView!
    
    @IBOutlet var vw_CenterLine: UIView!
}

// MARK: - Table Delegate -
extension DictionaryViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Manage hide and show depend on result
        self.validateScreenWithTextChange()
        
        if tableView == tbl_Main{
            if img_HeaderHideView.isHidden == true{
                vw_FooterTable.isHidden = false
                btn_More.isHidden = true
                
                //Button MOre
                if arr_SearchData.count > 1{
                    btn_More.isHidden = false
                }
                
                cv_Dictionary.reloadData()
                //Manage view with btn more
                if btn_More.isSelected == true{
                    if arr_SearchData.count > 0{
                        vw_FooterTable.isHidden = false
                    }else{
                        vw_FooterTable.isHidden = true
                    }
                    
                    return arr_SearchData.count
                }else{
                    if arr_SearchData.count > 0{
                        return 1
                    }else{
                        vw_FooterTable.isHidden = true
                        return 0
                    }
                }
            }else{
                return 0
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tbl_Main{
            let obj = arr_SearchData[indexPath.row]
            if obj.str_convert == ""{
                return 70
            }
            
            return UITableViewAutomaticDimension
        }
        return 60
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tbl_Main{
            return 50
        }
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier : String = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! TablePopup
        
        if tableView == tbl_Main{
            let obj = arr_SearchData[indexPath.row]
            cell.lblTitle.text = obj.str_Title
            cell.lblDescription.text = obj.str_convert
            cell.selectionStyle = .none
            
            //Arrow hide and show
            cell.img_More.isHidden = true
            if obj.str_Example != ""{
                cell.img_More.isHidden = false
            }
            if objUser?.traslation_SupportedLexin == "1" || objUser?.traslation_SupportedGlobse == "1"{
                if obj.arr_Traslation.count > 1 || obj.arr_Meaning.count > 1 || obj.arr_Example.count > 0 || obj.arr_Inflection.count > 0 || obj.arr_Synonym.count > 0 ||  obj.arr_AnotherWord.count > 0{
                    cell.img_More.isHidden = false
                }
            }
                
            
            //Center line
            cell.vw_CenterLine.isHidden = false
            if obj.str_convert != ""{
                cell.vw_CenterLine.isHidden = false
            }
        }
        
        //Manage font
        cell.lblTitle.font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 17))
        cell.lblDescription.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tbl_Main{
            let obj = arr_SearchData[indexPath.row]
            
            if objUser?.traslation_DictionaryName == "2" || objUser?.traslation_DictionaryName == "3"{
                if obj.arr_Traslation.count > 1 || obj.arr_Meaning.count > 1 || obj.arr_Example.count > 0 || obj.arr_Inflection.count > 0 || obj.arr_Synonym.count > 0 || obj.arr_AnotherWord.count > 0{
                
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let view = storyboard.instantiateViewController(withIdentifier: "ExamplePopUpViewController2") as! ExamplePopUpViewController2
                    view.obj_Get = obj
                    view.modalPresentationStyle = .custom
                    view.modalTransitionStyle = .crossDissolve
                    present(view, animated: true)
                }
            }
//            else{
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let view = storyboard.instantiateViewController(withIdentifier: "ExamplePopUpViewController") as! ExamplePopUpViewController
//                view.str_Title = obj.str_Title
//                view.arr_Data = [obj.str_convert,obj.str_Example == "" ? "" :"Example",obj.str_Example]
//                view.modalPresentationStyle = .custom
//                view.modalTransitionStyle = .crossDissolve
//                present(view, animated: true)
//            }
        }
    }
}

extension DictionaryViewController: EmptyDataSetSource,EmptyDataSetDelegate {
    //  func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
    //    return UIImage.init(named: "img_Add")
    //  }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat{
        return 120
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var text: String?
        var font: UIFont?
        var textColor: UIColor?
        
        if webservice_Nool_Load == false{
            if objUser?.traslation_FromTitle == ""{
                text = "Please select Language first"
            }else if boolResult == false || txtWord.text == ""{
                text = "Please search word first"
            }else{
                if objUser?.traslation_FromTitle == ""{
                    text = "Please select Language first"
                }else{
                    text = "The word \"\(txtWord.text as! String)\" is\n not in the dictionary"
                }
            }
        }else{
            text = ""
        }
        
        font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 20))
        textColor = UIColor(red: 109/255, green: 109/255, blue: 109/255, alpha: 1.0)
        
        if text == nil {
            return nil
        }
        var attributes: [NSAttributedStringKey: Any] = [:]
        
        if font != nil {
            attributes[NSAttributedStringKey.font] = font!
        }
        if textColor != nil {
            attributes[NSAttributedStringKey.foregroundColor] = textColor
        }
        return NSAttributedString.init(string: text!, attributes: attributes)
        
    }
}


// MARK: - Object Class -
class DictionaryManageObject : NSObject {
    var str_Title: String = ""
    var str_TitleShow: String = ""
    var str_ToId: String = ""
    var str_IdentifierId: String = ""
    var str_ToFrom: String = ""
    var str_Image: String = ""
}


// MARK: - Picker View and Navigation -
extension DictionaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        dismiss(animated: true, completion: nil)
        
        //UIImagePickerControllerEditedImage
        //UIImagePickerControllerOriginalImage
        let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            let imgData = UIImageJPEGRepresentation(pickedImage!, 0.75)
        
        self.performSegue(withIdentifier: "ocr", sender: UIImage(data:imgData!,scale:1.0))
        
        //    let objimgcls = objectImageClass()
        //    objimgcls.objimage = pickedImage!
        //    arySelectedDocument?.add(objimgcls)
        //
        //    ColViewDocument.reloadData()
        
        //    //Upload Images
        //    let imgData = UIImageJPEGRepresentation(pickedImage!, 0.75)
        //
        //    //      let arr_ImageData : NSMutableArray = []
        //    arrMultipleImages.add(imgData as Any)
        //    //      arrMultipleImages = arr_ImageData
        //
        //    //Set array for image type
        //    //      let arr_ImageType : NSMutableArray = []
        //    arrDataType.add("photo")
        //    //      arrDataType = arr_ImageType
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


extension DictionaryViewController : WebServiceHelperDelegate{
    
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "update_dictionary"{
            userObjectUpdate(dict_Get : response)
            cv_Dictionary.reloadData()
            
            if txtWord.text != ""{
                manageServiceCalling()
            }
            tbl_Main.reloadData()
        }else if strRequest == "update_dictionary2"{
            userObjectUpdate(dict_Get : response)
            cv_Dictionary.reloadData()
            
            tbl_Main.reloadData()
        } else if strRequest == "ocrgoogleconvert"{
            
            arr_SearchData = []
            
            
            let arr_Translation = response["translation"] as! NSArray
            
            for count in 0..<arr_Translation.count {
                let traslateDict = arr_Translation[count] as! NSDictionary
                let arr_Image = traslateDict["image_array"] as! NSArray
                
                var obj = OCRSelectionObject()
                obj.str_Title = traslateDict["translation"] as! String
                obj.str_convert = ""
                
                //Image set
                if arr_Image.count != 0{
                    obj.str_Image = arr_Image[0] as! String
                }
                
                arr_SearchData.append(obj)
            }
            
            //Store local data
            arr_StoreGoogle = arr_SearchData
            
            boolResult = true
            tbl_Main.reloadData()
            
        }else if strRequest == "ocrglosbeconvert"{
            
            let arr_responseData = response["result"] as! NSArray
            
            let dict_response = arr_responseData[0] as! NSDictionary
            
            arr_SearchData = []
            
            let arr_Translation = dict_response["translate_array"] as! NSArray
            let arr_Meaning = dict_response["meaning_array"] as! NSArray
            let arr_Example = dict_response["exmaple_array"] as! NSArray
            let arr_Image = dict_response["image_array"] as! NSArray
            
            for count in 0..<arr_Translation.count {
                
                var obj = OCRSelectionObject()
                obj.arr_Traslation = []
                obj.arr_Meaning = []
                obj.arr_Example = []
                obj.arr_Inflection = []
                obj.arr_Image = []
                obj.arr_Synonym = []
                obj.arr_AnotherWord = []
                
                //Traslation
                let arr_Translation2 = arr_Translation[count] as! NSArray
                
                if arr_Translation2.count != 0{
                    obj.str_Title = arr_Translation2[0] as! String
                    
                    for i in 0..<arr_Translation2.count {
                        obj.arr_Traslation.add(arr_Translation2[i] as! String)
                    }
                }
                
                //Traslation
                let arr_meaning_array = arr_Meaning[count] as! NSArray
                
                if arr_meaning_array.count != 0{
                    obj.str_convert = arr_meaning_array[0] as! String
                    
                    for i in 0..<arr_meaning_array.count {
                        obj.arr_Meaning.add(arr_meaning_array[i] as! String)
                    }
                }
                
                
                //Image set
                if arr_Image.count != 0{
                    obj.str_Image = arr_Image[0] as! String
                }
                
                arr_SearchData.append(obj)
            }
            
            //Store local data
            arr_StoreGlobas = arr_SearchData
            
            boolResult = true
            tbl_Main.reloadData()
            
        }else if strRequest == "translate_lexin"{
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
                
                arr_SearchData = []
                
                for count in 0..<arr_Translation.count {
                    
                    var obj = OCRSelectionObject()
                    obj.arr_Traslation = []
                    obj.arr_Meaning = []
                    obj.arr_Example = []
                    obj.arr_Inflection = []
                    obj.arr_Image = []
                    obj.arr_Synonym = []
                    obj.arr_AnotherWord = []
                    
                    //Traslation
                    let arr_Translation2 = arr_Translation[count] as! NSArray
                    
                    if arr_Translation2.count != 0{
                        obj.str_Title = arr_Translation2[0] as! String
                        
                        for i in 0..<arr_Translation2.count {
                            obj.arr_Traslation.add(arr_Translation2[i] as! String)
                        }
                    }
                    
                    obj.str_convert = ""
                    
                    //Meaning
                    let arr_Meaning2 = arr_Meaning[count] as! NSArray
                    if arr_Meaning2.count != 0{
                        obj.str_convert = arr_Meaning2[0] as! String
                        
                        for i in 0..<arr_Meaning2.count {
                            obj.arr_Meaning.add(arr_Meaning2[i] as! String)
                        }
                    }
                    
                    //Example
                    let arr_Example2 = arr_Example[count] as! NSArray
                    if arr_Example2.count != 0{
                        obj.str_Example = arr_Example2[0] as! String
                        
                        for i in 0..<arr_Example2.count {
                            obj.arr_Example.add(arr_Example2[i] as! String)
                        }
                    }
                    
                    
                    //Inflection
                    let arr_Inflection2 = arr_Inflection[count] as! NSArray
                    if arr_Inflection2.count != 0{
                        
                        for i in 0..<arr_Inflection2.count {
                            obj.arr_Inflection.add(arr_Inflection2[i] as! String)
                        }
                    }
                    
                    //Image
                    if arr_Image.count != 0{
                        for i in 0..<arr_Image.count {
                            obj.arr_Image.add(arr_Image[i] as! String)
                        }
                    }
                    
                    //Synonym
                    let arr_Synonym2 = arr_Synonym[count] as! NSArray
                    if arr_Synonym2.count != 0{
                        
                        for i in 0..<arr_Synonym2.count {
                            obj.arr_Synonym.add(arr_Synonym2[i] as! String)
                        }
                    }
                    
                    //AnotherWord
                    let arr_Another2 = arr_Another[count] as! NSArray
                    if arr_Another2.count != 0{
                        
                        for i in 0..<arr_Another2.count {
                            obj.arr_AnotherWord.add(arr_Another2[i] as! String)
                        }
                    }
                    
                    arr_SearchData.append(obj)
                }
                
                //Store local data
                arr_StoreLexin = arr_SearchData
                
                boolResult = true
                tbl_Main.reloadData()
            }
            
        }else if strRequest == "add_card"{
            
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        tbl_Main.reloadData()
        print(error)
    }
    
}
