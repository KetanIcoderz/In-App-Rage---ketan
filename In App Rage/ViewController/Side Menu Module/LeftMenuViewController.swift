//
//  LeftMenuViewController.swift
//  HealthyBlackMen
//
//  Created by      on 5/4/17.
//  Copyright © 2017   . All rights reserved.
//

import UIKit
//import SlideMenuControllerSwift
import SwiftMessages
import SDWebImage

enum LeftMenu: Int {
    case home = 0
    case setting
    case logout
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftMenuCell : UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var btnSwitch: UIButton!
}

class LeftMenuViewController : UIViewController, LeftMenuProtocol , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    //Declaration
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex: Int = -1;
    var selectedColorIndex: Int = -1
    
    //Declaration Images
    @IBOutlet weak var img_ProfileSub: UIImageView!
    @IBOutlet weak var img_Profile: UIImageView!
    var arrColor:[UIColor] = []

    //
    @IBOutlet weak var viewSetGoal: UIView!
    @IBOutlet weak var viewSetColor: UIView!
    @IBOutlet weak var viewSelectSchool: UIView!
    //Manage array for ExskuderMenu controller
    
    var menus: [[String: String]] = [["name":"Profile","image":"1"],["name":"Change Flashcard Color","image":"2"],["name":"Set Goal","image":"3"],["name":"Notifications","image":"4"],["name":"Feedback","image":"5"],["name":"Register As Student","image":"6"],["name":"External Access","image":"7"],["name":"Sign Out","image":"8"]]
    
    //Label Declaration
    @IBOutlet var lbl_Name : UILabel!
    @IBOutlet var lbl_HashTag : UILabel!
    
    //Alloc init viewcontroller
    var TabBarViewController: UIViewController!
    var SettingsViewController: UIViewController!
    var FeedBackViewController: UIViewController!
    var LeftMenuSchoolViewController: UIViewController!
    
    //Declare Sidebar controller
    var leftMenuSize = SlideMenuOptions.leftViewWidth
    var size : SlideMenuController = SlideMenuController()
    
    //View Manage
    @IBOutlet var vw_Profile : UIView!
    
    //Constant ste
    @IBOutlet var con_vw_Top : NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Editing ModeaDecoder
        if objUser?.user_Type == "0"{
            menus = [["name":"Profile","image":"1"],["name":"Change Flashcard Color","image":"2"],["name":"Set Goal","image":"3"],["name":"Notifications","image":"4"],["name":"Feedback","image":"5"],["name":"Register As Student","image":"6"],["name":"External Access","image":"7"],["name":"Sign Out","image":"8"]]
        }else{
            menus = [["name":"Profile","image":"1"],["name":"Change Flashcard Color","image":"2"],["name":"Set Goal","image":"3"],["name":"Notifications","image":"4"],["name":"Feedback","image":"5"],["name":"My School","image":"6"],["name":"External Access","image":"7"],["name":"Sign Out","image":"8"]]
        }
        
        vw_BaseView = self
    
        //Declaration number of view added in left view contoller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //1. Home controller
        let TabBarViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.TabBarViewController = UINavigationController(rootViewController: TabBarViewController)
        
        //2. Setting Controller
        let SettingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.SettingsViewController = UINavigationController(rootViewController: SettingsViewController)
         self.commanMethod()
        
        //3. FeedBack controller
        let FeedBackViewController = storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
        self.FeedBackViewController = UINavigationController(rootViewController: FeedBackViewController)
        
        //3. Student Left controller
        let LeftMenuSchoolViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuSchoolViewController") as! LeftMenuSchoolViewController
        self.LeftMenuSchoolViewController = UINavigationController(rootViewController: LeftMenuSchoolViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        //Reload data
        self.reloadViewData()
        tableView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Other Files -
    //Method for change view with other screen calling
  func commanMethod() {
    arrColor.append(UIColor(red: 0/255, green: 201/255, blue: 55/255, alpha: 1.0))
    arrColor.append(UIColor(red: 76/255, green: 131/255, blue: 253/255, alpha: 1.0))
    arrColor.append(UIColor(red: 164/255, green: 83/255, blue: 251/255, alpha: 1.0))
    arrColor.append(UIColor(red: 249/255, green: 70/255, blue: 179/255, alpha: 1.0))
    arrColor.append(UIColor(red: 188/255, green: 180/255, blue: 2/255, alpha: 1.0))
    arrColor.append(UIColor(red: 242/255, green: 249/255, blue: 56/255, alpha: 1.0))
    arrColor.append(UIColor(red: 178/255, green: 236/255, blue: 2/255, alpha: 1.0))
    arrColor.append(UIColor(red: 51/255, green: 255/255, blue: 180/255, alpha: 1.0))
    arrColor.append(UIColor(red: 43/255, green: 255/255, blue: 43/255, alpha: 1.0))
    arrColor.append(UIColor(red: 255/255, green: 210/255, blue: 3/255, alpha: 1.0))
    arrColor.append(UIColor(red: 255/255, green: 164/255, blue: 2/255, alpha: 1.0))
    arrColor.append(UIColor(red: 255/255, green: 174/255, blue: 87/255, alpha: 1.0))
    arrColor.append(UIColor(red: 255/255, green: 73/255, blue: 1/255, alpha: 1.0))
    arrColor.append(UIColor(red: 151/255, green: 123/255, blue: 182/255, alpha: 1.0))
    arrColor.append(UIColor(red: 242/255, green: 143/255, blue: 185/255, alpha: 1.0))
  }
    func callmethod(_int_Value : Int) {
        switch _int_Value {
        case 0:
             self.slideMenuController()?.changeMainViewController(self.SettingsViewController, close: true)
            break
        case 1:
              viewSetColor.isHidden = !viewSetColor.isHidden
          break
        case 2:
              viewSetGoal.isHidden = !viewSetGoal.isHidden
          break
        case 3:
            //viewSetGoal.isHidden = !viewSetGoal.isHidden
            break
        case 4:
            self.slideMenuController()?.changeMainViewController(self.FeedBackViewController, close: true)
          break
        case 5:
            if objUser?.user_Type == "0"{
                viewSelectSchool.isHidden = !viewSelectSchool.isHidden
            }else{
                self.slideMenuController()?.changeMainViewController(self.LeftMenuSchoolViewController, close: true)
            }
          break
        case 7:
            let alert = UIAlertController(title: GlobalConstants.appName, message: "Are you sure you want to sign out?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                
                self.Post_Logout()
                
//                //Section expired for google sign in
//                GIDSignIn.sharedInstance().signOut()
//
//                //Move to home view in when app is launch
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                let nav: UINavigationController! = (appDelegate.window?.rootViewController as! UINavigationController)
//                nav.popToRootViewController(animated: true)
                
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
            
        default:
            break
        }
    }
    func showDetailsView(_ index: Int) {
        self.slideMenuController()?.changeMainViewController(self.TabBarViewController, close: true)
        
        let when = DispatchTime.now() + 0.0 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            vw_HomeView?.movingData(int_Value:index)
        }
    }
    func reloadViewData(){
        //Editing ModeaDecoder
        if objUser?.user_Type == "0"{
            menus = [["name":"Profile","image":"1"],["name":"Change Flashcard Color","image":"2"],["name":"Set Goal","image":"3"],["name":"Notifications","image":"4"],["name":"Feedback","image":"5"],["name":"Register As Student","image":"6"],["name":"External Access","image":"7"],["name":"Sign Out","image":"8"]]
        }else{
            menus = [["name":"Profile","image":"1"],["name":"Change Flashcard Color","image":"2"],["name":"Set Goal","image":"3"],["name":"Notifications","image":"4"],["name":"Feedback","image":"5"],["name":"My School","image":"6"],["name":"External Access","image":"7"],["name":"Sign Out","image":"8"]]
        }
        
        tableView.reloadData()
    }
    
    //For didselect method for present view controller
    func changeViewController(_ menu: LeftMenu) {
    }
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        //        toggleLeft()
        self.slideMenuController()?.changeMainViewController(self.TabBarViewController, close: true)
    }
    
    @IBAction func viewSetGoalHiddenClick(_ sender: Any) {
      viewSetGoal.isHidden = !viewSetGoal.isHidden
      
      self.view.endEditing(true)
    }
    
    @IBAction func setColorHiddenClick(_ sender: Any) {
      viewSetColor.isHidden = !viewSetColor.isHidden
    }
    
    @IBAction func schoolHiddenClick(_ sender: Any) {
        
        self.Post_RegistrationWithSutdent()
        
//        objUser?.user_Type = "1"
//        saveCustomObject(objUser!, key: "userobject");
//        self.reloadViewData()
//
//        //Alert show for Header
//        messageBar.MessageShow(title: "Please update Minnaz to get access to your school portal", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
//
//        viewSelectSchool.isHidden = !viewSelectSchool.isHidden
//
//        //Logout when user apply for school portal
//        GIDSignIn.sharedInstance().signOut()
//
//        //Move to home view in when app is launch
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let nav: UINavigationController! = (appDelegate.window?.rootViewController as! UINavigationController)
//        nav.popToRootViewController(animated: true)
    }
    
    @IBAction func btn_Setting(_ sender: Any){
//     self.slideMenuController()?.changeMainViewController(self.SettingsViewController, close: true)
        
//        let when = DispatchTime.now() + 0.3 // change 2 to desired number of seconds
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            vw_HomeView?.movingData(int_Value:0)
//        }
    }
    
    
    // MARK: - Get/Post Method -
    func Post_Logout(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)logout"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "devicetoken" :  UserDefaults.standard.value(forKey: "DeviceToken") == nil ? "123" : UserDefaults.standard.value(forKey: "DeviceToken")! as! String,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "logout"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = true
        webHelper.startDownload()
    }
    
    func Post_RegistrationWithSutdent(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)register_as_student"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "register_as_student"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = true
        webHelper.startDownload()
    }
    
}


