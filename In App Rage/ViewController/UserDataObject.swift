//
//  UserDataObject.swift
//  HealthyBlackMen
//
//  Created by ketan_icoderz on 16/05/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit

class UserDataObject: NSObject,NSCoding  {
    //NSCoding
    
    var user_UserID : String = ""
    var user_Name : String = ""
    var user_Email : String = ""
    var user_Image : String = ""
    var user_Type : String = ""
    var user_AccountType : String = ""
    var user_Socialid : String = ""
    var user_isActive : String = ""
    
    //Scholl Module
    var user_SchoolName : String = ""
    
    //Traslation
    var traslation_DictionaryName : String = ""
    
    var traslation_ToName : String = ""
    var traslation_ToNameLexin : String = ""
    var traslation_ToNameGlobse : String = ""
    
    var traslation_ToID : String = ""
    var traslation_ToTitle : String = ""
    
    var traslation_FromName : String = ""
    var traslation_FromNameLexin : String = ""
    var traslation_FromNameGlobse : String = ""
    
    var traslation_SupportedGoogle : String = ""
    var traslation_SupportedLexin : String = ""
    var traslation_SupportedGlobse : String = ""
    
    var traslation_FromId : String = ""
    var traslation_FromTitle : String = ""
    var traslation_DictionaryID : String = ""
    var traslation_Play : String = ""
    
    //Category Module
    var category_SelectedCat : String = ""
    var category_SelectedCatId : String = ""
    var category_SelectedSubCat : String = ""
    var category_SelectedSubCatId : String = ""
    
    override init(){
        super.init()
    }
    
