//
//  AppDelegate.swift
//  Minnaz
//
//  Created by iCoderz_07 on 13/11/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import AVFoundation
import IQKeyboardManagerSwift
import Alamofire
import AVFoundation
import SwiftMessages
import FacebookLogin
import FBSDKCoreKit
import Alamofire
import EventKit
import Quizlet_iOS
import FMDB

//Global Declaration
var messageBar = MessageBarController()
var act_indicator = ActivityIndicatorViewController()
var objUser : UserDataObject?
var vw_BaseView: LeftMenuViewController?
var vw_HomeView: HomeViewController?
var cardDetailsView: CardDetailsViewController?

var cardDefaultColor = UIColor(red: 223/255, green: 216/255, blue: 205/255, alpha: 1.0)
var sourcePath: String = ""
var db: OpaquePointer?
var LANGUAGE_KEY = "languageKey"
var AsStudent = "0"

//Quizlet Key
let CLIENT_ID = "2wd4m22v4d"
let SECRET_KEY = "s3eWUyftJAdKjDDz87RnKd"

let databaseFileName = "QuizletDB.rdb"
var pathToDatabase: String!
var database: FMDatabase!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Action of in statisic graphic
        //Name in bottom
        
        self.navigationSet()
        UserDefaults.standard.set("", forKey: LANGUAGE_KEY)
        
        //        print(UIFont.familyNames)
        //        print(UIFont.fontNames(forFamilyName: "Roboto"))//San Francisco Text
        
        //Text editing manager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = true
        
        //Facebook Compusary method
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //Status bar
        
        
        UIApplication.shared.statusBarStyle = .lightContent
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
        print(pathToDatabase)
        self.createDatabase()
        
        //Get device token
        DispatchQueue.main.async {
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        //Already Login
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.alredyLoginOrNot()
        }
        
        //Silence mode
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch let error as NSError {
            print("Error: Could not set audio category: \(error), \(error.userInfo)")
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print("Error: Could not setActive to true: \(error), \(error.userInfo)")
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func createDatabase() {
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createQuizletSearchSet = "CREATE TABLE IF NOT EXISTS QuizletSearchSet (id INTEGER PRIMARY KEY AUTOINCREMENT, setID Varchar, setSearch Varchar, setTitle Varchar, setCreateBy Varchar, setTermCount INTEGER)"
                    
                    do {
                        try database.executeUpdate(createQuizletSearchSet, values: nil)
                        
                        let createQuizletCardSet = "CREATE TABLE IF NOT EXISTS QuizletCardSet (id INTEGER PRIMARY KEY AUTOINCREMENT, setID Varchar, cardID Varchar, cardTerm Varchar, cardDefi Varchar, cardimgURL Varchar)"
                        do {
                            try database.executeUpdate(createQuizletCardSet, values: nil)
                        }
                        catch {
                            print("Could not create table.")
                            print(error.localizedDescription)
                        }
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    // At the end close the database.
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme == "fb231321394070263" {
            return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        }else if url.scheme == "com.googleusercontent.apps.65130673863-pt52tmq2urt0mi795k80mul35ffpu88d"{
            var options: [String: AnyObject] = [UIApplicationOpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject,
                                                UIApplicationOpenURLOptionsKey.annotation.rawValue: annotation as AnyObject]
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication: sourceApplication,
                                                     annotation: annotation)
        }else if (url.scheme == "quizletdemo") {
            Quizlet.shared().handle(url)
            let strParameters: String? = url.query
            let arrParamaters = strParameters?.components(separatedBy: "&")
            for str: String in arrParamaters! {
                if str.contains("code") {
                    let strCode: String? = str.components(separatedBy: "=").last
                    print("Code = \(strCode)")
                }
            }
        }
        return true
    }
    
    
    // MARK: - Device Tocken -
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        UserDefaults.standard.set(token, forKey: "DeviceToken")
        
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        UserDefaults.standard.set("123", forKey: "DeviceToken")
        print("Print ::Failed to get token, error: \(error)")
        
    }
    
    
    // MARK: - Already Login -
    func alredyLoginOrNot(){
        if ((loadCustomObject(withKey: "userobject")) != nil){
            var objUserTemp : UserDataObject = loadCustomObject(withKey: "userobject")!
            
            //Condition get data from userdefault
            if objUserTemp.user_Name.characters.count != 0 {
                //Save Object In global variable
                objUser = objUserTemp
                
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when) {
                    manageTabBarandSideBar()
                }
            }
        }
    }
    
    
    
    // MARK: - Navigation Manager -
    func navigationSet() {
        //UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage(named: "btn_Back"), for: .normal, barMetrics: .default)
        // UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -500), for: .default)
        UINavigationBar.appearance().setBackgroundImage(image(with:GlobalConstants.appColor), for: .default)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name:  GlobalConstants.kFontSemiBold, size: 17.0)!]
        //        UINavigationBar.appearance().shadowImage = UIImage(named: "img_Shadow")
        UINavigationBar.appearance().shadowImage = UIImage()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }  
}

