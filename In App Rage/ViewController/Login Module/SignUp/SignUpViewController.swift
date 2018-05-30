//
//  SignUpViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 14/11/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages

class SignUpViewController: UIViewController, UINavigationControllerDelegate {

    //tableview Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    //labelDeclaration
    @IBOutlet weak var lbl_Header: UILabel!
    
    //Declaration TextFiled
    @IBOutlet weak var tf_Name: UITextField!
    @IBOutlet weak var tf_Email: UITextField!
    @IBOutlet weak var tf_Password: UITextField!
    @IBOutlet weak var tf_ConfirmPassword: UITextField!
//    @IBOutlet weak var tf_PhoneNo: UITextField!
  
    //Declaration TextField Image
    @IBOutlet weak var img_Name: UIImageView!
    @IBOutlet weak var img_Email: UIImageView!
    @IBOutlet weak var img_Password: UIImageView!
    @IBOutlet weak var img_ConfirmPassord: UIImageView!
//    @IBOutlet weak var img_PhoneNo: UIImageView!
  
    @IBOutlet weak var img_ProfileSelected: UIImageView!
    
    //Button Declaration
    @IBOutlet weak var btn_Confirm: UIButton!
    
    //Comman Declaration
    var isValidEmail : Bool = false
    let picker = UIImagePickerController()
    var isEditMode : Bool = false
    var isImage :Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.commanMethod()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Other Files -
    func commanMethod(){
        
        //Image Picker view
        picker.delegate = self
        
        //Image hide show manage
        img_Name.isHidden = true
        img_Email.isHidden = true
        img_Password.isHidden = true
        img_ConfirmPassord.isHidden = true
      
        //Table view header heigh set
        let vw : UIView = tbl_Main.tableHeaderView!
        vw.frame = CGRect(x: 0, y: 0, width: GlobalConstants.windowWidth, height:GlobalConstants.windowHeight*0.35)
        tbl_Main.tableHeaderView = vw;
        
        if isEditMode == true{
            tf_Email.isUserInteractionEnabled = false
            tf_Password.isUserInteractionEnabled = false
            tf_ConfirmPassword.isUserInteractionEnabled = false
            
            img_ProfileSelected.sd_setImage(with: URL(string: (objUser?.user_Image)!), placeholderImage: UIImage())
            
            tf_Name.text = objUser?.user_Name
            tf_Email.text = objUser?.user_Email
            tf_Password.text = "Ketan123"
            tf_ConfirmPassword.text = "Ketan123"
            
            lbl_Header.text = "Update Account"
            btn_Confirm .setTitle("Update", for: UIControlState.normal)
        }else{
            lbl_Header.text = "Create Account"
            btn_Confirm .setTitle("Registration", for: UIControlState.normal)
        }
        
        //Manage font
        tf_Name.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        tf_Email.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        tf_Password.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        tf_ConfirmPassword.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        
        btn_Confirm.titleLabel?.font =  UIFont(name: GlobalConstants.kFontBold, size: 22)
        
    }
    func validationForLogin(int_Value : Int){
        //Image hide show manage
        img_Name.isHidden = true
        img_Email.isHidden = true
        img_Password.isHidden = true
        img_ConfirmPassord.isHidden = true
    }
    func validationPassword(tf_Get : UITextField,condition : Bool) -> Bool {
        
        //Validation for 1 Capital 1 Number value and 8 Length
        var validation : Int = 0
        
        //1 8 character Validatiaon
        if (tf_Get.text!.characters.count >= 8) {
            validation = validation + 1;
        }
        
        //2 capital letter or not
        var output = ""
        let string : String = tf_Get.text!
        for chr in string.characters {
            let str = String(chr)
            if str.lowercased() != str {
                output += str
            }
        }
        if output != "" {
            validation = validation + 1
        }
        
        //3 Number
        let str = tf_Get.text!
        let intString = str.components(
            separatedBy: NSCharacterSet
                .decimalDigits
                .inverted)
            .joined(separator: "")
        if intString != "" {
            validation = validation + 1
        }
        
        if validation > 2 {
            return true
        }
        return false
    }
    
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_SignUp(_ sender:Any) {
        //Image hide show manage
        img_Name.isHidden = true
        img_Email.isHidden = true
        img_Password.isHidden = true
        img_ConfirmPassord.isHidden = true
      
        var bool_Step : Bool = true
        img_Name.image = UIImage(named : "img_RightEnter")
        img_Email.image = UIImage(named : "img_RightEnter")
        img_Password.image = UIImage(named : "img_RightEnter")
        img_ConfirmPassord.image = UIImage(named : "img_RightEnter")
      
        if isEditMode == false{
            if((tf_Name.text?.isEmpty)! && GlobalConstants.developerTest == false) {
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter name", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                
                bool_Step = false
                img_Name.isHidden = false
                img_Name.image = UIImage(named : "img_WrongEnter")
                
            }
            
            if((tf_Email.text?.isEmpty)! && GlobalConstants.developerTest == false && bool_Step == true){
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter email address", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                
                bool_Step = false
                img_Email.isHidden = false
                img_Email.image = UIImage(named : "img_WrongEnter")
                
            }
            
            if(isValidEmail ==  validateEmail(enteredEmail: tf_Email.text!) && GlobalConstants.developerTest == false && bool_Step == true){
                if isValidEmail == true {
                    
                }else{
                    //Alert show for Header
                    messageBar.MessageShow(title: "Please enter valid email address", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                    
                    bool_Step = false
                    img_Email.isHidden = false
                    img_Email.image = UIImage(named : "img_WrongEnter")
                }
            }
            
            if((tf_Password.text?.isEmpty)! && GlobalConstants.developerTest == false && bool_Step == true){
                
                messageBar.MessageShow(title: "Please enter password", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                bool_Step = false
                img_Password.isHidden = false
                img_Password.image = UIImage(named : "img_WrongEnter")
                
            }
            
            if self.validationPassword(tf_Get : tf_Password,condition : true) == false && GlobalConstants.developerTest == false && bool_Step == true{
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter password with 1 Capital,1 Number,8 minimum characters", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                
                bool_Step = false
                img_Password.isHidden = false
                img_Password.image = UIImage(named : "img_WrongEnter")
            }
            
            if((tf_ConfirmPassword.text?.isEmpty)! && GlobalConstants.developerTest == false && bool_Step == true){
                
                messageBar.MessageShow(title: "Please enter confirm password", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                bool_Step = false
                img_ConfirmPassord.isHidden = false
                img_ConfirmPassord.image = UIImage(named : "img_WrongEnter")
                
            }
            
            if self.validationPassword(tf_Get : tf_ConfirmPassword,condition : true) == false && GlobalConstants.developerTest == false && bool_Step == true{
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter confirm password with 1 Capital,1 Number,8 minimum characters", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                
                bool_Step = false
                img_ConfirmPassord.isHidden = false
                img_ConfirmPassord.image = UIImage(named : "img_WrongEnter")
            }
            
            if(tf_Password.text != tf_ConfirmPassword.text && GlobalConstants.developerTest == false && bool_Step == true){
                
                messageBar.MessageShow(title: "Password and confirm password not matched", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                bool_Step = false
                img_ConfirmPassord.isHidden = false
                img_ConfirmPassord.image = UIImage(named : "img_WrongEnter")
            }
            
            if bool_Step == true{
                self.view.endEditing(true)
                
//                messageBar.MessageShow(title: "Signup successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
//                
//                objUser = UserDataObject()
//                objUser?.user_Type = "0"
//                saveCustomObject(objUser!, key: "userobject");
                
                self.Post_Reistration()
            }
        }else{
            if((tf_Name.text?.isEmpty)! && GlobalConstants.developerTest == false) {
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter name", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                
                bool_Step = false
                img_Name.isHidden = false
                img_Name.image = UIImage(named : "img_WrongEnter")
                
            }else{
                self.PostEditProfile()
                
//                messageBar.MessageShow(title: "Edit profile successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
//
//                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBAction func btn_ChangeProfilePic(_ sender:Any){
        let alert = UIAlertController(title: GlobalConstants.appName, message: "Select Photo Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                self.picker.sourceType = .camera
                self.picker.allowsEditing = true
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
    @IBAction func btn_SignIn(_ sender:Any){
         self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Get/Post Method -
    func Post_Reistration(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)sign_up"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "name" : tf_Name.text ?? "",
            "email" : tf_Email.text ?? "",
            "account_type" :  "Email",
            "social_id" : "",
            "password" : tf_Password.text ?? "",
            "devicetoken" :  UserDefaults.standard.value(forKey: "DeviceToken") == nil ? "123" : UserDefaults.standard.value(forKey: "DeviceToken")! as! String,
            "devicetype" : "I",
        ]
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "sign_up"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData as NSDictionary
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = true
        webHelper.imageUpload = (isImage == true) ? (img_ProfileSelected.image) : (UIImage())
        webHelper.imageUploadName = "image"
        webHelper.startDownloadWithImage()
    }

    func PostEditProfile(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)update_profile"

        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "name" : tf_Name.text ?? "",
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "update_profile"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData as NSDictionary
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = true
        webHelper.imageUpload = (isImage == true) ? (img_ProfileSelected.image) : (UIImage())
        webHelper.imageUploadName = "image"
        webHelper.startDownloadWithImage()
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
extension SignUpViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tf_Name{
            
            //Image hide show manage
            img_Name.isHidden = false
            
            img_Name.image = UIImage(named : "img_RightEnter")
            
            if((tf_Name.text?.isEmpty)! && GlobalConstants.developerTest == false){
                
                img_Name.image = UIImage(named : "img_WrongEnter")
            }
        }else if textField == tf_Email{
            
            //Image hide show manage
            img_Email.isHidden = false
            
            img_Email.image = UIImage(named : "img_RightEnter")
            
            if((tf_Email.text?.isEmpty)! && GlobalConstants.developerTest == false){
                
                img_Email.image = UIImage(named : "img_WrongEnter")
            }else if(isValidEmail ==  validateEmail(enteredEmail: tf_Email.text!) && GlobalConstants.developerTest == false){
                if isValidEmail == true {
                    
                }else{
                    
                    img_Email.image = UIImage(named : "img_WrongEnter")
                }
            }
        }else if textField == tf_Password{
            
            img_Password.isHidden = false
            img_Password.image = UIImage(named : "img_RightEnter")
            
            if self.validationPassword(tf_Get : tf_Password,condition : true) == false{
                img_Password.image = UIImage(named : "img_WrongEnter")
            }
        }else if textField == tf_ConfirmPassword{
            
            img_ConfirmPassord.isHidden = false
            img_ConfirmPassord.image = UIImage(named : "img_RightEnter")
            
            if self.validationPassword(tf_Get : tf_ConfirmPassword,condition : true) == false{
                img_ConfirmPassord.image = UIImage(named : "img_WrongEnter")
            }
        }
//        else if textField == tf_PhoneNo{
//
//            img_PhoneNo.isHidden = false
//            img_PhoneNo.image = UIImage(named : "img_RightEnter")
//
//            if (tf_PhoneNo.text!.characters.count < 10 && GlobalConstants.developerTest == false){
//                img_PhoneNo.image = UIImage(named : "img_WrongEnter")
//            }
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        return true;
    }
}


extension SignUpViewController : UIImagePickerControllerDelegate{
    //MARK: - Imagepicker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        isImage = true
        img_ProfileSelected.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


extension SignUpViewController : WebServiceHelperDelegate{
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
                
        let response = data as! NSDictionary
        if strRequest == "sign_up" {
            
            userObjectUpdate(dict_Get : response)
            
//            let dict_result = response["user_detail"] as! NSDictionary
//
//            //Store data in object
//            let obj = UserDataObject(user_UserID : String(dict_result["user_id"] as! Int),
//                                     user_Name : dict_result["name"]  as? String ?? "",
//                                     user_Email : dict_result["email"]  as? String ?? "",
//                                     user_Image : dict_result["image"]  as? String ?? "",
//                                     user_Type : dict_result["user_type"]  as? String ?? "",
//                                     user_AccountType : dict_result["account_type"]  as? String ?? "",
//                                     user_Socialid : dict_result["social_id"]  as? String ?? "",
//                                     user_isActive : dict_result["is_active"]  as? String ?? "",
//                                     user_SchoolName : "",
//                                     traslation_DictionaryName : dict_result["selected_dictionary"]  as? String ?? "",
//                                     traslation_ToName : "",
//                                     traslation_ToID : "",
//                                     traslation_FromName : "",
//                                     traslation_FromId : "")
//
//            //Manage dictionary
//            let arr_Dictonary = response["Dictionary"] as! NSArray
//            let dict_Dictonary = arr_Dictonary[Int(dict_result["selected_dictionary"]  as? String ?? "0")! - 1] as! NSDictionary
//            let arr_From = dict_Dictonary["From_languages"] as! NSArray
//            let arr_To = dict_Dictonary["To_languages"] as! NSArray
//            if arr_From.count != 0{
//                //From Lanaguage
//                let dict_FromDictonary = arr_From[0] as! NSDictionary
//
//                obj.traslation_FromName = dict_FromDictonary["abbrivation"] as! String
//                obj.traslation_FromId = String(dict_FromDictonary["language_id"] as! Int)
//
//                //To Lanaguage
//                let dict_ToDictonary = arr_To[0] as! NSDictionary
//
//                obj.traslation_ToName = dict_ToDictonary["abbrivation"] as! String
//                obj.traslation_ToID = String(dict_ToDictonary["language_id"] as! Int)
//            }
//
//            saveCustomObject(obj, key: "userobject");
//
//            //Save Object In global variable
//            objUser = obj
            
            manageTabBarandSideBar()
        }else if strRequest == "update_profile" {
            
            userObjectUpdate(dict_Get : response)
            
//            let dict_result = response["user_detail"] as! NSDictionary
//
//            //Store data in object
//            let obj = UserDataObject(user_UserID : String(dict_result["user_id"] as! Int),
//                                     user_Name : dict_result["name"]  as? String ?? "",
//                                     user_Email : dict_result["email"]  as? String ?? "",
//                                     user_Image : dict_result["image"]  as? String ?? "",
//                                     user_Type : dict_result["user_type"]  as? String ?? "",
//                                     user_AccountType : dict_result["account_type"]  as? String ?? "",
//                                     user_Socialid : dict_result["social_id"]  as? String ?? "",
//                                     user_isActive : dict_result["is_active"]  as? String ?? "",
//                                     user_SchoolName : "",
//                                     traslation_DictionaryName : dict_result["selected_dictionary"]  as? String ?? "",
//                                     traslation_ToName : "",
//                                     traslation_ToID : "",
//                                     traslation_FromName : "",
//                                     traslation_FromId : "")
//
//            //Manage dictionary
//            let arr_Dictonary = response["Dictionary"] as! NSArray
//            let dict_Dictonary = arr_Dictonary[Int(dict_result["selected_dictionary"]  as? String ?? "0")! - 1] as! NSDictionary
//            let arr_From = dict_Dictonary["From_languages"] as! NSArray
//            let arr_To = dict_Dictonary["To_languages"] as! NSArray
//            if arr_From.count != 0{
//                //From Lanaguage
//                let dict_FromDictonary = arr_From[0] as! NSDictionary
//
//                obj.traslation_FromName = dict_FromDictonary["abbrivation"] as! String
//                obj.traslation_FromId = String(dict_FromDictonary["language_id"] as! Int)
//
//                //To Lanaguage
//                let dict_ToDictonary = arr_To[0] as! NSDictionary
//
//                obj.traslation_ToName = dict_ToDictonary["abbrivation"] as! String
//                obj.traslation_ToID = String(dict_ToDictonary["language_id"] as! Int)
//            }
//
//            saveCustomObject(obj, key: "userobject");
//
//            //Save Object In global variable
//            objUser = obj
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        
//        self.completedServiceCalling()
//        self.reloadData()
    }
}