    init(user_UserID : String,user_Name : String,user_Email : String,user_Image : String,user_Type : String,user_AccountType : String, user_Socialid : String,user_isActive : String,user_SchoolName : String,traslation_DictionaryName : String,traslation_ToName : String,traslation_ToNameLexin : String,traslation_ToNameGlobse : String,traslation_ToID : String,traslation_ToTitle : String,traslation_FromName : String,traslation_FromNameLexin : String,traslation_FromNameGlobse : String,traslation_SupportedGoogle : String,traslation_SupportedLexin : String,traslation_SupportedGlobse : String,traslation_FromId : String,traslation_FromTitle : String, traslation_DictionaryID : String, traslation_Play : String, category_SelectedCat : String, category_SelectedCatId : String, category_SelectedSubCat : String, category_SelectedSubCatId : String) {
        
        self.user_UserID = user_UserID as String
        self.user_Name = user_Name as String
        self.user_Email = user_Email as String
        self.user_Image = user_Image as String
        self.user_Type = user_Type as String
        self.user_AccountType = user_AccountType as String
        self.user_Socialid = user_Socialid as String
        self.user_isActive = user_isActive as String
        self.user_SchoolName = user_SchoolName as String
        self.traslation_DictionaryName = traslation_DictionaryName as String
        self.traslation_ToName = traslation_ToName as String
        self.traslation_ToNameLexin = traslation_ToNameLexin as String
        self.traslation_ToNameGlobse = traslation_ToNameGlobse as String
        self.traslation_ToID = traslation_ToID as String
        self.traslation_ToTitle = traslation_ToTitle as String
        self.traslation_FromName = traslation_FromName as String
        self.traslation_FromNameLexin = traslation_FromNameLexin as String
        self.traslation_FromNameGlobse = traslation_FromNameGlobse as String
        self.traslation_SupportedGoogle = traslation_SupportedGoogle as String
        self.traslation_SupportedLexin = traslation_SupportedLexin as String
        self.traslation_SupportedGlobse = traslation_SupportedGlobse as String
        self.traslation_FromId = traslation_FromId as String
        self.traslation_FromTitle = traslation_FromTitle as String
        self.traslation_DictionaryID = traslation_FromId as String
        self.traslation_Play = traslation_Play as String
        self.category_SelectedCat = category_SelectedCat as String
        self.category_SelectedCatId = category_SelectedCatId as String
        self.category_SelectedSubCat = category_SelectedSubCat as String
        self.category_SelectedSubCatId = category_SelectedSubCatId as String
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let user_UserID = aDecoder.decodeObject(forKey: "user_UserID") as! String
        let user_Name = aDecoder.decodeObject(forKey: "user_Name") as! String
        let user_Email = aDecoder.decodeObject(forKey: "user_Email") as! String
        let user_Image = aDecoder.decodeObject(forKey: "user_Image") as! String
        let user_Type = aDecoder.decodeObject(forKey: "user_Type") as! String
        let user_AccountType = aDecoder.decodeObject(forKey: "user_AccountType") as! String
        let user_Socialid = aDecoder.decodeObject(forKey: "user_Socialid") as! String
        let user_isActive = aDecoder.decodeObject(forKey: "user_isActive") as! String
        let user_SchoolName = aDecoder.decodeObject(forKey: "user_SchoolName") as! String
        let traslation_DictionaryName = aDecoder.decodeObject(forKey: "traslation_DictionaryName") as! String
        let traslation_ToName = aDecoder.decodeObject(forKey: "traslation_ToName") as! String
        let traslation_ToNameLexin = aDecoder.decodeObject(forKey: "traslation_ToNameLexin") as! String
        let traslation_ToNameGlobse = aDecoder.decodeObject(forKey: "traslation_ToNameGlobse") as! String
        let traslation_ToID = aDecoder.decodeObject(forKey: "traslation_ToID") as! String
        let traslation_ToTitle = aDecoder.decodeObject(forKey: "traslation_ToTitle") as! String
        let traslation_FromName = aDecoder.decodeObject(forKey: "traslation_FromName") as! String
        let traslation_FromNameLexin = aDecoder.decodeObject(forKey: "traslation_FromNameLexin") as! String
        let traslation_FromNameGlobse = aDecoder.decodeObject(forKey: "traslation_FromNameGlobse") as! String
        let traslation_SupportedGoogle = aDecoder.decodeObject(forKey: "traslation_SupportedGoogle") as! String
        let traslation_SupportedLexin = aDecoder.decodeObject(forKey: "traslation_SupportedLexin") as! String
        let traslation_SupportedGlobse = aDecoder.decodeObject(forKey: "traslation_SupportedGlobse") as! String
        let traslation_FromId = aDecoder.decodeObject(forKey: "traslation_FromId") as! String
        let traslation_FromTitle = aDecoder.decodeObject(forKey: "traslation_FromTitle") as! String
        let traslation_DictionaryID = aDecoder.decodeObject(forKey: "traslation_DictionaryID") as! String
        let traslation_Play = aDecoder.decodeObject(forKey: "traslation_Play") as! String
        let category_SelectedCat = aDecoder.decodeObject(forKey: "category_SelectedCat") as! String
        let category_SelectedCatId = aDecoder.decodeObject(forKey: "category_SelectedCatId") as! String
        let category_SelectedSubCat = aDecoder.decodeObject(forKey: "category_SelectedSubCat") as! String
        let category_SelectedSubCatId = aDecoder.decodeObject(forKey: "category_SelectedSubCatId") as! String
        
        self.init(user_UserID: user_UserID as String,
                  user_Name: user_Name as String,
                  user_Email: user_Email as String,
                  user_Image: user_Image as String,
                  user_Type: user_Type as String,
                  user_AccountType: user_AccountType as String,
                  user_Socialid: user_Socialid as String,
                  user_isActive: user_isActive as String,
                  user_SchoolName: user_SchoolName as String,
                  traslation_DictionaryName: traslation_DictionaryName as String,
                  traslation_ToName: traslation_ToName as String,
                  traslation_ToNameLexin: traslation_ToNameLexin as String,
                  traslation_ToNameGlobse: traslation_ToNameGlobse as String,
                  traslation_ToID: traslation_ToID as String,
                  traslation_ToTitle: traslation_ToTitle as String,
                  traslation_FromName: traslation_FromName as String,
                  traslation_FromNameLexin: traslation_FromNameLexin as String,
                  traslation_FromNameGlobse: traslation_FromNameGlobse as String,
                  traslation_SupportedGoogle: traslation_SupportedGoogle as String,
                  traslation_SupportedLexin: traslation_SupportedLexin as String,
                  traslation_SupportedGlobse: traslation_SupportedGlobse as String,
                  traslation_FromId: traslation_FromId as String,
                  traslation_FromTitle: traslation_FromTitle as String,
                  traslation_DictionaryID: traslation_DictionaryID as String,
                  traslation_Play : traslation_Play as String,
                  category_SelectedCat: category_SelectedCat as String,
                  category_SelectedCatId: category_SelectedCatId as String,
                  category_SelectedSubCat: category_SelectedSubCat as String,
                  category_SelectedSubCatId: category_SelectedSubCatId as String)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(user_UserID, forKey: "user_UserID")
        aCoder.encode(user_Name, forKey: "user_Name")
        aCoder.encode(user_Email, forKey: "user_Email")
        aCoder.encode(user_Image, forKey: "user_Image")
        aCoder.encode(user_Type, forKey: "user_Type")
        aCoder.encode(user_AccountType, forKey: "user_AccountType")
        aCoder.encode(user_Socialid, forKey: "user_Socialid")
        aCoder.encode(user_isActive, forKey: "user_isActive")
        aCoder.encode(user_SchoolName, forKey: "user_SchoolName")
        aCoder.encode(traslation_DictionaryName, forKey: "traslation_DictionaryName")
        aCoder.encode(traslation_ToName, forKey: "traslation_ToName")
        aCoder.encode(traslation_ToNameLexin, forKey: "traslation_ToNameLexin")
        aCoder.encode(traslation_ToNameGlobse, forKey: "traslation_ToNameGlobse")
        aCoder.encode(traslation_ToID, forKey: "traslation_ToID")
        aCoder.encode(traslation_ToTitle, forKey: "traslation_ToTitle")
        aCoder.encode(traslation_FromName, forKey: "traslation_FromName")
        aCoder.encode(traslation_FromNameLexin, forKey: "traslation_FromNameLexin")
        aCoder.encode(traslation_FromNameGlobse, forKey: "traslation_FromNameGlobse")
        aCoder.encode(traslation_SupportedGoogle, forKey: "traslation_SupportedGoogle")
        aCoder.encode(traslation_SupportedLexin, forKey: "traslation_SupportedLexin")
        aCoder.encode(traslation_SupportedGlobse, forKey: "traslation_SupportedGlobse")
        aCoder.encode(traslation_FromId, forKey: "traslation_FromId")
        aCoder.encode(traslation_FromTitle, forKey: "traslation_FromTitle")
        aCoder.encode(traslation_DictionaryID, forKey: "traslation_DictionaryID")
        aCoder.encode(traslation_Play, forKey: "traslation_Play")
        aCoder.encode(category_SelectedCat, forKey: "category_SelectedCat")
        aCoder.encode(category_SelectedCatId, forKey: "category_SelectedCatId")
        aCoder.encode(category_SelectedSubCat, forKey: "category_SelectedSubCat")
        aCoder.encode(category_SelectedSubCatId, forKey: "category_SelectedSubCatId")
    }
    
}





