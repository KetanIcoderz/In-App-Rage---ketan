//
//  OCRresultview.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages
import EmptyDataSet_Swift

class OCRresultview: UIViewController, DismissViewDelegate,DismissWordSelectionDelegate,DismissCardDetailDelegate {
    var isShowCardAllDetails: Bool = false
    var longPressGesture = UILongPressGestureRecognizer()
    
    var arrCards = [Array<OCRSelectionObject>]()
    
    var bool_Move : Bool = false
    
    @IBOutlet var collectionVw: UICollectionView!
    
    @IBOutlet var btn_SaveAll: UIButton!
    
    var arr_Get : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        collectionVw.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.titleView = UIImageView.init(image: UIImage(named:"navigationTitle"))
        
        bool_Move = true
        
        if selectedSection != -1 {
            
            let when = DispatchTime.now() + 0.3
            DispatchQueue.main.asyncAfter(deadline: when) {
                if let attributes = self.collectionVw.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: NSIndexPath.init(row: 0, section: selectedSection-1) as IndexPath) {
                    self.collectionVw.setContentOffset(CGPoint(x: 0, y: attributes.frame.origin.y - self.collectionVw.contentInset.top), animated: true)
                }
                selectedSection = -1
            }
        }else{
            if let attributes = collectionVw.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: NSIndexPath.init(row: 0, section: 0) as IndexPath) {
                collectionVw.setContentOffset(CGPoint(x: 0, y: attributes.frame.origin.y - collectionVw.contentInset.top), animated: true)
            }
        }
        collectionVw.reloadData()
        
        collectionVw.emptyDataSetDelegate = self
        collectionVw.emptyDataSetSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Custom Method -
    func setupView() {
        var subArray1:[OCRSelectionObject] = []
        
        for j in 0..<arr_Get.count {
            let objGet : OCRSelectionObject = arr_Get[j] as! OCRSelectionObject
            subArray1.append(objGet)
        }
        arrCards.append(subArray1)
        self.Get_CheckSaveOrNot()
        
    }
    
    func ClickOption(info: NSInteger) {
        if info == 1 {
            
        }
    }
    func ClickDismissWordSelectionOption(info: NSMutableArray) {
        
        let subArr =  self.arrCards[0]
        
        var subArray1:[OCRSelectionObject] = []
        for count in 0..<subArr.count {
            let objCard = subArr[count]

            var bool_value : Bool = true
            for count2 in 0..<info.count {
                let obj = info[count2] as! OCRSelectionObject
                
                if objCard.str_Title == obj.str_Title{
                    bool_value = false
                    if obj.str_SaveOrNot == "1"{
                        subArray1.append(objCard)
                        break
                    }
                }
            }
            
            if bool_value == true{
                 subArray1.append(objCard)
            }
        }
        self.arrCards[0] = subArray1
        
        self.Post_Review()
    }
    
    func ClickDismissCardDetailOption(obj: OCRSelectionObject){
    
        if obj.str_IsDeleted == "1"{
            let subArr =  self.arrCards[0]
            var subArray1:[OCRSelectionObject] = []
            
            for i in (0..<Int(subArr.count)){
                if Int(obj.str_ID) != i{
                    subArray1.append(subArr[i])
                }
            }
            self.arrCards[0] = subArray1
            if subArray1.count == 0{
                self.navigationController?.popViewController(animated: true)
            }
            self.collectionVw.reloadData()
        }else{
            var arrSub = arrCards[0]
            let objCard = arrSub[Int(obj.str_ID)!]
            
            objCard.str_Title = obj.str_Title
            objCard.str_convert = obj.str_convert
            objCard.str_Image = obj.str_Image as String
            objCard.data_Image = obj.data_ImageData
            
            arrSub[Int(obj.str_ID)!] = objCard
            self.arrCards[0] = arrSub
        }
    }

    
    //MARK: - Gesture Method -
    //Called, when long press occurred
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if bool_Move == true{
            
            let p = sender.location(in: collectionVw)
            if let indexPath = collectionVw.indexPathForItem(at: p){
                
                let arrSub = arrCards[0]
                let objCard = arrSub[indexPath.row]
                
                objCard.str_ID = String(indexPath.row)
                
                let view = self.storyboard?.instantiateViewController(withIdentifier: "ReviewDetailViewController") as! ReviewDetailViewController
                view.objGet = objCard
                view.delegate = self
                self.navigationController?.pushViewController(view, animated: true)
                bool_Move = false
            }
        }
        
    }
    
    @objc func tapBarButton(_ sender: UITapGestureRecognizer) {
        
        let p = sender.location(in: collectionVw)
        if let indexPath = collectionVw.indexPathForItem(at: p) {
            // get the cell at indexPath (the one you long pressed)
            let subArr =  arrCards[indexPath.section]
            let obj = subArr[indexPath.row]
            if obj.is_CardFront {
                obj.is_CardFront = false
                let cell = collectionVw.cellForItem(at: indexPath)
                UIView.transition(with: cell!, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                self.showHideOtherViews(cell as! AllWordsCell, isShow: false)
                longPressGesture.isEnabled = true
            }else {
                obj.is_CardFront = true
                let cell = collectionVw.cellForItem(at: indexPath)
                UIView.transition(with: cell!, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                self.showHideOtherViews(cell as! AllWordsCell, isShow: true)
                longPressGesture.isEnabled = true
            }
            //        collectionVw.reloadData()
            // do stuff with the cell
        } else {
            print("couldn't find index path")
        }
        
    }
    
    func showHideOtherViews(_ cell: AllWordsCell, isShow: Bool) {
        
        cell.imgVwWordPhoto.isHidden = isShow
        cell.lblWordCenter.isHidden = !isShow
        cell.lblWord.isHidden = isShow
        cell.lblGoogleMeaning.isHidden = isShow
        cell.btnGoogle.isHidden = isShow
        
        cell.btnSpeak.isHidden = isShow
        cell.btnSpeak2.isHidden = isShow
        
        cell.btnSpeak.alpha = 0.3
        cell.btnSpeak2.alpha = 0.3
        
        cell.btnSpeak.isUserInteractionEnabled = isShow
        cell.btnSpeak2.isUserInteractionEnabled = isShow
        
        //If get true and also play true then only show this button
        if isShow == false{
            if objUser?.traslation_Play == "1"{
                cell.btnSpeak.isUserInteractionEnabled = true
                cell.btnSpeak2.isUserInteractionEnabled = true
                
                cell.btnSpeak.alpha = 1.0
                cell.btnSpeak2.alpha = 1.0
            }else{
                cell.btnSpeak.isUserInteractionEnabled = false
                cell.btnSpeak2.isUserInteractionEnabled = false
                
                cell.btnSpeak.alpha = 0.3
                cell.btnSpeak2.alpha = 0.3
            }
        }
        
        cell.btn_Close.isHidden = isShow
        cell.btn_Star.isHidden = isShow
    }
    
    //MARK: - Button Event -
    @IBAction func btn_Back(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_Download(_ sender : Any){
        
        let subArr =  self.arrCards[0]
        
        var arr_GetLocal : NSMutableArray = []
        for count in 0..<subArr.count {
            let objCard = subArr[count]
            if objCard.str_CardSaveFlag != "-1" && objCard.str_CardSaveFlag != "0"{
                 let obj = OCRSelectionObject()
                obj.str_Title = objCard.str_Title
                obj.str_SaveOrNot = "0"
                obj.str_CatSave = objCard.str_CatSave
                arr_GetLocal.add(obj)
            }
        }
        
        if arr_GetLocal.count != 0{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "WordSelectionViewController") as! WordSelectionViewController
            view.arr_Data = arr_GetLocal
            view.delegate = self
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            present(view, animated: true)
        }else{
            self.Post_Review()
        }
    }
    @IBAction func btn_DeleteBox(_ sender : Any){
       
        
        let alert = UIAlertController(title: GlobalConstants.appName, message: "Are you sure want to delete this word?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            
            let subArr =  self.arrCards[0]
            var subArray1:[OCRSelectionObject] = []
            
             for i in (0..<Int(subArr.count)){
                if (sender as AnyObject).tag != i{
                    subArray1.append(subArr[i])
                }
            }
            self.arrCards[0] = subArray1
            if subArray1.count == 0{
                self.navigationController?.popViewController(animated: true)
            }
            self.collectionVw.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func btn_Speak(_ sender : Any){
        
        let arrSub = arrCards[0]
        let objCard = arrSub[(sender as AnyObject).tag]
        
//        playMusic(str_TraslationText : objCard.strCardNameTo,Language : objUser?.traslation_ToName ?? "en")
        playMusic(str_TraslationText : objCard.str_Title,Language : objUser?.traslation_FromName ?? "en")
        
    }
   
    
    // MARK: - Get/Post Method -
    func Get_CheckSaveOrNot(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)check_card"
        
        //make array for image comment
        let arr_Comment : NSMutableArray = []
        
        let arrSub = arrCards[0]
        for i in (0..<Int(arrSub.count)){
            let objCard = arrSub[i]
            
            //Create array for meaning
            var arr_Meaning : NSMutableArray = []
            for j in (0..<Int(objCard.arr_ConvertString.count)){
                let dict_Store : NSDictionary = [
                    "meaning" : objCard.arr_ConvertString[j],
                    ]
                arr_Meaning.add(dict_Store)
            }
            
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title),
                "meaning_array" : arr_Meaning,
                ]
            arr_Comment.add(dict_Store)
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
        ]
        
        jsonData.setValue(objUser?.traslation_ToID ?? "0", forKey: "to_language_id")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "check_card"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    func Post_Review(){
        
        indicatorShow()
        let when3 = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when3) {
            
            //Declaration URL
            let strURL = "\(GlobalConstants.BaseURL)add_card"
            
            //make array for image comment
            let arr_Comment : NSMutableArray = []
            let arr_Image : NSMutableArray = []
            let arr_ImageType : NSMutableArray = []
            let arr_ImageName : NSMutableArray = []
            
            let arrSub = self.arrCards[0]
            for i in (0..<Int(arrSub.count)){
                
                let objCard = arrSub[i]

                //Create array for meaning
                var arr_Meaning : NSMutableArray = []
                for j in (0..<Int(objCard.arr_ConvertString.count)){
                    let dict_Store : NSDictionary = [
                        "meaning" : objCard.arr_ConvertString[j],
                        ]
                    arr_Meaning.add(dict_Store)
                }
                
                //Save data in dictionary
                let dict_Store : NSDictionary = [
                    "word" : removeSpecialCharsFromString(text: objCard.str_Title),
                    "meaning_array" : arr_Meaning,
                    "is_replace" : objCard.str_CardID == "0" ? "0" : "1",
                    "card_id" : objCard.str_CardID,
                    ]
                arr_Comment.add(dict_Store)
                
    //            objCard.str_Image = GlobalConstants.img_Temp
                if objCard.data_Image != nil{
                    arr_Image.add(objCard.data_Image)
                    arr_ImageType.add("photo")
                    arr_ImageName.add("image\(i)")
                }else if objCard.str_Image != ""{
                    //Image save in array
                    let url = URL(string: objCard.str_Image as! String)
                    
                    let data = try? Data(contentsOf: url!)
                    
                    arr_Image.add(data)
                    arr_ImageType.add("photo")
                    arr_ImageName.add("image\(i)")
                }else{
                    arr_Image.add("")
                    arr_ImageType.add("")
                    arr_ImageName.add("")
                }
            }
            
            if arr_Comment.count != 0{
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
                    "store_type" : "1",
                ]
                
                jsonData.setValue(objUser?.traslation_ToID ?? "0", forKey: "to_language_id")
        //        jsonData.setValue(objUser?.traslation_DictionaryName ?? "0", forKey: "dictionary_id")
                
                indicatorHide()
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
            }
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




//MARK: - Collection View -
extension OCRresultview: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let subArr = arrCards[section]
        
        btn_SaveAll.isEnabled = true
        if subArr.count == 0{
            btn_SaveAll.isEnabled = false
        }
        return subArr.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return arrCards.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((GlobalConstants.windowWidth-20)/3), height: CGFloat(((GlobalConstants.windowWidth-20)/3) * 1.375))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView : UICollectionReusableView? = nil
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            let lblTitle: UILabel = headerView.viewWithTag(100) as! UILabel
            lblTitle.text = String(format:"Sub Category %d",indexPath.section+1)
            
            //Manage font
            lblTitle.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
            
            headerView.backgroundColor = UIColor.clear
            return headerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
        
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellVocablist", for: indexPath) as! AllWordsCell
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBarButton(_:)))
        
        let tapGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        tapGesture2.view?.tag = indexPath.row
        cell.addGestureRecognizer(tapGesture2)
        
