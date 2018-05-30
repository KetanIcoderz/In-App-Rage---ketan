//
//  ReviewDetailViewController.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages


protocol DismissCardDetailDelegate: class {
    func ClickDismissCardDetailOption(obj: OCRSelectionObject)
}


class ReviewDetailViewController: UIViewController,DismissEditWordDelegate {
    @IBOutlet var txtWord : UITextField!
    @IBOutlet var txtWordFont : UITextField!
    
    @IBOutlet var lbl_MeaningTitle : UILabel!
    @IBOutlet var lbl_DatailTitleExample : UILabel!
    
    @IBOutlet var viewCard : UIView!
    @IBOutlet var viewFront : UIView!
    @IBOutlet var viewWordDetails : UIView!
    
    @IBOutlet var imgVwWord : UIImageView!
    
    @IBOutlet var btnVolume : UIButton!
    @IBOutlet var btnVolumeBig : UIButton!
    @IBOutlet var btnEditPhoto : UIButton!
    @IBOutlet var btn_MeaningLanguage : UIButton!
    @IBOutlet var btnDetailDictIcon : UIButton!
    @IBOutlet var btnCloseDialogImage : UIButton!
    @IBOutlet var btnEditWordImage : UIButton!
    @IBOutlet var btnEditImage : UIButton!
    
    @IBOutlet var tv_Example : UITextView!
    
    @IBOutlet var img_More : UIImageView!
    
    //Image Picker
    let picker = UIImagePickerController()
    
    var isShowCardAllDetails: Bool = false
    var longPressGesture = UILongPressGestureRecognizer()
    
    var objGet = OCRSelectionObject()
    
    weak var delegate :DismissCardDetailDelegate? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetup()
        
        self.fillData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : - Delegate Method -
    func ClickDismissEditWordOption(obj: OCRSelectionObject,Flag : String) {
        
        if Flag != ""{
            objGet = obj
            objGet.data_ImageData = nil
            self.fillData()
        }
    }
    
