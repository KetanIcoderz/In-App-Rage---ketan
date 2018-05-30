//
//  SignInViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 13/11/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages
import LocalAuthentication
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController {

    //tableview Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    //Declaration TextFiled
    @IBOutlet weak var tf_Email: UITextField!
    @IBOutlet weak var tf_Password: UITextField!
    
    //Declaration Button
    @IBOutlet weak var btn_CreateAccount: UIButton!
    @IBOutlet weak var btn_ForgotPassowrd: UIButton!
    
    //Declaration label
    @IBOutlet weak var lbl_SignInButton: UILabel!
    @IBOutlet weak var lbl_FacebookButton: UILabel!
    @IBOutlet weak var lbl_GoogleButton: UILabel!
    
    //Declaration TextField Image
    @IBOutlet weak var img_Email: UIImageView!
    @IBOutlet weak var img_Password: UIImageView!
    
    @IBOutlet weak var con_HeaderAnimation: NSLayoutConstraint!
    @IBOutlet weak var con_LogoHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var vw_Detail: UIView!
    
    //Comman Declaration
    var isValidEmail : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        con_HeaderAnimation.constant = CGFloat(GlobalConstants.windowHeight)
        con_LogoHeight.constant = CGFloat(GlobalConstants.windowHeight * 0.1904047976)
        
        self.commanMethod()
        
        vw_Detail.isHidden = true
        let when3 = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when3) {
            
            if self.alredyLoginOrNot() == false{
                UIView.animate(withDuration: 1.0, animations: {
                    self.con_HeaderAnimation.constant = CGFloat(GlobalConstants.windowHeight * 0.4377811094)
                    
                    self.tbl_Main.layoutIfNeeded()
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    self.vw_Detail.isHidden = false
                })
            }else{
                self.con_HeaderAnimation.constant = CGFloat(GlobalConstants.windowHeight * 0.4377811094)
                self.tbl_Main.layoutIfNeeded()
                self.vw_Detail.isHidden = false
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tf_Email.text = ""
        tf_Password.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Other Files -
    func commanMethod(){
        
        //Textfiled placehodler color set
        tf_Email.attributedPlaceholder = NSAttributedString(string: "Email",
                                                            attributes: [NSAttributedStringKey.foregroundColor: GlobalConstants.appColor])
        tf_Password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedStringKey.foregroundColor: GlobalConstants.appColor])
        
        //Google
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = "65130673863-pt52tmq2urt0mi795k80mul35ffpu88d.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        //Image hide show manage
        img_Email.isHidden = true
        img_Password.isHidden = true
        
        //Table view header heigh set
        let vw : UIView = tbl_Main.tableHeaderView!
        if GlobalConstants.windowHeight == 812{
            vw.frame = CGRect(x: 0, y: 0, width: GlobalConstants.windowWidth, height:GlobalConstants.windowHeight-78)
        }else{
            vw.frame = CGRect(x: 0, y: 0, width: GlobalConstants.windowWidth, height:GlobalConstants.windowHeight-20)
        }
        tbl_Main.tableHeaderView = vw;
        
        //Manage font
        tf_Email.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        tf_Password.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        lbl_SignInButton.font = UIFont(name: GlobalConstants.kFontBold, size: manageFont(font: 22))
        lbl_FacebookButton.font = UIFont(name: GlobalConstants.kFontLight, size: manageFont(font: 17))
        lbl_GoogleButton.font = UIFont(name: GlobalConstants.kFontLight, size: manageFont(font: 17))
        
        btn_CreateAccount.titleLabel?.font =  UIFont(name: GlobalConstants.kFontLight, size: 16)
        btn_ForgotPassowrd.titleLabel?.font =  UIFont(name: GlobalConstants.kFontLight, size: 16)
        
    }
    func validationForLogin(int_Value : Int){
        //Image hide show manage
        img_Email.isHidden = true
        img_Password.isHidden = true
        
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
    func alredyLoginOrNot() -> Bool{
//        if ((loadCustomObject(withKey: "userobject")) != nil){
//            var objUserTemp : UserDataObject = loadCustomObject(withKey: "userobject")!
//
//            //Condition get data from userdefault
//            if objUserTemp.str_UserType.characters.count != 0 {
//
//                objUser = objUserTemp
//                manageTabBarandSideBar()
//                return true
//            }
//        }
        
        return false
    }
    

    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_SignIn(_ sender:Any) {
        
        //Image hide show manage
        img_Email.isHidden = false
        img_Password.isHidden = false
        
        var boolEmail : Bool = true
        var boolPassword : Bool = true
        img_Email.image = UIImage(named : "img_RightEnter")
        img_Password.image = UIImage(named : "img_RightEnter")
        
        if((tf_Email.text?.isEmpty)! && GlobalConstants.developerTest == false){
            //Alert show for Header
            messageBar.MessageShow(title: "Please enter email address", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            
            boolEmail = false
            img_Email.image = UIImage(named : "img_WrongEnter")
        }else if(isValidEmail ==  validateEmail(enteredEmail: tf_Email.text!) && GlobalConstants.developerTest == false){
            if isValidEmail == true {
                
            }else{
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter valid email address", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                
                boolEmail = false
                img_Email.image = UIImage(named : "img_WrongEnter")
            }
        }
        
        if boolEmail == true{
            
            if((tf_Password.text?.isEmpty)! && GlobalConstants.developerTest == false){
                
                messageBar.MessageShow(title: "Please enter password", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                boolPassword = false
                img_Password.image = UIImage(named : "img_WrongEnter")
                
            }else if self.validationPassword(tf_Get : tf_Password,condition : true) == false && GlobalConstants.developerTest == false{
                //Alert show for Header
                messageBar.MessageShow(title: "Please enter password with 1 Capital,1 Number,8 minimum characters", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                
                boolPassword = false
                img_Password.image = UIImage(named : "img_WrongEnter")
            }
            
        }else{
            img_Password.image = UIImage(named : "img_WrongEnter")
        }
        
        if boolEmail == true && boolPassword == true{
            self.view.endEditing(true)

//            if ((loadCustomObject(withKey: "userobject")) != nil){
//                
//                var objUserTemp : UserDataObject = loadCustomObject(withKey: "userobject")!
//    
//                //Condition get data from userdefault
//                if objUserTemp.str_UserType.characters.count != 0 {
//    
//                    objUser = objUserTemp
//                }
//            }else{
//                objUser = UserDataObject()
//                objUser?.user_Type = "0"
//                saveCustomObject(objUser!, key: "userobject");
//            }
            
            self.Post_Login()
//            manageTabBarandSideBar()
            
        }
    }
    
    @IBAction func btn_FB(_ sender:Any) {
      
        let login = FBSDKLoginManager()
        login.logOut()
        //ESSENTIAL LINE OF CODE
        login.loginBehavior = FBSDKLoginBehavior.browser

        login.logIn(withReadPermissions: ["public_profile","email", "user_friends"], handler: { (result, error) -> Void in

            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!

                if(fbloginresult.isCancelled) {
                    //Show Cancel alert
                } else {

                    if (FBSDKAccessToken.current() != nil) {
                        indicatorShow()

                        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email,first_name,last_name,id,picture.type(large), age_range"]).start(completionHandler: { (connection, result, error) -> Void in
                            if (error == nil){
                                print(result ?? 0)
                                let dict_Data : NSDictionary = result as! NSDictionary
                                let dictPicture : NSDictionary = dict_Data["picture"] as! NSDictionary
                                let dictPictureSub : NSDictionary = dictPicture["data"] as! NSDictionary

                                let dict_Dave : Dictionary = ["email" : ((dict_Data["email"] as? String) != nil) ? (dict_Data["email"] as? String) : "",
                                                              "firstname" : ((dict_Data["first_name"] as? String) != nil) ? (dict_Data["first_name"] as? String) : "",
                                                              "lastname" : ((dict_Data["last_name"] as? String) != nil) ? (dict_Data["last_name"] as? String) : "",
                                                              "id" : ((dict_Data["id"] as? String) != nil) ? (dict_Data["id"] as? String) : "",
                                                              "image" : ((dictPictureSub["url"] as? String) != nil) ? (dictPictureSub["url"] as? String) : "",
                                                              "zip" : ((dict_Data["zip"] as? String) != nil) ? (dict_Data["zip"] as? String) : ""]

                                self.Post_FBGmail(flag: "FB", NSDictionary: dict_Dave as NSDictionary)
//                                  indicatorHide()
//                                  manageTabBarandSideBar()

                            }else{
//                                messageBar.MessageShow(title: (error?.localizedDescription)! as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                                indicatorHide()
                            }

                        })
                    }
                }
            }else{
//                messageBar.MessageShow(title: (error?.localizedDescription)! as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
        })
    }
    @IBAction func btn_Google(_ sender:Any){
          
        GIDSignIn.sharedInstance().signIn()
    }
    
    // MARK: - Get/Post Method -
    func Post_FBGmail(flag : String , NSDictionary : NSDictionary){
        
        if NSDictionary["email"] as! String == "" {
            messageBar.MessageShow(title:"We not getting your email address with login. Please try login with use of another id.", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }else{
            
            let url = URL(string: NSDictionary["image"] as! String)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let image_Save : UIImage = UIImage(data: data!)!
            
            //Declaration URL
            let strURL = "\(GlobalConstants.BaseURL)sign_up"
            
            //Pass data in dictionary
            var jsonData : NSDictionary =  NSDictionary
            jsonData = [
                "name" : NSDictionary["firstname"] as! String,
                "email" : NSDictionary["email"] as! String,
                "account_type" :  flag,
                "social_id" :  NSDictionary["id"] as! String,
                "password" : "",
                "devicetoken" :  UserDefaults.standard.value(forKey: "DeviceToken") == nil ? "123" : UserDefaults.standard.value(forKey: "DeviceToken")! as! String,
                "devicetype" : "I",
            ]
            
            
            //Create object for webservicehelper and start to call method
            let webHelper = WebServiceHelper()
            webHelper.strMethodName = "sign_up"
            webHelper.methodType = "post"
            webHelper.strURL = strURL
            webHelper.dictType = jsonData as NSDictionary
            webHelper.dictHeader = NSDictionary
            webHelper.delegateWeb = self
            webHelper.serviceWithAlert = true
            webHelper.imageUpload = (image_Save != nil) ? (image_Save) : (UIImage())
            webHelper.imageUploadName = "image"
            webHelper.startDownloadWithImage()
        }
    }
    
    func Post_Login(){
        
//        print(UserDefaults.standard.value(forKey: "DeviceToken")!)
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)login"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "email" : tf_Email.text ?? "",
            "password" : tf_Password.text ?? "",
            "devicetoken" :  UserDefaults.standard.value(forKey: "DeviceToken") == nil ? "123" : UserDefaults.standard.value(forKey: "DeviceToken")! as! String,
            "devicetype" : "I",
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "login"
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
extension SignInViewController : UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tf_Email{
            
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
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        return true;
    }
}

//MARK: - Google Delegates -
extension SignInViewController : GIDSignInUIDelegate,GIDSignInDelegate{
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let dimension = round(100 * UIScreen.main.scale);
            let pic = user.profile.imageURL(withDimension: UInt(dimension))
            // let path : String! = "\(pic!.path)"
            let path : NSString = pic!.absoluteString as NSString
            
            
            let dict_Dave : Dictionary = ["email" : user.profile.email ,
                                          "firstname" : user.profile.name,
                                          "lastname" : "" ,
                                          "id" : user.userID ,
                                          "image" : path,
                                          "zip" : "" ] as [String : Any]
            
//            manageTabBarandSideBar()
            self.Post_FBGmail(flag: "Gplus", NSDictionary: dict_Dave as NSDictionary)
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func signInWillDispatch(signIn: GIDSignIn!, error: Error!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension SignInViewController : WebServiceHelperDelegate{
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "sign_up" || strRequest == "login" {
            
            userObjectUpdate(dict_Get : response)

            manageTabBarandSideBar()
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        
        //        self.completedServiceCalling()
        //        self.reloadData()
    }
}