//        cell.addGestureRecognizer(tapGesture)
        let arrSub = arrCards[indexPath.section]
        let objCard = arrSub[indexPath.row]
        
        let subArr =  arrCards[indexPath.section]
        let obj = subArr[indexPath.row]
//        if obj.isCardFront {
//            self.showHideOtherViews(cell , isShow: true)
//        }else {
            self.showHideOtherViews(cell , isShow: false)
//        }
        
        cell.imgVwWordPhoto.image = UIImage.init(named: (objCard.str_Image))
        cell.lblWord.text = objCard.str_Title
        cell.lblWordCenter.text = objCard.str_Title
        if objCard.arr_ConvertString.count != 0{
            cell.lblGoogleMeaning.text = objCard.arr_ConvertString[0] as! String
        }
//        cell.lblGoogleMeaning.text = objCard.strCardNameTo
        
        switch Int(objUser!.traslation_DictionaryName) {
        case 1?:
            cell.btnGoogle.setImage(UIImage(named:"icon_Dictionary1"), for: UIControlState.normal)
            break
        case 2?:
            cell.btnGoogle.setImage(UIImage(named:"icon_Dictionary2"), for: UIControlState.normal)
            if validationforLexinEnglishDictionaryShow() == true{
                cell.btnGoogle.setImage(UIImage(named:"icon_Dictionary2-1"), for: UIControlState.normal)
            }
            break
        case 3?:
            cell.btnGoogle.setImage(UIImage(named:"icon_Dictionary3"), for: UIControlState.normal)
            break
        default:
            break
        }
        
        if objCard.str_CardSaveFlag == "-1"{ // Not Saved
            cell.btn_Star.setImage(UIImage(named:"icon_SaveBlck"), for: UIControlState.normal)
        }else if objCard.str_CardSaveFlag == "0"{ //Personally Save
            cell.btn_Star.setImage(UIImage(named:"icon_SaveYello"), for: UIControlState.normal)
        }else if objCard.str_CardSaveFlag == "1"{ //All Saved
            cell.btn_Star.setImage(UIImage(named:"icon_SaveBlck_S"), for: UIControlState.normal)
        }
        
        //Manage font
        cell.lblWord.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        
        cell.btn_Close.tag = indexPath.row
        cell.btn_Close.addTarget(self, action:#selector(btn_DeleteBox(_:)), for: .touchUpInside)
        
        cell.btnSpeak.isHidden = true
        
        if objUser?.traslation_Play == "1"{
            cell.btnSpeak2.isUserInteractionEnabled = true
            cell.btnSpeak2.alpha = 1.0
        }else{
            cell.btnSpeak2.isUserInteractionEnabled = false
            cell.btnSpeak2.alpha = 0.3
        }

        cell.btnSpeak2.tag = indexPath.row
        cell.btnSpeak2.addTarget(self, action:#selector(btn_Speak(_:)), for: .touchUpInside)
        
        if obj.data_Image != nil{
            cell.imgVwWordPhoto.image = UIImage(data:obj.data_Image as! Data,scale:1.0)
        }else{
            //Manage Data with user
            cell.imgVwWordPhoto.sd_setImage(with: URL(string: (objCard.str_Image)), placeholderImage: UIImage(named:"img_PlaceHolderImage"))
        }
        
        //    self.showHideOtherViews(cell , isShow: !objCard.isCardFront)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //    self.performSegue(withIdentifier: "segueCardDetails", sender: self)
    }
}