    //MARK : - Other Method -
    func viewSetup() {
        picker.delegate = self
        
        btnEditWordImage.isHidden = false
        btnEditImage.isHidden = false
        
        txtWord.isEnabled = false
        txtWordFont.isEnabled = false
        
        viewCard.backgroundColor = cardDefaultColor
        viewWordDetails.backgroundColor = cardDefaultColor
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBarButton(_:)))
//        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressEvent(_:)))
//        longPressGesture.isEnabled = false
//        viewCard.addGestureRecognizer(longPressGesture)
//        viewCard.addGestureRecognizer(tapGesture)

        self.showAndHideOtherViews(false)
        viewFront.isHidden = true
        viewWordDetails.isHidden = true
        btnEditPhoto.isUserInteractionEnabled = true
        btnEditPhoto.isHidden = false
        
        switch Int(objUser!.traslation_DictionaryName) {
        case 1?:
            btn_MeaningLanguage.setImage(UIImage(named:"icon_Dictionary1"), for: UIControlState.normal)
            btnDetailDictIcon.setImage(UIImage(named:"icon_Dictionary1"), for: UIControlState.normal)
            break
        case 2?:
            btn_MeaningLanguage.setImage(UIImage(named:"icon_Dictionary2"), for: UIControlState.normal)
            btnDetailDictIcon.setImage(UIImage(named:"icon_Dictionary2"), for: UIControlState.normal)
            if validationforLexinEnglishDictionaryShow() == true{
                btn_MeaningLanguage.setImage(UIImage(named:"icon_Dictionary2-1"), for: UIControlState.normal)
                btnDetailDictIcon.setImage(UIImage(named:"icon_Dictionary2-1"), for: UIControlState.normal)
            }
            break
        case 3?:
            btn_MeaningLanguage.setImage(UIImage(named:"icon_Dictionary3"), for: UIControlState.normal)
            btnDetailDictIcon.setImage(UIImage(named:"icon_Dictionary3"), for: UIControlState.normal)
            break
        default:
            break
        }
        
    }
    //MARK: - Gesture Method -
    @objc func tapBarButton(_ sender: UITapGestureRecognizer) {
        txtWord.isEnabled = false
        btnCloseDialogImage.isHidden = true
        btnEditWordImage.isHidden = true
        btnEditImage.isHidden = true
        if isShowCardAllDetails {
            isShowCardAllDetails = false
            UIView.transition(with: viewCard, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            self.showAndHideOtherViews(true)
            longPressGesture.isEnabled = false
            btnEditPhoto.isUserInteractionEnabled = false
        }else {
            isShowCardAllDetails = true
            UIView.transition(with: viewCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            longPressGesture.isEnabled = true
            btnEditPhoto.isUserInteractionEnabled = true
            self.showAndHideOtherViews(false)
        }
    }
    
    @objc func longPressEvent(_ sender: UILongPressGestureRecognizer) {
        txtWord.isEnabled = true
        btnCloseDialogImage.isHidden = false
        btnEditWordImage.isHidden = false
        btnEditImage.isHidden = false
        print("long preessssss")
    }
    
    // MARK: - Function -
    func showCameraOption() {
        self.picker.navigationBar.tintColor = UIColor.white
        let alert = UIAlertController(title: GlobalConstants.appName, message: "Select Photo Option", preferredStyle: UIAlertControllerStyle.actionSheet)
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
    func showAndHideOtherViews(_ isShow: Bool) {
        viewFront.isHidden = !isShow
        txtWord.isHidden = isShow
        btnEditPhoto.isHidden = isShow
        btn_MeaningLanguage.isHidden = isShow
        lbl_MeaningTitle.isHidden = isShow
        imgVwWord.isHidden = isShow
        btnVolume.isHidden = isShow
    }
    func fillData(){
        self.navigationItem.title = objGet.str_Title
        
        txtWord.text = objGet.str_Title
        txtWordFont.text = objGet.str_Title
        lbl_DatailTitleExample.text = objGet.str_convert
        if objGet.arr_ConvertString.count != 0{
            lbl_MeaningTitle.text = objGet.arr_ConvertString[0] as! String
        }
        tv_Example.text = objGet.str_Example
        
        if objGet.data_ImageData != nil{
            imgVwWord.image = UIImage(data:objGet.data_ImageData as! Data,scale:1.0)
        }else{
            //Manage Data with user
            imgVwWord.sd_setImage(with: URL(string: (objGet.str_Image as String)), placeholderImage: UIImage(named:"img_PlaceHolderImage"))
        }
        
        switch Int(objUser!.traslation_DictionaryName) {
        case 1?:
            btnDetailDictIcon.setImage(UIImage(named:"icon_Dictionary1"), for: UIControlState.normal)
            break
        case 2?:
            btnDetailDictIcon.setImage(UIImage(named:"icon_Dictionary2"), for: UIControlState.normal)
            break
        case 3?:
            btnDetailDictIcon.setImage(UIImage(named:"icon_Dictionary3"), for: UIControlState.normal)
            break
        default:
            break
        }
        
        //Sound Manage
        if objUser?.traslation_Play == "1"{
            btnVolume.alpha = 1.0
            btnVolumeBig.alpha = 1.0
        }else{
            btnVolume.alpha = 0.3
            btnVolumeBig.alpha = 0.3
        }
        
       
        
        
        img_More.isHidden = true
        if objUser?.traslation_DictionaryName == "2"  || objUser?.traslation_DictionaryName == "3"{
            //Manage detail or not
            let arr_1 : NSMutableArray = objGet.arr_Traslation[0] as? NSMutableArray ?? []
            let arr_2 : NSMutableArray = objGet.arr_Meaning[0] as? NSMutableArray ?? []
            let arr_3 : NSMutableArray = objGet.arr_Example[0] as? NSMutableArray ?? []
            let arr_4 : NSMutableArray = objGet.arr_Inflection[0] as? NSMutableArray ?? []
            let arr_5 : NSMutableArray = objGet.arr_Synonym[0] as? NSMutableArray ?? []
            let arr_6 : NSMutableArray = objGet.arr_AnotherWord[0] as? NSMutableArray ?? []
            
            if arr_1.count > 1 || arr_2.count > 0 || arr_3.count > 0 || arr_4.count > 0 || arr_5.count > 0 || arr_6.count > 0{
                img_More.isHidden = false
            }
        }
    }
    func getData(){
        objGet.str_Title = txtWord.text!
    }
    
    
    // MARK: - Button Event -
    @IBAction func editPhotoClick(_ sender: Any) {
        self.showCameraOption()
        //        toggleLeft()
    }
    @IBAction func backWordDetailsClick(_ sender: Any) {
        //        toggleLeft()
        viewWordDetails.isHidden = true
    }
    @IBAction func googleClick(_ sender: Any) {
        //        toggleLeft()
        viewWordDetails.isHidden = false
    }
    @IBAction func btn_MeaningLanguage(_ sender: Any) {
        if img_More.isHidden == false{
            if objUser?.traslation_DictionaryName == "2"  || objUser?.traslation_DictionaryName == "3"{
                
                //Manage detail or not
                let arr_1 : NSMutableArray = objGet.arr_Traslation[0] as? NSMutableArray ?? []
                let arr_2 : NSMutableArray = objGet.arr_Meaning[0] as? NSMutableArray ?? []
                let arr_3 : NSMutableArray = objGet.arr_Example[0] as? NSMutableArray ?? []
                let arr_4 : NSMutableArray = objGet.arr_Inflection[0] as? NSMutableArray ?? []
                let arr_5 : NSMutableArray = objGet.arr_Synonym[0] as? NSMutableArray ?? []
                let arr_6 : NSMutableArray = objGet.arr_AnotherWord[0] as? NSMutableArray ?? []
                
                let obj2 = OCRSelectionObject()
                obj2.arr_Traslation = arr_1
                obj2.arr_Meaning = arr_2
                obj2.arr_Example = arr_3
                obj2.arr_Inflection = arr_4
                obj2.arr_Synonym = arr_5
                obj2.arr_AnotherWord = arr_6
                if arr_1.count != 0{
                    obj2.str_Title = arr_1[0] as! String
                }else{
                    obj2.str_Title = ""
                }
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "ExamplePopUpViewController2") as! ExamplePopUpViewController2
                view.obj_Get = obj2
                view.modalPresentationStyle = .custom
                view.modalTransitionStyle = .crossDissolve
                self.present(view, animated: true)
                
            }
//            else{
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let view = storyboard.instantiateViewController(withIdentifier: "ExamplePopUpViewController") as! ExamplePopUpViewController
//                view.str_Title = objGet.str_Title
//                view.arr_Data = [objGet.str_convert,objGet.str_Example == "" ? "" :"Example",objGet.str_Example]
//                view.modalPresentationStyle = .custom
//                view.modalTransitionStyle = .crossDissolve
//                present(view, animated: true)
//            }
        }
//        viewWordDetails.isHidden = false
    }
    @IBAction func btn_Accept(_ sender: Any) {
        
    }
    @IBAction func btn_Reject(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_Cancel(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_Save(_ sender:Any){
        
        messageBar.MessageShow(title: "Card saved successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
        
        self.getData()
        self.delegate?.ClickDismissCardDetailOption(obj: self.objGet)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Delete(_ sender:Any){
        
        let alert = UIAlertController(title: GlobalConstants.appName, message: "Are you sure want to delete this card?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.objGet.str_IsDeleted = "1"
            
            messageBar.MessageShow(title: "Card deleted successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
            
            self.delegate?.ClickDismissCardDetailOption(obj: self.objGet)
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_SoundPlay(_ sender:Any){
        if objUser?.traslation_Play == "1"{
             playMusic(str_TraslationText : objGet.str_convert,Language : objUser?.traslation_FromName ?? "en")
        }
    }
    
    @IBAction func btn_Edit(_ sender:Any){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "EditWordViewController") as! EditWordViewController
        view.objGet = objGet
        view.str_Flag = String(0)
        view.delegate = self
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
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



extension ReviewDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtWordFont.text = textField.text
        
        textField.resignFirstResponder()
        return true
    }
    
    
}
extension ReviewDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        imgVwWord.image = pickedImage
        //    let objimgcls = objectImageClass()
        //    objimgcls.objimage = pickedImage!
        //    arySelectedDocument?.add(objimgcls)
        //
        //    ColViewDocument.reloadData()
        
        //Upload Images
        let imgData = UIImageJPEGRepresentation(pickedImage!, 0.75)
        objGet.data_ImageData = imgData as! NSData
        
        //
        //    //      let arr_ImageData : NSMutableArray = []
        //    arrMultipleImages.add(imgData as Any)
        //    //      arrMultipleImages = arr_ImageData
        //
        //    //Set array for image type
        //    //      let arr_ImageType : NSMutableArray = []
        //    arrDataType.add("photo")
        //    //      arrDataType = arr_ImageType
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
