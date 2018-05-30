//
//  LeftMenuSchoolViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 13/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages

class LeftMenuSchoolViewController: UIViewController {

    //Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
     var menus: [[String: String]] = [["name":"Profile","image":"1"],["name":"My Schedule","image":"2"],["name":"My Files","image":"3"],["name":"Feedback to School","image":"5"],["name":"Sign out from school","image":"8"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        toggleLeft()
    }
    
    
    // MARK: - Get/Post Method -
    func Post_RegistrationWithSutdent(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)logout_as_student"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "logout_as_student"
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

// MARK: - Tableview Delegate -

extension LeftMenuSchoolViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell", for:indexPath as IndexPath) as! LeftMenuCell
        
        //Declare text in icon in tableview cell
        cell.lblTitle.text = menus[indexPath.row]["name"]
        cell.imgLogo.image = UIImage(named:menus[indexPath.row]["image"]!)!
        cell.btnSwitch.isHidden = true
        
        cell.btnSwitch.addTarget(self, action:#selector(handleRegister), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
//            let view = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
//            view.bool_SchoolProfile = true
//            self.navigationController?.pushViewController(view, animated: true)
            
            self.performSegue(withIdentifier: "profile", sender: self)
        }else if indexPath.row == 1{
            
            self.performSegue(withIdentifier: "segueShowCalendar", sender: self)
            
        }else if indexPath.row == 2{
         
            self.performSegue(withIdentifier: "allfIles", sender: self)
        }else if indexPath.row == 3{
            //Feedback View
            let view = self.storyboard?.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
            view.bool_Nav = true
            self.navigationController?.pushViewController(view, animated: true)
        }else if indexPath.row == 4{
            let alert = UIAlertController(title: GlobalConstants.appName, message: "Are you sure you want to sign out from your school?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in

                self.Post_RegistrationWithSutdent()
                
//                //Alert show for Header
//                messageBar.MessageShow(title: "Sign out successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
//
//                objUser?.user_Type = "0"
//                saveCustomObject(objUser!, key: "userobject");
//
//                manageTabBarandSideBar()
                
//                self.btn_NavigationLeft(self)
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func handleRegister(sender: UIButton){
        sender.isSelected = !sender.isSelected
        //...
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tbl_Main == scrollView {
            
        }
    }
    
}


extension LeftMenuSchoolViewController : WebServiceHelperDelegate{
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        if strRequest == "logout_as_student"{
            
            //Alert show for Header
            messageBar.MessageShow(title: "Sign out successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
            
            objUser?.user_Type = "0"
            saveCustomObject(objUser!, key: "userobject");
            
            manageTabBarandSideBar()
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        print(error)
    }
    
}



