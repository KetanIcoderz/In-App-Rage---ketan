//
//  ChangePasswordViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 11/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages

class ChangePasswordViewController: UIViewController {

    //tableview Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    //labelDeclaration
    @IBOutlet weak var lbl_Header: UILabel!
    
    //Declaration TextFiled
    @IBOutlet weak var tf_OldPassword: UITextField!
    @IBOutlet weak var tf_NewPassword: UITextField!
    @IBOutlet weak var tf_ConfirmPassword: UITextField!
    
    //Declaration TextField Image
    @IBOutlet weak var img_OldPassword: UIImageView!
    @IBOutlet weak var img_NewPassword: UIImageView!
    @IBOutlet weak var img_ConfirmPassord: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Other Files -
    func commanMethod(){
        tf_OldPassword.becomeFirstResponder()
        
        //Image hide show manage
        img_OldPassword.isHidden = true
        img_NewPassword.isHidden = true
        img_ConfirmPassord.isHidden = true
        
        tf_OldPassword.delegate = self
        tf_NewPassword.delegate = self
        tf_ConfirmPassword.delegate = self
        
        //Textfild Delegate
        tf_OldPassword.addTarget(self, action: #selector(textFieldAction(textField:)) , for: .editingDidEnd)
        tf_NewPassword.addTarget(self, action: #selector(textFieldAction(textField:)) , for: .editingDidEnd)
        tf_ConfirmPassword.addTarget(self, action: #selector(textFieldAction(textField:)) , for: .editingDidEnd)
        
        
    }

    
    @objc func textFieldAction(textField: UITextField){
        if textField == tf_OldPassword{
            
            img_OldPassword.isHidden = false
            img_OldPassword.image = UIImage(named : "img_RightEnter")
            
            if self.validationPassword(tf_Get : tf_OldPassword,condition : true) == false{
                img_OldPassword.image = UIImage(named : "img_WrongEnter")
            }
        }else if textField == tf_NewPassword{
            
            img_NewPassword.isHidden = false
            img_NewPassword.image = UIImage(named : "img_RightEnter")
            
            if self.validationPassword(tf_Get : tf_NewPassword,condition : true) == false{
                img_NewPassword.image = UIImage(named : "img_WrongEnter")
            }
        }else if textField == tf_ConfirmPassword{
            
            img_ConfirmPassord.isHidden = false
            img_ConfirmPassord.image = UIImage(named : "img_RightEnter")
            
            if self.validationPassword(tf_Get : tf_ConfirmPassword,condition : true) == false{
                img_ConfirmPassord.image = UIImage(named : "img_WrongEnter")
            }
        }
    }
    func validationForLogin(int_Value : Int){
        //Image hide show manage
        img_OldPassword.isHidden = true
        img_NewPassword.isHidden = true
        img_ConfirmPassord.isHidden = true
        
    }
    func validationPassword(tf_Get : UITextField,condition : Bool) -> Bool{
        
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
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_ChangePassword(_ sender:Any){
            
        //Image hide show manage
        img_OldPassword.isHidden = false
        img_NewPassword.isHidden = false
        img_ConfirmPassord.isHidden = false
        
        var boolPassword : Bool = true
        var boolPassword2 : Bool = true
        var boolPassword3 : Bool = true
        img_OldPassword.image = UIImage(named : "img_RightEnter")
        img_NewPassword.image = UIImage(named : "img_RightEnter")
        img_ConfirmPassord.image = UIImage(named : "img_RightEnter")
        
        
        if((tf_OldPassword.text?.isEmpty)! && GlobalConstants.developerTest == false){
            
            tf_OldPassword.becomeFirstResponder()
            messageBar.MessageShow(title: "Old password required", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            boolPassword = false
            img_OldPassword.image = UIImage(named : "img_WrongEnter")
            
        }else if self.validationPassword(tf_Get : tf_OldPassword,condition : true) == false && GlobalConstants.developerTest == false{
            //Alert show for Header
            messageBar.MessageShow(title: "Please enter valid old password", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            
            tf_OldPassword.becomeFirstResponder()
            boolPassword = false
            img_OldPassword.image = UIImage(named : "img_WrongEnter")
        }
        
        if((tf_NewPassword.text?.isEmpty)! && GlobalConstants.developerTest == false){
            
            if boolPassword == true {
                tf_NewPassword.becomeFirstResponder()
                messageBar.MessageShow(title: "New password required", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
            
            boolPassword2 = false
            img_NewPassword.image = UIImage(named : "img_WrongEnter")
            
        }else if self.validationPassword(tf_Get : tf_NewPassword,condition : true) == false && GlobalConstants.developerTest == false{
            if boolPassword == true {
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter valid new password", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                tf_NewPassword.becomeFirstResponder()
            }
            
            boolPassword2 = false
            img_NewPassword.image = UIImage(named : "img_WrongEnter")
        }
        
        if((tf_ConfirmPassword.text?.isEmpty)! && GlobalConstants.developerTest == false){
            
            if boolPassword == true && boolPassword2 == true {
                tf_ConfirmPassword.becomeFirstResponder()
                messageBar.MessageShow(title: "Confirm password required", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
            boolPassword3 = false
            img_ConfirmPassord.image = UIImage(named : "img_WrongEnter")
            
        }else if self.validationPassword(tf_Get : tf_ConfirmPassword,condition : true) == false && GlobalConstants.developerTest == false{
            if boolPassword == true && boolPassword2 == true {
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter valid Confirm password", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                
                tf_ConfirmPassword.becomeFirstResponder()
            }
            
            boolPassword3 = false
            img_ConfirmPassord.image = UIImage(named : "img_WrongEnter")
        }
        
        
        if boolPassword == true && boolPassword2 == true && boolPassword3 == true {
            if(tf_NewPassword.text == tf_ConfirmPassword.text){
                
                self.Post_ChangePassword()
                self.view.endEditing(true)
                
//                messageBar.MessageShow(title: "Change password successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
//                self.navigationController?.popViewController(animated: true)
            }else{
                messageBar.MessageShow(title: "Confirm password is not same as new password", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
        }
    }
    
    
    func Post_ChangePassword(){
                
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)change_password"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID as! String,
            "password" : tf_OldPassword.text ?? "",
            "password_current" : tf_NewPassword.text ?? "",
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "change_password"
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

//MARK: - UITextField Delegates -
extension ChangePasswordViewController : UITextFieldDelegate{
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        return true
        
    }
    private func textFieldShouldEndEditing(_ textField: UITextField) {
        if textField == tf_OldPassword{
            
            img_OldPassword.isHidden = false
            img_OldPassword.image = UIImage(named : "img_RightEnter")
            
            if self.validationPassword(tf_Get : tf_OldPassword,condition : true) == false{
                img_OldPassword.image = UIImage(named : "img_WrongEnter")
            }
        }else  if textField == tf_NewPassword{
            
            img_NewPassword.isHidden = false
            img_NewPassword.image = UIImage(named : "img_RightEnter")
            
            if self.validationPassword(tf_Get : tf_NewPassword,condition : true) == false{
                img_NewPassword.image = UIImage(named : "img_WrongEnter")
            }
        }else  if textField == tf_ConfirmPassword{
            
            img_ConfirmPassord.isHidden = false
            img_ConfirmPassord.image = UIImage(named : "img_RightEnter")
            
            if self.validationPassword(tf_Get : tf_ConfirmPassword,condition : true) == false{
                img_ConfirmPassord.image = UIImage(named : "img_WrongEnter")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        
         return false;
    }
}


extension ChangePasswordViewController : WebServiceHelperDelegate{
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "change_password" {

            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        
        //        self.completedServiceCalling()
        //        self.reloadData()
    }
}



