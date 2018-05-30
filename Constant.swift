//
//  Constant.swift
//  SportLite
//
//  Created by iCoderz_07 on 11/09/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import Foundation
import UIKit

struct GlobalConstants
{
    // Constant define here.
    
    static let developerTest : Bool = false
  
    //Implementation View height
    static let screenHeightDeveloper : Double = 667
    static let screenWidthDeveloper : Double = 375
    
    //Base URL
//    static let BaseURL = "http://www.icoderzsolutions.com/client_a/minazz/api/v1/"
//    static let BaseURL = "http://www.icoderzsolutions.com/client_a/minazz/api/v2/"
//    static let BaseURL = "http://www.icoderzsolutions.com/client_a/minazz/api/v3/"
    static let BaseURL = "http://www.minnaz.com/admin/api/v3/"
    
    
    //Name And Appdelegate Object
    static let appName: String = "Minnaz"
    static let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    static let kFontRatio =  (UIScreen.main.bounds.size.width/375)
  
    //System width height
    static let windowWidth: Double = Double(UIScreen.main.bounds.size.width)
    static let windowHeight: Double = Double(UIScreen.main.bounds.size.height)
    
    //Font
    static let kFontLight = "Roboto-Light"
    static let kFontRegular = "Roboto-Regular"
    static let kFontMedium = "Roboto-Medium"
    static let kFontSemiBold = "Avenir-Medium"
    static let kFontBold = "Avenir-Heavy"
    
    //Google Api forKey
    static let apiKeyGoogle = "AIzaSyCuuATFaZqxiN-7tvSkEvEN41G1GP_M3uE"
    
    //Loading data pagination
    static let int_LoadMax = 6
    static let int_LoadMaxCollection = 12
    
    //Google AnalityKey
    static let apiKeyGoogleAnality = "UA-105722820-1"
    
    //Device Token
    static let DeviceToken = UserDefaults.standard.object(forKey: "DeviceToken")
    
    //Place holder
    static let placeHolder_User = "icon_PlaceHolderUser"
    static let placeHolder_Comman = "icon_PlaceHolderSquare"
    
    //App Color
    static let appColor = UIColor(red: 44/255, green: 62/255, blue: 84/255, alpha: 1.0)
    static let appGreenColor = UIColor(red: 0/255, green: 207/255, blue: 255/255, alpha: 1.0)
    static let appPopupBackgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
    
    //Google Search
    static let googleImageSearch = "AIzaSyBd0vpZ05n2frDI2dUoTA_HSiFB4xa8Euw"
    
    //tempIMage232
    static let img_Temp = "https://hellodotcom.hello.com/img_/hello_logo_hero.png"
}

extension NSDictionary {
    func getStringForID(key: String) -> String? {
        
        var strKeyValue : String = ""
        if (self[key] as? Int) != nil {
            strKeyValue = String(self[key] as? Int ?? 0)
        } else if (self[key] as? String) != nil {
            strKeyValue = self[key] as? String ?? ""
        }
        return strKeyValue
    }
}

//Comman Function
//func removeSpecialCharsFromString(text: String) -> String {
//    let okayChars : Set<Character> =
//        Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
//    return String(text.characters.filter {okayChars.contains($0) })
//}

func removeSpecialCharsFromString(text: String) -> String {

    let charsToRemove: Set<Character> = Set("[{}\\[\\]+:?,\"\'".characters)
    let newNumberCharacters = String(text.characters.filter { !charsToRemove.contains($0) })
    print(newNumberCharacters) //prints 1 832 8316486
     return newNumberCharacters
}


