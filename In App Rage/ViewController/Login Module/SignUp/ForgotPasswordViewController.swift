//
//  ForgotPasswordViewController.swift
//  Minnaz
//
//  Created by Apple on 20/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var lblResetPassword: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendMailClick(_ sender: Any) {
        if validateEmail(enteredEmail: txtEmail.text!) {
            self.Post_ForgotPassword()
//          messageBar.MessageShow(title: "A temporary password has been sent to the email address. Please log in with the temporary password and change it to a password of your choice as soon as possible", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
//          self.dismiss(animated: true, completion: nil)
        }else {
           messageBar.MessageShow(title: "Please enter valid email address", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
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

    func Post_ForgotPassword(){
        
        //        print(UserDefaults.standard.value(forKey: "DeviceToken")!)
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)forgot_password"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "email" : txtEmail.text ?? "",
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "forgot_password"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = true
        webHelper.startDownload()
    }
    
}

extension ForgotPasswordViewController : WebServiceHelperDelegate{
    
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "forgot_password"  {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        
        //        self.completedServiceCalling()
        //        self.reloadData()
    }
}