// MARK: - Play Nusuc -
func playMusic(str_TraslationText : String,Language : String){
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: str_TraslationText)
    utterance.rate = 0.2
    utterance.voice = AVSpeechSynthesisVoice(language: Language)
    synthesizer.speak(utterance)
}
func playAvailble(Language : String) -> Bool{
    for voice: AVSpeechSynthesisVoice in AVSpeechSynthesisVoice.speechVoices() {
        let arr_Convert = voice.language.components(separatedBy: "-")
        if Language == arr_Convert[0] as! String{
            return true
        }
    }
    return false
}

// MARK: - User Object Updatet -
func userObjectUpdate(dict_Get : NSDictionary){
    
    let dict_result = dict_Get["user_detail"] as! NSDictionary
    
    //Store data in object
    let obj = UserDataObject(user_UserID : String(dict_result["user_id"] as! Int),
                             user_Name : dict_result["name"]  as? String ?? "",
                             user_Email : dict_result["email"]  as? String ?? "",
                             user_Image : dict_result["image"]  as? String ?? "",
                             user_Type : dict_result["user_type"]  as? String ?? "",
                             user_AccountType : dict_result["account_type"]  as? String ?? "",
                             user_Socialid : dict_result["social_id"]  as? String ?? "",
                             user_isActive : dict_result["is_active"]  as? String ?? "",
                             user_SchoolName : "",
                             traslation_DictionaryName : dict_result["selected_dictionary"]  as? String ?? "0",
                             traslation_ToName : "",
                             traslation_ToNameLexin : "",
                             traslation_ToNameGlobse : "",
                             traslation_ToID : "",
                             traslation_ToTitle : "",
                             traslation_FromName : "",
                             traslation_FromNameLexin : "",
                             traslation_FromNameGlobse : "",
                             traslation_SupportedGoogle : "",
                             traslation_SupportedLexin : "",
                             traslation_SupportedGlobse : "",
                             traslation_FromId : "",
                             traslation_FromTitle : "",
                             traslation_DictionaryID : "",
                             traslation_Play : "",
                             category_SelectedCat : "",
                             category_SelectedCatId : "",
                             category_SelectedSubCat : "",
                             category_SelectedSubCatId : "")
    
    //Manage dictionary
    let arr_Dictonary = dict_result["Dictionary"] as! NSArray
    let dict_Dictonary = arr_Dictonary[0] as! NSDictionary
    let arr_From = dict_Dictonary["From_language"] as! NSArray
    let arr_To = dict_Dictonary["To_language"] as! NSArray
    
    if arr_From.count != 0{
        //From Lanaguage
        let dict_FromDictonary = arr_From[0] as! NSDictionary

        obj.traslation_FromName = dict_FromDictonary["abbrivation"] as! String
        obj.traslation_FromNameLexin = dict_FromDictonary["abbrivation_lexin"] as! String
        obj.traslation_FromNameGlobse = dict_FromDictonary["abbrivation_glosbe"] as! String
        obj.traslation_FromId = String(dict_FromDictonary["language_id"] as! Int)
        obj.traslation_FromTitle = dict_FromDictonary["title"] as! String

        //To Lanaguage
        let dict_ToDictonary = arr_To[0] as! NSDictionary

        obj.traslation_ToName = dict_ToDictonary["abbrivation"] as! String
        obj.traslation_ToNameLexin = dict_ToDictonary["abbrivation_lexin"] as! String
        obj.traslation_ToNameGlobse = dict_ToDictonary["abbrivation_glosbe"] as! String
        obj.traslation_ToID = String(dict_ToDictonary["language_id"] as! Int)
        obj.traslation_ToTitle = dict_ToDictonary["title"] as! String
        
        //Combination for languageas
        obj.traslation_SupportedGoogle = "0"
        obj.traslation_SupportedLexin = "0"
        obj.traslation_SupportedGlobse = "0"
        if dict_FromDictonary["support_google"] as! String  == "1" && dict_ToDictonary["support_google"] as! String  == "1"{
            obj.traslation_SupportedGoogle = "1"
        }
        if dict_FromDictonary["support_lexin"] as! String  == "1" && dict_ToDictonary["support_lexin"] as! String  == "1"{
            if obj.traslation_FromNameLexin == "swe_swe"{
               obj.traslation_SupportedLexin = "1"
            }
//            else if obj.traslation_FromNameLexin == "swe_eng" && obj.traslation_ToNameLexin == "swe_swe"{
//                obj.traslation_SupportedLexin = "1"
//            }
        }
        if dict_FromDictonary["support_glosbe"] as! String  == "1" && dict_ToDictonary["support_glosbe"] as! String  == "1"{
            obj.traslation_SupportedGlobse = "1"
        }
    }
 
    //Manage Category Module
    let Dict_Category = dict_result["selected_category"] as! NSDictionary
    if Dict_Category["category_name"] as? String ?? "" != ""{
        obj.category_SelectedCatId = String(Dict_Category["category_id"] as! Int)
        obj.category_SelectedCat = Dict_Category["category_name"] as! String
        
        let arr_SubCategory = Dict_Category["sub_category"] as! NSArray
        if arr_SubCategory.count != 0{
            let dict_SubCategory = arr_SubCategory[0] as! NSDictionary
            
            obj.category_SelectedSubCatId = String(dict_SubCategory["category_id"] as! Int)
            obj.category_SelectedSubCat = dict_SubCategory["category_name"] as! String
        }
    }
    
    //Traslation speak available or not
    if obj.traslation_FromName != ""{
        if playAvailble(Language : (obj.traslation_FromName)) == true{
            obj.traslation_Play = "1"
        }
    }
    
    //Save User Object
    saveCustomObject(obj, key: "userobject");
    
    //Save Object In global variable
    objUser = obj
}