extension OCRresultview: EmptyDataSetSource,EmptyDataSetDelegate {
    //  func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
    //    return UIImage.init(named: "img_Add")
    //  }
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var text: String?
        var font: UIFont?
        var textColor: UIColor?
        
        text = "No word for convert"
        font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 20))
        //    textColor = GlobalConstants.noDataColor
        textColor = UIColor.lightGray
        
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



extension OCRresultview : WebServiceHelperDelegate{
    
    
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "add_card"{
            self.navigationController?.popToRootViewController(animated: true)
        }else if strRequest == "check_card"{
            let responseData = response["response"] as! NSDictionary
            let arr_Traslation = responseData["keyword"] as! NSArray
            
            let subArr =  self.arrCards[0]
            var subArray1:[OCRSelectionObject] = []
            
            for count in 0..<arr_Traslation.count {
                let objCard = subArr[count]
                
                let dict_Result = arr_Traslation[count] as! NSDictionary
                
                objCard.str_CardSaveFlag = dict_Result.getStringForID(key : "is_saved")!
                objCard.str_CardID = dict_Result["card_id"]  as? String ?? ""
                
                var str_Cat : String = dict_Result["category_name"]  as? String ?? ""
                var str_SubCat : String = dict_Result["sub_category_name"]  as? String ?? ""
                if str_Cat != ""{
                    objCard.str_CatSave = "\(str_Cat)/\(str_SubCat)"
                }else{
                    objCard.str_CatSave = ""
                }
                
                objCard.str_Level = "3"
                
                subArray1.append(objCard)
            }
            self.arrCards[0] = subArray1
            
            collectionVw.isHidden = false
            collectionVw.reloadData()
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
 
        print(error)
    }
    
}