// MARK: - Tableview Delegate -

extension LeftMenuViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
        return CGFloat(GlobalConstants.windowHeight * 0.12)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell", for:indexPath as IndexPath) as! LeftMenuCell

        //Declare text in icon in tableview cell
        cell.lblTitle.text = menus[indexPath.row]["name"]
        cell.imgLogo.image = UIImage(named:menus[indexPath.row]["image"]!)!
        
        //Manage font
        cell.lblTitle.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        
        if indexPath.row == 3 || indexPath.row == 6 {
          cell.btnSwitch.isHidden = false
        }else {
          cell.btnSwitch.isHidden = true
        }
        
        cell.btnSwitch.addTarget(self, action:#selector(handleRegister), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        selectedIndex = indexPath.row
        self.callmethod(_int_Value: indexPath.row)
    }
  
    @objc func handleRegister(sender: UIButton){
        sender.isSelected = !sender.isSelected
        //...
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

//MARK: - Collection View -
extension LeftMenuViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return arrColor.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let viewColor : UIView = (cell.viewWithTag(100))!
        let viewBorder : UIView = (cell.viewWithTag(101))!
        viewColor.backgroundColor = arrColor[indexPath.row]
        viewColor.layer.cornerRadius = 5.0
        viewBorder.isHidden = false
        if indexPath.row == selectedIndex {
          viewBorder.isHidden = false
        }else {
          viewBorder.isHidden = true
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
        cardDefaultColor = arrColor[indexPath.row]
    }
}



extension LeftMenuViewController : WebServiceHelperDelegate{
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        if strRequest == "logout" || strRequest == "register_as_student"{
            
            //Store data nill value when user logout
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "userobject")
            defaults.synchronize()
            
            //Section expired for google sign in
            GIDSignIn.sharedInstance().signOut()
            
            //Move to home view in when app is launch
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let nav: UINavigationController! = (appDelegate.window?.rootViewController as! UINavigationController)
            nav.popToRootViewController(animated: true)
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        print(error)
    }
    
}