// MARK: -- Selected Dictionary Get --
func selectedDictionary() -> NSMutableArray{
    var arr_Manage : NSMutableArray = []

   
    //Lexin Compration
    if objUser?.traslation_SupportedLexin == "1"{
        var obj = DictionaryManageObject()
        obj.str_Title = "Laxin"
        obj.str_TitleShow = "Lexin"
        obj.str_ToId = (objUser?.traslation_ToNameLexin)!
        obj.str_ToFrom = (objUser?.traslation_FromNameLexin)!
        obj.str_Image = "icon_Dictionary2"
        obj.str_IdentifierId = "2"
        arr_Manage.add(obj)
    }
    
    //Globas Compration
    if objUser?.traslation_SupportedGlobse == "1"{
        var obj = DictionaryManageObject()
        obj.str_Title = "Glosbe"
        obj.str_TitleShow = "Glosbe"
        obj.str_ToId = (objUser?.traslation_ToNameGlobse)!
        obj.str_ToFrom = (objUser?.traslation_FromNameGlobse)!
        obj.str_Image = "icon_Dictionary3"
        obj.str_IdentifierId = "3"
        arr_Manage.add(obj)
    }
    
    //Google Compration
    if objUser?.traslation_SupportedGoogle == "1"{
        var obj = DictionaryManageObject()
        obj.str_Title = "Google"
        obj.str_TitleShow = "Google"
        obj.str_ToId = (objUser?.traslation_ToName)!
        obj.str_ToFrom = (objUser?.traslation_FromName)!
        obj.str_Image = "icon_Dictionary1"
        obj.str_IdentifierId = "1"
        arr_Manage.add(obj)
    }
    
    return arr_Manage
}

func manageSelectedeDictionaryAsaFirst(){
    
    if objUser?.traslation_SupportedLexin == "1"{
        objUser!.traslation_DictionaryName = "2"
    }else if objUser?.traslation_SupportedGlobse == "1"{
        objUser!.traslation_DictionaryName = "3"
    }else if objUser?.traslation_SupportedGoogle == "1"{
        objUser!.traslation_DictionaryName = "1"
    }
    
    //Save User Object
    saveCustomObject(objUser!, key: "userobject");
}


func langSelectedOrNot() -> Bool{
    if objUser?.traslation_FromId != ""{
        return true
    }else{
        messageBar.MessageShow(title: "Please select language first", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        
        return false
    }
}

// MARK: -- Reward Point Manage --
func networkOnOrOff() -> Bool {
    
    if NetworkReachabilityManager()!.isReachable {
        return true
    }
    return false
}



// MARK: - Make Image with Color -
func image(with color: UIColor) -> UIImage {
    let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
    UIGraphicsBeginImageContext(rect.size)
    let context: CGContext? = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

//MARK: -- Inicator --
func indicatorShow() {
    let size = CGSize(width: 30, height: 30)
    
    act_indicator.startAnimating(size, message: "Loading", type: NVActivityIndicatorType(rawValue:2)!)
}
func indicatorHide() {
    act_indicator.stopAnimating()
}

//MARK: -- Email Validation --
func validateEmail(enteredEmail:String) -> Bool {
    
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: enteredEmail)
}

func validatePhoneNumber(value: String) -> Bool {
    let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
    let inputString = value.components(separatedBy: charcterSet)
    let filtered = inputString.joined(separator: "")
    return  value == filtered
}

func dateTimeFormate(date : String,type : String) -> String{
    
    //End data
    //    var dateString = "2017-10-01 17:00:00" // change to your date format
    var dateString = date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    //Current Data
    var dateNew = dateFormatter.date(from: dateString)
    
    if type == "1"{
        //Required formate convert
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: dateNew!)
    }else if type == "2"{
        //Required formate convert
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: dateNew!)
    }
    
    
    return ""
}


//MARK: -- Set up Tabbar and sidebar controller --
func manageTabBarandSideBar(){
    //Store data in object
    
    //Declare alloc init for storyboard/Mange Tab bar
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    let leftViewController = storyboard.instantiateViewController(withIdentifier: "navsidemenu") as! UINavigationController
    
    let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
    
    //Declare Slidemenucontroller with connect sidebar and menubar
    let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
    slideMenuController.automaticallyAdjustsScrollViewInsets = true
    slideMenuController.delegate = mainViewController
    slideMenuController.changeLeftViewWidth(CGFloat(0))
    
    let when = DispatchTime.now() + 0.5
    DispatchQueue.main.asyncAfter(deadline: when) {
        let calculationValue = (GlobalConstants.windowWidth * 100) / 100
        slideMenuController.changeLeftViewWidth(CGFloat(calculationValue))
    }
    
    //Manage Slidemenu
    SlideMenuOptions.hideStatusBar = false
    SlideMenuOptions.contentViewOpacity = 1.0
    SlideMenuOptions.contentViewScale = 1.0
    
    //    SlideMenuOptions.rightPanFromBezel = false
    //Call navigation with push view controller
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    _ =  mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    
    let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
    let nav2: UINavigationController! = (appDelegate2.window?.rootViewController as! UINavigationController)
    nav2?.pushViewController(slideMenuController, animated: true)
}



//MARK: --User Object--
func saveCustomObject(_ object: UserDataObject, key: String) {
    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
    let defaults = UserDefaults.standard
    defaults.set(encodedObject, forKey: key)
    defaults.synchronize()
}

func loadCustomObject(withKey key: String) -> UserDataObject? {
    let defaults = UserDefaults.standard
    let encodedObject: Data? = defaults.object(forKey: key) as! Data?
    if encodedObject != nil {
        let object: UserDataObject? = NSKeyedUnarchiver.unarchiveObject(with: encodedObject!) as! UserDataObject?
        return object!
    }
    return nil
}

//MARK: -- Share To All --
func shareFunction(textData : String,viewPresent: UIViewController){
    // text to share
    let text = "This is some text that I want to share."
    
    // set up activity view controller
    let textToShare = [ textData ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = viewPresent.view // so that iPads won't crash
    
    // exclude some activity types from the list (optional)
    // activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
    
    // present the view controller
    viewPresent.present(activityViewController, animated: true, completion: nil)
}

func validationforLexinEnglishDictionaryShow() -> Bool{
    if objUser?.traslation_FromNameLexin as! String == "swe_swe" && objUser?.traslation_ToNameLexin as! String == "swe_eng"{
        return true
    }else if objUser?.traslation_FromNameLexin as! String == "swe_eng" && objUser?.traslation_ToNameLexin as! String == "swe_swe"{
        return true
    }
    
    return false
}

//MARK: - DateFormate Edit -
func dateStartToDayStart(date : String,type : String) -> NSDate{
    
    //End data
    //    var dateString = "2017-10-01 17:00:00" // change to your date format
    let dateString = date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    //Current Data
    let date = dateFormatter.date(from: dateString)
    
    //Required formate convert
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    var dateSave = dateFormatter.string(from: date!)
    
    return dateFormatter.date(from: dateSave) as! NSDate
    
}

//MARK: - Array To string convertion -
func notPrettyString(from object: Any) -> String? {
    if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
        let objectString = String(data: objectData, encoding: .utf8)
        return objectString
    }
    return nil
}


//MARK: - Calculate widht or height of string -
extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
//MARK: - Manage Font -
func manageFontHeight(font : Double) -> CGFloat{
    let cal : Double = GlobalConstants.windowHeight * font
    
    return CGFloat(cal / GlobalConstants.screenHeightDeveloper)
}

func manageFont(font : Double) -> CGFloat{
    let cal : Double = GlobalConstants.windowWidth * font
    
    return CGFloat(cal / GlobalConstants.screenWidthDeveloper)
}



//MARK: -- Selected Index --
func selectedIndex(arr : NSArray, value : NSString) -> Int{
    for (index, element) in arr.enumerated() {
        if value as String == arr[index] as! String {
            return index
        }
    }
    return 0
}
extension UserDefaults {
    func setString(string:String, forKey:String) {
        set(string, forKey: forKey)
    }
    func setDate(date:NSDate, forKey:String) {
        set(date, forKey: forKey)
    }
    //  func dateForKey(string:String) -> NSDate? {
    //    return objectForKey(string) as? NSDate
    //  }
}
