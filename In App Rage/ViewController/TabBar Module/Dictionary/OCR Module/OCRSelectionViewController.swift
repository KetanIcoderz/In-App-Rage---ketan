//
//  OCRSelectionViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 26/02/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import PopOverMenu
import EmptyDataSet_Swift
import SwiftMessages
import AVFoundation

class OCRSelectionViewController: UIViewController,DismissViewDelegate,DismissSelectLanguageDelegate,DismissEditWordDelegate {
    
    var arr_Main : NSMutableArray = []
    var arr_Collection : NSMutableArray = []
    var arr_Main_Sub : NSMutableArray = []
    
    //Collectionview
    @IBOutlet weak var cv_Word: UICollectionView!
    
    //Button
    @IBOutlet weak var btn_ChangeLanguage: UIButton!
    @IBOutlet weak var btn_Speak: UIButton!
    @IBOutlet weak var btn_Favorite: UIButton!
    @IBOutlet weak var btn_ChnageTranslator: UIButton!
    @IBOutlet var btn_Save: UIButton!
    @IBOutlet var btn_Category: UIButton!
    @IBOutlet var btn_Currenct: UIButton!
    @IBOutlet var btn_Currenct2: UIButton!
    
    @IBOutlet var img_Traslation: UIImageView!
    
    //Other
    var getImage =  UIImage()
    var index_Selected : IndexPath = IndexPath(row: 0, section: 0)
    @IBOutlet var img_Store: UIImage!
    var btn_Click: UIButton?
    var str_SaveText : String!
    var int_FlagValue : Int!
    var bool_Move : Bool = false
    
    //Image
    @IBOutlet var img_Selected: UIImageView!
    @IBOutlet var img_Cv_Word: UIImageView!
    @IBOutlet var img_Currenct: UIImageView!
    @IBOutlet var img_Speak: UIImageView!
    @IBOutlet var img_Favorite: UIImageView!
    @IBOutlet var img_Category: UIImageView!
    
    //View
    @IBOutlet var vw_Scrollview: UIView!
    @IBOutlet var vw_OtherLang: UIView!
    @IBOutlet var vw_Translation: UIView!
    @IBOutlet var vw_Category: UIView!
    
    //Scroll view
    @IBOutlet var sv_Main: UIScrollView!
    
    //Constant
    @IBOutlet var con_PopUp: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        int_FlagValue = 2
        
        vw_Category.alpha = 0.5
        btn_Category.alpha = 0.5
        //        img_Category.alpha = 0.5
        
        manageSelectedeDictionaryAsaFirst()
        self.commanMethod()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        bool_Move = true
        
        if objUser?.category_SelectedSubCat == ""{
            btn_Category.isHidden = true
            vw_Category.isHidden = true
            //            img_Category.isHidden = true
            
            btn_Category.setTitle("", for: .normal)
        }else{
            btn_Category.isHidden = false
            vw_Category.isHidden = false
            //            img_Category.isHidden = false
            
            btn_Category.setTitle("\(objUser?.category_SelectedCat as! String)/\(objUser?.category_SelectedSubCat as! String)", for: .normal)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - OCR Method -
    func base64EncodeImage(_ image: UIImage) -> String {
        var image = image
        
        var imagedata: NSData? = UIImagePNGRepresentation(image) as NSData?
        
        // Resize the image if it exceeds the 2MB API limit
        if imagedata?.length as! Int > 2097152 {
            let oldSize: CGSize = image.size
            //            let newSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            //            image = resize(image, to: newSize)
            self.img_Selected.image = image
            //            imagedata = UIImagePNGRepresentation(image) as? NSData
            imagedata = UIImagePNGRepresentation(image) as? NSData
        }
        
        let base64String = imagedata?.base64EncodedString(options: .endLineWithCarriageReturn)
        return base64String ?? ""
    }
    func resize(_ image: UIImage, to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    //MARK: - Gesture Method -
    //Called, when long press occurred
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if bool_Move == true{
            let p = sender.location(in: cv_Word)
            if let indexPath = cv_Word.indexPathForItem(at: p){
                
                let objCard : OCRSelectionObject = arr_Collection[indexPath.row] as! OCRSelectionObject
                
                var index : String = ""
                for j in 0..<arr_Main.count {
                    let obj : OCRSelectionObject = arr_Main[j] as! OCRSelectionObject
                    
                    if (obj.str_Title == objCard.str_Title) {
                        index = String(j)
                        break
                    }
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "EditWordViewController") as! EditWordViewController
                view.objGet = objCard
                view.str_Flag = String(index)
                view.delegate = self
                view.modalPresentationStyle = .custom
                view.modalTransitionStyle = .crossDissolve
                present(view, animated: true)
                
                bool_Move = false
            }
        }
    }
    
    //MARK : - Delegate Methods -
    func ClickOption(info: NSInteger) {
        if info == 1 {
            if objUser?.category_SelectedSubCat == ""{
                btn_Category.isHidden = true
                vw_Category.isHidden = true
                //                img_Category.isHidden = true
                btn_Category.setTitle("", for: .normal)
            }else{
                btn_Category.isHidden = false
                vw_Category.isHidden = false
                //                img_Category.isHidden = false
                btn_Category.setTitle("\(objUser?.category_SelectedCat as! String)/\(objUser?.category_SelectedSubCat as! String)", for: .normal)
            }
            self.cv_Word.reloadData()
        }
    }
    func ClickLanguageOption(info: NSInteger) {
        if info == 1 {
            
            index_Selected = IndexPath(row: 0, section: 0)
            //            for j in 0..<arr_Main.count {
            //                let obj : OCRSelectionObject = arr_Main[j] as! OCRSelectionObject
            //
            //                obj.str_Selected = "0"
            //                obj.str_convert = ""
            //                obj.arr_ConvertString = []
            //            }
            //            self.CreateBoxImage()
            //            self.cv_Word.reloadData()
            
            self.manageServicePresentScreenCalling()
            self.Get_SaveAllWordCheckStatus()
            
            //Manage button volume
            btn_Speak.isEnabled = false
            if objUser?.traslation_Play == "1"{
                btn_Speak.isEnabled = true
            }
            
            
            switch Int(objUser!.traslation_DictionaryName) {
            case 1?:
                img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Google")
                break
            case 2?:
                img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Lexin")
                if validationforLexinEnglishDictionaryShow() == true{
                    self.img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Lexin2")
                }
                break
            case 3?:
                img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Glosab")
                break
            default:
                break
            }
        }
    }
    func ClickDismissEditWordOption(obj: OCRSelectionObject,Flag : String) {
        bool_Move = true
        
        if Flag != ""{
            arr_Main[Int(Flag)!] = obj
            self.cv_Word.reloadData()
        }
    }
    
    
    // MARK: - Other Files -
    func commanMethod(){
        
        cv_Word.emptyDataSetDelegate = self
        cv_Word.emptyDataSetSource = self
        
        //Manage font
        btn_Category.titleLabel?.font =  UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        //        btn_Save.titleLabel?.font =  UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 17))
        
        //Code For convert for objc
        sv_Main.maximumZoomScale = 2.0
        
        sv_Main.isUserInteractionEnabled = true
        img_Selected.isUserInteractionEnabled = true
        
        img_Selected.image = getImage
        img_Selected.contentMode = .scaleAspectFit
        
        //Hide scrollview and button time of service calling
        sv_Main.isHidden = true
        //        btn_Save.isHidden = true
        cv_Word.isHidden = true
        img_Cv_Word.isHidden = true
        
        var binaryImageData: String = base64EncodeImage(img_Selected.image!)
        self.Post_OCRImage(imageData: binaryImageData)
        
        switch Int(objUser!.traslation_DictionaryName) {
        case 1?:
            img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Google")
            break
        case 2?:
            img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Lexin")
            if validationforLexinEnglishDictionaryShow() == true{
                self.img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Lexin2")
            }
            break
        case 3?:
            img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Glosab")
            break
        default:
            break
        }
    }
    
    func manageServiceCalling(){
        if objUser!.traslation_DictionaryName == "1"{
            self.Post_TraslationGoogle(strText: str_SaveText)
        }else if objUser!.traslation_DictionaryName == "2"{
            self.Post_TraslationLexin(strText: str_SaveText)
        }else if objUser!.traslation_DictionaryName == "3"{
            self.Post_TraslationGlosbe(strText: str_SaveText)
        }
    }
    func manageServicePresentScreenCalling(){
        if arr_Collection.count != 0{
            if objUser!.traslation_DictionaryName == "1"{
                self.Post_GoogleMultipleWordThisScreen()
            }else if objUser!.traslation_DictionaryName == "2"{
                self.Post_LexinMultipleWordThisScreen()
            }else if objUser!.traslation_DictionaryName == "3"{
                self.Post_GlosabyMultipleWordThisScreen()
            }
        }
    }
    func CreateBoxImage(){
        for view: UIView in img_Selected.subviews {
            view.removeFromSuperview()
        }
        img_Store = img_Selected.image
        //        img_Selected.image = modifiedImage(GetImage: img_Selected.image!)
        img_Selected.image = modifiedImage(GetImage: getImage)
    }
    func modifiedImage(GetImage: UIImage) -> UIImage {
        
        var sizeBeingScaledTo = AVMakeRect(aspectRatio: (img_Selected.image?.size)!, insideRect: CGRect(x: 0, y: 0, width: img_Selected.frame.size.width, height: img_Selected.frame.size.height))
        
        // build context to draw in
        var image = GetImage.cgImage
        let colorspace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let pixelsWide = image?.width
        
        let ctx = CGContext(data: nil, width: (image?.width)!, height:(image?.height)!, bitsPerComponent: 8, bytesPerRow: (image?.width)! * 4, space: colorspace, bitmapInfo: bitmapInfo.rawValue)
        
        // draw original image
        let r = CGRect(x: 0, y: 0, width: (image?.width)!, height: (image?.height)!)
        
        //CGRect r = CGRectMake(0, 0, 640, 640);
        ctx!.setBlendMode(.copy)
        ctx!.draw(image!, in: r)
        ctx!.setBlendMode(.normal)
        
        
        for i in 0..<arr_Main.count {
            
            let obj : OCRSelectionObject = arr_Main[i] as! OCRSelectionObject
            
            for count in 0..<4 {
                
                var rectangle1 = CGPoint.zero
                var rectangle2 = CGPoint.zero
                
                
                switch count {
                case 0:
                    rectangle1 = CGPoint(x: CGFloat((Int(obj.str_X1)! - 4)), y: CGFloat(r.size.height) - CGFloat((Int(obj.str_Y1)! + 4)))
                    
                    rectangle2 = CGPoint(x: CGFloat((Int(obj.str_X2)! + 8)), y: CGFloat(r.size.height) - CGFloat((Int(obj.str_Y2)! + 4)))
                    break
                    
                case 1:
                    
                    rectangle1 = CGPoint(x: CGFloat((Int(obj.str_X2)! + 8)), y: CGFloat(r.size.height) - CGFloat((Int(obj.str_Y2)! + 4)))
                    rectangle2 = CGPoint(x: CGFloat((Int(obj.str_X3)! + 8)), y: CGFloat(r.size.height) - CGFloat((Int(obj.str_Y3)! - 0)))
                    break
                    
                case 2:
                    rectangle1 = CGPoint(x: CGFloat((Int(obj.str_X3)! + 8)), y: CGFloat(r.size.height) - CGFloat((Int(obj.str_Y3)! - 0)))
                    rectangle2 = CGPoint(x: CGFloat((Int(obj.str_X4)! - 4)), y: CGFloat(r.size.height) - CGFloat((Int(obj.str_Y4)! - 0)))
                    break
                    
                case 3:
                    
                    rectangle1 = CGPoint(x: CGFloat((Int(obj.str_X4)! - 4)), y: CGFloat(r.size.height) - CGFloat((Int(obj.str_Y4)! - 0)))
                    rectangle2 = CGPoint(x: CGFloat((Int(obj.str_X1)! - 4)), y: CGFloat(r.size.height) - CGFloat((Int(obj.str_Y1)! + 4)))
                    break
                    
                default:
                    break
                }
                
                
                ctx?.setLineWidth(1)
                
                //                var bool_Match : Bool = false
                //                for i in 0..<arr_Main_Sub.count {
                //                     let obj2 : OCRSelectionObject = arr_Main[i] as! OCRSelectionObject
                //                    if obj2.str_Title == obj.str_Title{
                //                        bool_Match = true
                //                    }
                //                }
                
                if obj.str_Selected != "0"
                {
                    ctx?.setStrokeColor(red: 255.0 / 256.0, green: 0.0 / 256.0, blue: 0.0 / 256.0, alpha: 1.0)
                }else{
                    ctx?.setStrokeColor(red: 141.0 / 256.0, green: 180.0 / 256.0, blue: 208.0 / 256.0, alpha: 1.0)
                }
                
                ctx?.move(to: CGPoint(x: rectangle1.x, y: rectangle1.y))
                ctx?.addLine(to: CGPoint(x: rectangle2.x, y: rectangle2.y))
                ctx?.strokePath()
            }
            
            let r = CGRect(x: 0, y: 0, width: (image?.width)!, height: (image?.height)!)
            let newPoint = CGPoint(x: CGFloat((Int(obj.str_X1)! )), y: CGFloat((Int(obj.str_Y1)!)))
            var widthSet: Float = Float(CGFloat((Int(obj.str_X2)!)) - CGFloat((Int(obj.str_X1)! )))
            
            var value1 : Float = Float(CGFloat(r.size.height) - CGFloat((Int(obj.str_Y1)!)))
            var value2 : Float = Float(CGFloat(r.size.height) - CGFloat((Int(obj.str_Y4)!)))
            
            var heightSet: Float = value1 - value2
            
            var valuex : Float = Float(GlobalConstants.windowWidth) - Float(sizeBeingScaledTo.origin.x * 2)
            var valuey : Float = Float(img_Selected.frame.size.height) - Float(sizeBeingScaledTo.origin.y * 2)
            
            widthSet = Float(CGFloat(Double(widthSet) * Double(valuex)) / r.size.width)
            heightSet = Float(CGFloat(Double(heightSet) * Double(valuey)) / r.size.height)
            
            
            
            let xValue: Float = Float(CGFloat(Double(newPoint.x) * Double(valuex)) / r.size.width)
            let yValue: Float = Float(CGFloat(Double(newPoint.y) * Double(valuey)) / r.size.height)
            
            
            print("\(newPoint.x)")
            let Rect = CGRect(x: CGFloat(xValue +  Float(sizeBeingScaledTo.origin.x)), y: CGFloat(yValue +  Float(sizeBeingScaledTo.origin.y)), width: CGFloat(widthSet), height: CGFloat(heightSet))
            let btn = UIButton(frame: Rect)
            btn.backgroundColor = UIColor.clear
            btn.tag = i
            btn.addTarget(self, action:#selector(btn_BoxClick(_:)), for: .touchUpInside)
            img_Selected.addSubview(btn)
        }
        
        image = ctx?.makeImage()
        var newImage = UIImage(cgImage: image!)
        return newImage
        
        return UIImage()
    }
    
    
    func manageButtonHideShow(count : Int){
        //Manage button volume
        btn_Speak.isEnabled = false
        btn_Favorite.isEnabled = false
        img_Speak.alpha = 0.3
        img_Favorite.alpha = 0.3
        
        if objUser?.traslation_Play == "1" && count != 0{
            btn_Speak.isEnabled = true
            img_Speak.alpha = 1.0
        }
        
        if count != 0{
            btn_Favorite.isEnabled = true
            img_Favorite.alpha = 1.0
            
            vw_Category.alpha = 1.0
            btn_Category.alpha = 1.0
            //            img_Category.alpha = 1.0
            
            if index_Selected.row + 1 > count{
                index_Selected  = IndexPath(row: arr_Collection.count-2, section: 0)
//                self.cv_Word.reloadData()
            }
            
        }else{
            index_Selected  = IndexPath(row: 0, section: 0)
            vw_Category.alpha = 0.5
            btn_Category.alpha = 0.5
            //            img_Category.alpha = 0.5
        }
    }
    func increasCount() -> String{
        int_FlagValue = int_FlagValue + 1
        return String(int_FlagValue)
    }
    
    func manageArrayCollection(){
        var arr_Temp : NSMutableArray = []
        for j in 0..<arr_Main.count {
            let obj : OCRSelectionObject = arr_Main[j] as! OCRSelectionObject
            
            if (obj.str_Selected != "0") {
                obj.str_TagIndex = String(j)
                arr_Temp.add(obj)
            }
        }
        
        //second filter here
        arr_Collection = []
        for j in 1..<1000 {
            
            for k in 0..<arr_Temp.count {
                let obj : OCRSelectionObject = arr_Temp[k] as! OCRSelectionObject
                
                if (obj.str_Selected == String(j)) {
                    arr_Collection.add(obj)
                    break
                }
            }
        }
    }
    func compaireIndex(index : Int){
        let obj : OCRSelectionObject = arr_Main[index] as! OCRSelectionObject
        
        for k in 0..<arr_Collection.count {
            let obj : OCRSelectionObject = arr_Collection[k] as! OCRSelectionObject
            
            if (obj.str_Title == obj.str_Title) {
                if k < index_Selected.row{
                    index_Selected  = IndexPath(row: index_Selected.row-1, section: 0)
                }
                break
            }
        }
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Currenct(_ sender:Any){
        if objUser?.category_SelectedSubCat == ""{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
            view.bool_Home = true
            view.delegate = self
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            present(view, animated: true)
            
        }else{
            manageArrayCollection()
            
            let view = self.storyboard?.instantiateViewController(withIdentifier: "OCRresultview") as! OCRresultview
            view.arr_Get = arr_Collection
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    @IBAction func btn_ChangeLanguage(_ sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SelectLanguageViewController") as! SelectLanguageViewController
        view.delegate = self
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
        
        self.view.endEditing(true)
    }
    
    @IBAction func btn_Speak(_ sender:Any){
        let obj : OCRSelectionObject = arr_Collection[index_Selected.row] as! OCRSelectionObject
        
        //        if obj.arr_ConvertString.count != 0{
        //            playMusic(str_TraslationText : obj.arr_ConvertString[0] as! String,Language : objUser?.traslation_ToName ?? "en")
        //        }
        if obj.str_Title != ""{
            playMusic(str_TraslationText : obj.str_Title,Language : objUser?.traslation_FromName ?? "en")
        }
    }
    
    @IBAction func btn_Favorite(_ sender:Any){
        if btn_Category.isHidden == true{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
            view.bool_Home = true
            view.delegate = self
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            present(view, animated: true)
        }else{
            self.Post_Review()
            //            //Alert show for Header
            //            messageBar.MessageShow(title: "Word saved to \(objUser?.category_SelectedCat as! String)/\(objUser?.category_SelectedSubCat as! String) successfully" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
        }
    }
    
    @IBAction func btn_ChnageTranslator(_ sender:Any){
        
        if langSelectedOrNot() == true{
            //Manage Collection view object
            var arr_DictionarySelection : NSMutableArray = selectedDictionary()
            
            let ArrayTemp : NSMutableArray = []
            let ArrayTemp2 : NSMutableArray = []
            for count in 0..<arr_DictionarySelection.count{
                let obj : DictionaryManageObject = arr_DictionarySelection[count] as! DictionaryManageObject
                
                ArrayTemp.add(obj.str_TitleShow)
                ArrayTemp2.add(obj.str_IdentifierId)
            }
            
            let indexSeleted : Int = selectedIndex(arr: ArrayTemp2, value: objUser!.traslation_DictionaryName as NSString)
            
            //        let titles:Array<String> = ["Google","Lexin","Glosbe"]
            let titles:Array<String> = ArrayTemp as NSArray as! [String]
            
            //        let descriptions:Array<String> = ["description1", "", "description3","Menu3"]
            
            let popOverViewController = PopOverViewController.instantiate()
            popOverViewController.setTitles(titles)
            popOverViewController.setSelectRow(indexSeleted)
            popOverViewController.preferredContentSize = CGSize(width: 150, height:CGFloat(arr_DictionarySelection.count * 50))
            popOverViewController.presentationController?.delegate = self
            popOverViewController.popoverPresentationController?.sourceView = vw_OtherLang
            
            popOverViewController.completionHandler = { selectRow in
                
                
                //            for j in 0..<self.arr_Main.count {
                //                let obj : OCRSelectionObject = self.arr_Main[j] as! OCRSelectionObject
                //
                //                if (obj.str_Selected == "1") {
                //                    obj.str_Selected = "0"
                //                    obj.arr_ConvertString = []
                //                    self.arr_Main[j] = obj
                //                }
                //            }
                
                let obj : DictionaryManageObject = arr_DictionarySelection[selectRow] as! DictionaryManageObject
                self.Post_UpdateDictionary(str_Language : obj.str_Title)
                
                self.CreateBoxImage()
                self.cv_Word.reloadData()
                
                //Store change language option in userobject
                objUser!.traslation_DictionaryName = ArrayTemp2[selectRow] as! String
                saveCustomObject(objUser!, key: "userobject");
                
                switch Int(objUser!.traslation_DictionaryName) {
                case 1?:
                    self.img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Google")
                    break
                case 2?:
                    self.img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Lexin")
                    if objUser?.traslation_ToNameLexin as! String == "swe_eng"{
                        self.img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Lexin2")
                    }
                    break
                case 3?:
                    self.img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Glosab")
                    break
                default:
                    break
                }
                
            };
            present(popOverViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_BoxClick(_ sender:Any){
        if langSelectedOrNot() == true{
            
            btn_Click = sender as? UIButton
            print((sender as AnyObject).tag)
            
            let obj : OCRSelectionObject = arr_Main[(sender as AnyObject).tag] as! OCRSelectionObject
            
            var bool_ReloadImage : Bool = false
            if (obj.str_Selected == "0") {
                //Show alert box for traslation
                str_SaveText = obj.str_Title
                
                
                //Compaire for if alredy word is selected then not call to traslation api
                manageArrayCollection()
                
                var bool_Same : Bool = false
                for j in (0..<arr_Collection.count){
                    let obj2 : OCRSelectionObject = arr_Collection[j] as! OCRSelectionObject
                    
                    if obj2.str_Title.lowercased() == obj.str_Title.lowercased(){
                        bool_Same = true
                        break
                    }
                }
                
                if bool_Same == false{
                    self.manageServiceCalling()
                }else{
                    messageBar.MessageShow(title: "\"\(removeSpecialCharsFromString(text: obj.str_Title))\" already translated" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                }
            }
            else if (obj.str_Selected != "0") {
                bool_ReloadImage = true
                obj.arr_ConvertString = []
                obj.str_Selected = "0"
                
                self.compaireIndex(index : (sender as AnyObject).tag)
            }
            arr_Main[(sender as AnyObject).tag] = obj
            
            
            
            //If only reload image when they already selected
            if (bool_ReloadImage == true) {
                self.CreateBoxImage()
            }
            
            //Show alert box for traslation
            str_SaveText = obj.str_Title
            cv_Word.reloadData()
        }
    }
    
    @IBAction func btn_Save(_ sender:Any){
        
        if objUser?.category_SelectedSubCat == ""{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
            view.bool_Home = true
            view.delegate = self
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            present(view, animated: true)
            
        }else{
            if objUser!.traslation_DictionaryName == "1"{
                self.Post_GoogleMultipleWord()
            }else if objUser!.traslation_DictionaryName == "2"{
                self.Post_LexinMultipleWord()
            }else {
                self.Post_GlosabyMultipleWord()
            }
        }
    }
    
    @IBAction func btn_BoxClickTraslation(_ sender:Any){
        
        index_Selected = IndexPath(row: (sender as AnyObject).tag, section: 0)
        cv_Word.reloadData()
        
        var attributes: UICollectionViewLayoutAttributes? = cv_Word?.layoutAttributesForItem(at: index_Selected)
        var cellFrameInSuperview: CGRect = cv_Word.convert((attributes?.frame)!, to: cv_Word.superview)
        con_PopUp.constant = cellFrameInSuperview.origin.x + (cellFrameInSuperview.size.width/2)
        
        //        btn_Click = sender as? UIButton
        print((sender as AnyObject).tag)
        
        let obj : OCRSelectionObject = arr_Collection[(sender as AnyObject).tag] as! OCRSelectionObject
        
        //If traslation available more than one than only show popup for other traslation
        if obj.arr_ConvertString.count > 1{
            
            var height : Float = Float(obj.arr_ConvertString.count * 50)
            if height > 300{
                height = 300
            }
            
            //Convert string into string array
            let titles = obj.arr_ConvertString as NSArray as! [String]
            
            var arr_ArrowShow : NSMutableArray = []
            for i in (0..<Int(obj.arr_ConvertString.count)){
                let arr_1 : NSMutableArray = obj.arr_Traslation[i] as? NSMutableArray ?? []
                let arr_2 : NSMutableArray = obj.arr_Meaning[i] as? NSMutableArray ?? []
                let arr_3 : NSMutableArray = obj.arr_Example[i] as? NSMutableArray ?? []
                let arr_4 : NSMutableArray = obj.arr_Inflection[i] as? NSMutableArray ?? []
                let arr_5 : NSMutableArray = obj.arr_Synonym[i] as? NSMutableArray ?? []
                let arr_6 : NSMutableArray = obj.arr_AnotherWord[i] as? NSMutableArray ?? []
                
                if arr_1.count > 1 || arr_2.count > 0 || arr_3.count > 0 || arr_4.count > 0 || arr_5.count > 0 || arr_6.count > 0{
                    arr_ArrowShow.add("1")
                }else{
                    arr_ArrowShow.add("0")
                }
            }
            let arrowShow = arr_ArrowShow as NSArray as! [String]
            
            //Custome popup show
            let popOverViewController = PopOverViewController.instantiate()
            popOverViewController.setTitles(titles)
            popOverViewController.setMoreDetail(arrowShow)
            //        popOverViewController.setSelectRow(0)
            popOverViewController.preferredContentSize = CGSize(width: 200, height:Int(height))
            popOverViewController.presentationController?.delegate = self
            popOverViewController.popoverPresentationController?.sourceView = vw_Translation
            popOverViewController.completionHandler = { selectRow in
                
                if objUser?.traslation_SupportedLexin == "1" || objUser?.traslation_SupportedGlobse == "1"{
                    
                    let arr_1 : NSMutableArray = obj.arr_Traslation[selectRow] as? NSMutableArray ?? []
                    let arr_2 : NSMutableArray = obj.arr_Meaning[selectRow] as? NSMutableArray ?? []
                    let arr_3 : NSMutableArray = obj.arr_Example[selectRow] as? NSMutableArray ?? []
                    let arr_4 : NSMutableArray = obj.arr_Inflection[selectRow] as? NSMutableArray ?? []
                    let arr_5 : NSMutableArray = obj.arr_Synonym[selectRow] as? NSMutableArray ?? []
                    let arr_6 : NSMutableArray = obj.arr_AnotherWord[selectRow] as? NSMutableArray ?? []
                    
                    if arr_1.count > 1 || arr_2.count > 0 || arr_3.count > 0 || arr_4.count > 0 || arr_5.count > 0 || arr_6.count > 0{
                        
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
//                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                        appDelegate.window?.rootViewController!.present(view, animated: true, completion: nil)
//                        let navController = UINavigationController(rootViewController: view) // Creating a navigation controller with VC1 at the root of the navigation stack.
//                        self.present(navController, animated:true, completion: nil)
                    }
                    
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let view = storyboard.instantiateViewController(withIdentifier: "ExamplePopUpViewController") as! ExamplePopUpViewController
                    view.str_Title = obj.str_Title
                    view.arr_Data = [obj.str_convert,obj.str_Example == "" ? "" :"Example",obj.str_Example]
                    view.modalPresentationStyle = .custom
                    view.modalTransitionStyle = .crossDissolve
                    self.present(view, animated: true)
                }
            };
            present(popOverViewController, animated: true, completion: nil)
        }
        
    }
    @IBAction func btn_Category(_ sender:Any){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
        view.bool_Home = true
        view.delegate = self
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
    }
    
    // MARK: - Get/Post Method -
    func Post_OCRImage(imageData : String){
        
        //Declaration URL
        let strURL = "https://vision.googleapis.com/v1/images:annotate?key=\(GlobalConstants.googleImageSearch)"
        
        //Pass data in dictionary
        let jsonData = ["requests": [["image": ["content": imageData], "features": [["type": "LABEL_DETECTION", "maxResults": 10], ["type": "TEXT_DETECTION", "maxResults": 10]]]]]
        
        
        var jsonHeader : NSDictionary =  NSDictionary()
        jsonHeader = [
            "X-Ios-Bundle-Identifier" : Bundle.main.bundleIdentifier ?? "",
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "ocrimage"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData as NSDictionary
        webHelper.dictHeader = jsonHeader
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = true
        webHelper.startDownload()
    }
    
    func Post_TraslationGoogle(strText : String){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)translate_google"
        
        let arr_Comment : NSMutableArray = []
        
        //Save data in dictionary
        let dict_Store : NSDictionary = [
            "word" : removeSpecialCharsFromString(text: strText),
            ]
        arr_Comment.add(dict_Store)
        
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "from_language" : objUser?.traslation_FromName ?? "0",
        ]
        
        
        jsonData.setValue(objUser?.traslation_ToName ?? "0", forKey: "to_language")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "ocrgoogleconvert"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    func Post_GoogleMultipleWord(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)translate_google"
        
        let arr_Comment : NSMutableArray = []
        for i in (0..<Int(arr_Main.count)){
            let objCard : OCRSelectionObject = arr_Main[i] as! OCRSelectionObject
            
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title),
                ]
            arr_Comment.add(dict_Store)
        }
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "from_language" : objUser?.traslation_FromName ?? "0",
        ]
        
        
        jsonData.setValue(objUser?.traslation_ToName ?? "0", forKey: "to_language")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "translate_google"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    func Post_GoogleMultipleWordThisScreen(){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)translate_google"
        
        //selected word
        self.manageArrayCollection()
        
        let arr_Comment : NSMutableArray = []
        for i in (0..<Int(arr_Collection.count)){
            let objCard : OCRSelectionObject = arr_Collection[i] as! OCRSelectionObject
            
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title),
                ]
            arr_Comment.add(dict_Store)
        }
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "from_language" : objUser?.traslation_FromName ?? "0",
        ]
        
        
        jsonData.setValue(objUser?.traslation_ToName ?? "0", forKey: "to_language")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "translate_google_thisscreen"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    
    func Post_TraslationGlosbe(strText : String){
        
        
        //Declaration URL
        var strURL = "\(GlobalConstants.BaseURL)translate_glosbe_new"
        
        let arr_Comment : NSMutableArray = []
        //Save data in dictionary
        let dict_Store : NSDictionary = [
            "word" : removeSpecialCharsFromString(text: strText.lowercased()),
            ]
        arr_Comment.add(dict_Store)
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "from_language" : objUser?.traslation_FromNameGlobse ?? "0",
        ]
        
        jsonData.setValue(objUser?.traslation_ToNameGlobse ?? "0", forKey: "to_language")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "ocrglosbeconvert"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    
    
    func Post_UpdateDictionary(str_Language : String){
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)update_dictionary"
        
        //Pass data in dictionary
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "dictionary_name" : str_Language,
        ]
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "update_dictionary"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    func Post_Review(){
        
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)add_card"
        
        //make array for image comment
        let arr_Comment : NSMutableArray = []
        let arr_Image : NSMutableArray = []
        let arr_ImageType : NSMutableArray = []
        let arr_ImageName : NSMutableArray = []
        
        
        
        let objCard : OCRSelectionObject = arr_Collection[index_Selected.row] as! OCRSelectionObject
        
        //Create array for meaning
        var arr_Meaning : NSMutableArray = []
        for j in (0..<Int(objCard.arr_ConvertString.count)){
            let dict_Store : NSDictionary = [
                "meaning" : objCard.arr_ConvertString[j],
                ]
            arr_Meaning.add(dict_Store)
        }
        
        //Save data in dictionary
        let dict_Store : NSDictionary = [
            "word" : removeSpecialCharsFromString(text: objCard.str_Title),
            "meaning_array" : arr_Meaning,
            "is_replace" : objCard.str_CardID == "0" ? "0" : "1",
            "card_id" : objCard.str_CardID,
            ]
        arr_Comment.add(dict_Store)
        
        objCard.str_Image = GlobalConstants.img_Temp as String
        if objCard.str_Image != ""{
            //Image save in array
            let url = URL(string: objCard.str_Image as! String)
            
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let image_Save : UIImage = UIImage(data: data!)!
            let imgData = UIImageJPEGRepresentation(image_Save, 0.75)
            
            arr_Image.add(imgData)
            arr_ImageType.add("photo")
            arr_ImageName.add("image0")
        }else{
            arr_Image.add("")
            arr_ImageType.add("photo")
            arr_ImageName.add("image0")
        }
        
        
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID ?? "0",
            "keyword" : string ?? "",
            "category_id" : objUser?.category_SelectedCatId ?? "0",
            "sub_category_id" : objUser?.category_SelectedSubCatId ?? "0",
            "from_language_id" : objUser?.traslation_FromId ?? "0",
            "dictionary_id" : objUser?.traslation_DictionaryName ?? "0",
            "store_type" : "0",
        ]
        
        jsonData.setValue(objUser?.traslation_ToID ?? "0", forKey: "to_language_id")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "add_card"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = true
        webHelper.arr_MutlipleimagesAndVideo = arr_Image
        webHelper.arr_MutlipleimagesAndVideoType = arr_ImageType
        webHelper.arr_MutlipleimagesAndVideoName = arr_ImageName
        webHelper.imageUploadName = "image"
        webHelper.startUploadingMultipleImagesAndVideo()
    }
    
    func Get_SaveAllWordCheckStatus(){
        
        
        //Declaration URL
        let strURL = "\(GlobalConstants.BaseURL)check_card"
        
        //make array for image comment
        let arr_Comment : NSMutableArray = []
        let arr_Image : NSMutableArray = []
        let arr_ImageType : NSMutableArray = []
        let arr_ImageName : NSMutableArray = []
        
        
        for i in (0..<Int(arr_Main.count)){
            
            let objCard : OCRSelectionObject = arr_Main[i] as! OCRSelectionObject
            
            //Create array for meaning
            var arr_Meaning : NSMutableArray = []
            for j in (0..<Int(objCard.arr_ConvertString.count)){
                let dict_Store : NSDictionary = [
                    "meaning" : objCard.arr_ConvertString[j],
                    ]
                arr_Meaning.add(dict_Store)
            }
            
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title.lowercased()),
                "meaning_array" : arr_Meaning,
                ]
            arr_Comment.add(dict_Store)
        }
        
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID ?? "0",
            "keyword" : string ?? "",
            "category_id" : objUser?.category_SelectedCatId ?? "0",
            "sub_category_id" : objUser?.category_SelectedSubCatId ?? "0",
            "from_language_id" : objUser?.traslation_FromId ?? "0",
            "dictionary_id" : objUser?.traslation_DictionaryName ?? "0",
        ]
        
        jsonData.setValue(objUser?.traslation_ToID ?? "0", forKey: "to_language_id")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "check_card"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.arr_MutlipleimagesAndVideo = arr_Image
        webHelper.arr_MutlipleimagesAndVideoType = arr_ImageType
        webHelper.arr_MutlipleimagesAndVideoName =
        arr_ImageName
        webHelper.imageUploadName = "image"
        webHelper.startUploadingMultipleImagesAndVideo()
    }
    
    func Post_TraslationLexin(strText : String){
        
        if strText != ""{
            
            //Declaration URL
            var strURL = "\(GlobalConstants.BaseURL)translate_lexin"
            if validationforLexinEnglishDictionaryShow() == true{
                strURL = "\(GlobalConstants.BaseURL)translate_lexin_english"
            }
            
            //Create array for meaning
            var arr_Meaning : NSMutableArray = []
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: strText.lowercased()),
                ]
            arr_Meaning.add(dict_Store)
            
            //Convert array in string
            let string = notPrettyString(from : arr_Meaning)
            
            
            //Pass data in dictionary
            var jsonData : NSDictionary =  NSDictionary()
            jsonData = [
                "user_id" : objUser?.user_UserID,
                //                "to_language" : "\(objUser?.traslation_FromName as! String)_\(objUser?.traslation_ToName as! String)",
                "to_language" : objUser?.traslation_ToNameLexin as! String,
                "keyword" : string,
            ]
            
            //Create object for webservicehelper and start to call method
            let webHelper = WebServiceHelper()
            webHelper.strMethodName = "translate_lexin"
            webHelper.methodType = "post"
            webHelper.strURL = strURL
            webHelper.dictType = jsonData
            webHelper.dictHeader = NSDictionary()
            webHelper.delegateWeb = self
            webHelper.serviceWithAlert = false
            webHelper.startDownload()
        }
    }
    
    
    
    func Post_LexinMultipleWord(){
        
        //Declaration URL
        var strURL = "\(GlobalConstants.BaseURL)translate_lexin"
        if validationforLexinEnglishDictionaryShow() == true{
            strURL = "\(GlobalConstants.BaseURL)translate_lexin_english"
        }
        
        let arr_Comment : NSMutableArray = []
        for i in (0..<Int(arr_Main.count)){
            let objCard : OCRSelectionObject = arr_Main[i] as! OCRSelectionObject
            
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title.lowercased()),
                ]
            arr_Comment.add(dict_Store)
        }
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "to_language" : objUser?.traslation_ToNameLexin as! String,
        ]
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "translate_lexin2"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    
    func Post_LexinMultipleWordThisScreen(){
        
        //Declaration URL
        var strURL = "\(GlobalConstants.BaseURL)translate_lexin"
        if validationforLexinEnglishDictionaryShow() == true{
            strURL = "\(GlobalConstants.BaseURL)translate_lexin_english"
        }
        
        
        //selected word
        self.manageArrayCollection()
        
        
        let arr_Comment : NSMutableArray = []
        for i in (0..<Int(arr_Collection.count)){
            let objCard : OCRSelectionObject = arr_Collection[i] as! OCRSelectionObject
            
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title.lowercased()),
                ]
            arr_Comment.add(dict_Store)
        }
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "to_language" : objUser?.traslation_ToNameLexin as! String,
        ]
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "translate_lexin2_Multiple"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    
    func Post_GlosabyMultipleWord(){
        
        //Declaration URL
        var strURL = "\(GlobalConstants.BaseURL)translate_glosbe_new"
        
        let arr_Comment : NSMutableArray = []
        for i in (0..<Int(arr_Main.count)){
            let objCard : OCRSelectionObject = arr_Main[i] as! OCRSelectionObject
            
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title.lowercased()),
                ]
            arr_Comment.add(dict_Store)
        }
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "from_language" : objUser?.traslation_FromNameGlobse ?? "0",
        ]
        
        jsonData.setValue(objUser?.traslation_ToNameGlobse ?? "0", forKey: "to_language")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "translate_glosbe"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
        webHelper.startDownload()
    }
    func Post_GlosabyMultipleWordThisScreen(){
        
        //Declaration URL
        var strURL = "\(GlobalConstants.BaseURL)translate_glosbe_new"
        
        self.manageArrayCollection()
        
        
        let arr_Comment : NSMutableArray = []
        for i in (0..<Int(arr_Collection.count)){
            let objCard : OCRSelectionObject = arr_Collection[i] as! OCRSelectionObject
            
            //Save data in dictionary
            let dict_Store : NSDictionary = [
                "word" : removeSpecialCharsFromString(text: objCard.str_Title.lowercased()),
                ]
            arr_Comment.add(dict_Store)
        }
        
        //Convert array in string
        let string = notPrettyString(from : arr_Comment)
        
        //Pass data in dictionary
        var jsonData : NSMutableDictionary =  NSMutableDictionary()
        jsonData = [
            "user_id" : objUser?.user_UserID,
            "keyword" : string,
            "from_language" : objUser?.traslation_FromNameGlobse ?? "0",
        ]
        
        jsonData.setValue(objUser?.traslation_ToNameGlobse ?? "0", forKey: "to_language")
        
        
        //Create object for webservicehelper and start to call method
        let webHelper = WebServiceHelper()
        webHelper.strMethodName = "translate_glosbe_Multiple"
        webHelper.methodType = "post"
        webHelper.strURL = strURL
        webHelper.dictType = jsonData
        webHelper.dictHeader = NSDictionary()
        webHelper.delegateWeb = self
        webHelper.serviceWithAlert = false
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

// MARK: - Scrollview Delegate -

extension OCRSelectionViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return vw_Scrollview
    }
    
}


//MARK: - Object Decalration -
class OCRSelectionObject: NSObject {
    
    //Image Draw
    var str_X1 : String = ""
    var str_X2 : String = ""
    var str_X3 : String = ""
    var str_X4 : String = ""
    
    var str_Y1 : String = ""
    var str_Y2 : String = ""
    var str_Y3 : String = ""
    var str_Y4 : String = ""
    
    var str_Selected : String = ""
    var str_ConvertOrNot : String = ""
    var str_TagIndex : String = ""
    
    var str_SaveOrNot : String = ""
    var str_CardID : String = ""
    
    //Service Get
    var str_Title : String = ""
    var str_convert : String = ""
    
    var str_Example : String = ""
    var str_IsDeleted : String = ""
    var str_ID : String = ""
    
    var data_ImageData: NSData? = nil
    
    var arr_ConvertString : NSMutableArray = []
    
    var str_Image : String = ""
    
    var str_CatSave : String = "Cat/SubCat"
    var str_Level : String = "3"
    
    var arr_Traslation: NSMutableArray = []
    var arr_Meaning: NSMutableArray = []
    var arr_Example: NSMutableArray = []
    var arr_Inflection: NSMutableArray = []
    var arr_Image: NSMutableArray = []
    var arr_Synonym: NSMutableArray = []
    var arr_AnotherWord: NSMutableArray = []
    
    //Flag Defaul
    var is_CardFront: Bool = true
    var str_CardSaveFlag: String = "-1"
    var data_Image : NSData? = nil
    
}

class OCRSelectionCollectionCell : UICollectionViewCell {
    
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var lbl_TitleConvert: UILabel!
    
    @IBOutlet var img_Hint: UIImageView!
    @IBOutlet var img_Fav: UIImageView!
    @IBOutlet var Img_Selected: UIImageView!
    @IBOutlet var Img_Selected2: UIImageView!
    
    
    @IBOutlet var btn_OtherMeaning: UIButton!
    
    
    @IBOutlet var vw_Bottom: UIView!
}

//MARK: - Collection View -
extension OCRSelectionViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberCount: Int = 0
        for j in 0..<arr_Main.count {
            let obj : OCRSelectionObject = arr_Main[j] as! OCRSelectionObject
            
            if (obj.str_Selected != "0") {
                numberCount = numberCount + 1
            }
        }
        if numberCount == 0 {
            img_Cv_Word.isHidden = true
            //            btn_Save.isEnabled = true
            //            btn_Save.setTitle("CHECK ALL", for: .normal)
        }
        else {
            img_Cv_Word.isHidden = false
            
            if numberCount == 1 {
                //                btn_Save.setTitle("CHECK ALL", for: .normal)
            }
            else {
                //                btn_Save.setTitle("CHECK ALL", for: .normal)
            }
            //            btn_Save.isEnabled = true
        }
        
        //Button Accept ValidationAccept
        if numberCount == 0{
            btn_Currenct.isUserInteractionEnabled = false
            img_Currenct.alpha = 0.5
            btn_Currenct2.isUserInteractionEnabled = false
        }else{
            btn_Currenct.isUserInteractionEnabled = true
            img_Currenct.alpha = 1.0
            btn_Currenct2.isUserInteractionEnabled = true
        }
        
        manageButtonHideShow(count : numberCount)
        
        return numberCount
        
        //            return arr_Main.count
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        self.manageArrayCollection()
        
        
        let obj : OCRSelectionObject = arr_Collection[indexPath.row] as! OCRSelectionObject
        
        let starWidth = obj.str_Title.widthOfString(usingFont: UIFont(name:  GlobalConstants.kFontSemiBold, size: manageFont(font: 15))!)
        var starWidth2 : CGFloat = 0
        if obj.arr_ConvertString.count != 0{
            starWidth2 = (obj.arr_ConvertString[0] as! String).widthOfString(usingFont: UIFont(name:  GlobalConstants.kFontSemiBold, size: manageFont(font: 15))!)
        }
        
        if starWidth + 40 > starWidth2 + 20{
            return CGSize(width: starWidth + 40, height: collectionView.frame.size.height)
        }
        
        return CGSize(width: starWidth2 + 20, height: collectionView.frame.size.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OCRSelectionCollectionCell
        
        //Long Press
        let tapGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        tapGesture2.view?.tag = indexPath.row
        cell.addGestureRecognizer(tapGesture2)
        
        self.manageArrayCollection()
        
        let obj : OCRSelectionObject = arr_Collection[indexPath.row] as! OCRSelectionObject
        
        cell.lbl_Title.text = obj.str_Title
        
        if obj.arr_ConvertString.count != 0{
            cell.lbl_TitleConvert.text = obj.arr_ConvertString[0] as! String
        }
        
        cell.img_Fav.isHidden = true
        cell.img_Hint.isHidden = true
        cell.Img_Selected.isHidden = true
        cell.Img_Selected2.isHidden = true
        
        if index_Selected.row == indexPath.row {
            //            cell.img_Hint.isHidden = false
            //            cell.Img_Selected2.isHidden = false
            
            cell.Img_Selected.isHidden = false
        }
        
        //If traslation available more than one than only show popup for other traslation
        if obj.arr_ConvertString.count > 1{
            cell.img_Hint.isHidden = false
        }
        
        cell.img_Fav.image = UIImage(named:"icon_SaveBlck")
        
        if obj.str_SaveOrNot == "-1"{ // Not Saved
            cell.img_Fav.image = UIImage(named:"icon_SaveBlck")
        }else if obj.str_SaveOrNot == "0"{ //Personally Save
            cell.img_Fav.image = UIImage(named:"icon_SaveYello")
        }else if obj.str_SaveOrNot == "1"{ //All Saved
            cell.img_Fav.image = UIImage(named:"icon_SaveBlck_S")
        }
        
        cell.img_Fav.isHidden = false
        //        if obj.str_SaveOrNot == "1"{
        //            cell.img_Fav.isHidden = false
        //        }
        
        //Manage font
        cell.lbl_Title.font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 15))
        cell.lbl_TitleConvert.font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 15))
        
        cell.btn_OtherMeaning.tag = indexPath.row
        cell.btn_OtherMeaning.addTarget(self, action:#selector(btn_BoxClickTraslation(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index_Selected = indexPath
        cv_Word.reloadData()
        
        var attributes: UICollectionViewLayoutAttributes? = collectionView.layoutAttributesForItem(at: indexPath)
        var cellFrameInSuperview: CGRect = cv_Word.convert((attributes?.frame)!, to: cv_Word.superview)
        var frameX = cellFrameInSuperview.origin.x + cellFrameInSuperview.size.width
        var frameX2 = cellFrameInSuperview.origin.x
        if frameX > CGFloat(GlobalConstants.windowWidth){
            self.cv_Word?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.right, animated: true)
        }else{
            if frameX2 < 0{
                self.cv_Word?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
            }
        }
        
    }
}

extension OCRSelectionViewController: EmptyDataSetSource,EmptyDataSetDelegate {
    //  func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
    //    return UIImage.init(named: "img_Add")
    //  }
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var text: String?
        var font: UIFont?
        var textColor: UIColor?
        
        text = "No word selected"
        font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 20))
        //    textColor = GlobalConstants.noDataColor
        textColor = UIColor.lightGray
        
        if text == nil {
            return nil
        }
        var attributes: [NSAttributedStringKey: Any] = [:]
        
        if font != nil {
            attributes[NSAttributedStringKey.font] = font!
        }
        if textColor != nil {
            attributes[NSAttributedStringKey.foregroundColor] = textColor
        }
        return NSAttributedString.init(string: text!, attributes: attributes)
        
    }
}



extension OCRSelectionViewController : WebServiceHelperDelegate{
    
    
    //MARK: - Webservice Helper -
    func appDataDidSuccess(_ data: Any, request strRequest: String) {
        
        let response = data as! NSDictionary
        if strRequest == "ocrimage"{
            
            //Show scrollview and button
            sv_Main.isHidden = false
            //            btn_Save.isHidden = false
            cv_Word.isHidden = false
            
            let arr_Resonse = response["responses"] as! NSArray
            let responseData = arr_Resonse[0] as! NSDictionary
            
            let dict_FullTextAnnotation : NSDictionary = responseData["fullTextAnnotation"] as? NSDictionary ?? [:]
            
            if dict_FullTextAnnotation != [:]{
                let str_Text : String = dict_FullTextAnnotation["text"] as! String
                //            let arr_Text = str_Text.components(separatedBy:"") as! NSArray
                
                arr_Main = []
                
                let arr_TextAnnotaion = responseData["textAnnotations"] as! NSArray
                for count in 1..<arr_TextAnnotaion.count {
                    
                    let Dict_TextAnnotations = arr_TextAnnotaion[count] as! NSDictionary
                    let Dict_boundingPoly = Dict_TextAnnotations["boundingPoly"] as! NSDictionary
                    let arr_vertices = Dict_boundingPoly["vertices"] as! NSArray
                    
                    let dict_X = arr_vertices[0] as! NSDictionary
                    let dict_Y = arr_vertices[0] as! NSDictionary
                    let dict_X1 = arr_vertices[1] as! NSDictionary
                    let dict_Y1 = arr_vertices[1] as! NSDictionary
                    let dict_X2 = arr_vertices[2] as! NSDictionary
                    let dict_Y2 = arr_vertices[2] as! NSDictionary
                    let dict_X3 = arr_vertices[3] as! NSDictionary
                    let dict_Y3 = arr_vertices[3] as! NSDictionary
                    
                    if dict_X["x"] != nil && dict_Y["y"] != nil && dict_X1["x"] != nil && dict_Y1["y"] != nil && dict_X2["x"] != nil && dict_Y2["y"] != nil && dict_X3["x"] != nil && dict_Y3["y"] != nil {
                        
                        let obj = OCRSelectionObject()
                        
                        obj.str_X1 = String(dict_X["x"] as! Int)
                        obj.str_X2 = String(dict_X1["x"] as! Int)
                        obj.str_X3 = String(dict_X2["x"] as! Int)
                        obj.str_X4 = String(dict_X3["x"] as! Int)
                        
                        obj.str_Y1 = String(dict_X["y"] as! Int)
                        obj.str_Y2 = String(dict_X1["y"] as! Int)
                        obj.str_Y3 = String(dict_X2["y"] as! Int)
                        obj.str_Y4 = String(dict_X3["y"] as! Int)
                        
                        obj.str_Title = removeSpecialCharsFromString(text: Dict_TextAnnotations["description"] as! String)
                        obj.str_convert = removeSpecialCharsFromString(text: Dict_TextAnnotations["description"] as! String)
                        obj.str_Selected = "0"
                        obj.str_ConvertOrNot = ""
                        
                        obj.str_SaveOrNot = "-1"
                        obj.str_Image = ""
                        
                        if obj.str_Title != ""{
                            arr_Main.add(obj)
                        }
                    }
                }
                
                self.CreateBoxImage()
                self.Get_SaveAllWordCheckStatus()
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }else if strRequest == "ocrgoogleconvert"{
            let arr_Translation = response["translation"] as! NSArray
            
            let obj : OCRSelectionObject = arr_Main[btn_Click!.tag] as! OCRSelectionObject
            
            let dict_Translation = arr_Translation[0] as! NSDictionary
            
            let arr_Image = dict_Translation["image_array"] as! NSArray
            //Image set
            if arr_Image.count != 0{
                obj.str_Image = arr_Image[0] as! String
            }
            
            obj.arr_ConvertString = []
            
            obj.str_Title = dict_Translation["word"] as! String
            
            obj.str_convert = dict_Translation["translation"] as! String
            
            obj.arr_ConvertString.add(dict_Translation["translation"] as! String)
            
            
            var bool_ReloadImage : Bool = false
            if dict_Translation["translation"] as! String == ""{
                messageBar.MessageShow(title: "The word \"\(dict_Translation["word"] as! String)\" is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }else{
                obj.str_Selected = increasCount()
                arr_Main[btn_Click!.tag] = obj
                bool_ReloadImage = true
                
                
                let when3 = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when3) {
                    var item = self.collectionView(self.cv_Word!, numberOfItemsInSection: 0) - 1
                    var lastItemIndex : NSIndexPath = NSIndexPath(row: item, section: 0)
                    self.cv_Word?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.right, animated: true)
                }
            }
            
            self.manageArrayCollection()
            index_Selected = IndexPath(row: arr_Collection.count - 1, section: 0)
            
            cv_Word.reloadData()
            //Reload image when get result with string
            if bool_ReloadImage == true{
                self.CreateBoxImage()
            }
            
        }else if strRequest == "translate_google"{
            let arr_Translation = response["translation"] as! NSArray
            
            for count in 0..<arr_Translation.count {
                let obj : OCRSelectionObject = arr_Main[count] as! OCRSelectionObject
                
                var bool_Value : Bool = true
                for k in 0..<count {
                    let objLocal : OCRSelectionObject = arr_Main[k] as! OCRSelectionObject
                    if objLocal.str_Title == obj.str_Title{
                        bool_Value = false
                    }
                }
                
                var bool_match : Bool = false
                if bool_Value == true{
                    let dict_Translation = arr_Translation[count] as! NSDictionary
                    
                    let arr_Image = dict_Translation["image_array"] as! NSArray
                    //Image set
                    if arr_Image.count != 0{
                        obj.str_Image = arr_Image[0] as! String
                    }
                    
                    obj.arr_ConvertString = []
                    
                    obj.str_Title = dict_Translation["word"] as! String
                    
                    obj.str_convert = dict_Translation["translation"] as! String
                    
                    obj.arr_ConvertString.add(dict_Translation["translation"] as! String)
                    
                    if dict_Translation["translation"] as! String != ""{
                        
                        bool_match = true
                        obj.str_Selected = increasCount()
                        arr_Main[count] = obj;
                    }
                }
            }
            cv_Word.reloadData()
            
            manageArrayCollection()
            
             if arr_Collection.count != 0{
                let view = self.storyboard?.instantiateViewController(withIdentifier: "OCRresultview") as! OCRresultview
                view.arr_Get = arr_Collection
                self.navigationController?.pushViewController(view, animated: true)
            }else{
                messageBar.MessageShow(title: "The words are not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
            
        }else if strRequest == "translate_google_thisscreen"{
            let arr_Translation = response["translation"] as! NSArray
            
            for count in 0..<arr_Collection.count {
                let objTemp : OCRSelectionObject = arr_Collection[count] as! OCRSelectionObject
                
                let obj : OCRSelectionObject = arr_Main[Int(objTemp.str_TagIndex)!] as! OCRSelectionObject
                
                
                let dict_Translation = arr_Translation[count] as! NSDictionary
                
                let arr_Image = dict_Translation["image_array"] as! NSArray
                //Image set
                if arr_Image.count != 0{
                    obj.str_Image = arr_Image[0] as! String
                }
                
                obj.arr_ConvertString = []
                
                obj.str_Title = dict_Translation["word"] as! String
                
                obj.str_convert = dict_Translation["translation"] as! String
                
                obj.arr_ConvertString.add(dict_Translation["translation"] as! String)
                
                obj.str_Selected = "0"
                if dict_Translation["translation"] as! String != ""{
                    
                    obj.str_Selected = increasCount()
                }
                arr_Main[Int(objTemp.str_TagIndex)!] = obj;
            }
            cv_Word.reloadData()
            
        }else if strRequest == "ocrglosbeconvert"{
            
            let arr_responseData = response["result"] as! NSArray
            
            let dict_response = arr_responseData[0] as! NSDictionary
            
            let arr_Translation = dict_response["translate_array"] as! NSArray
            let arr_Meaning = dict_response["meaning_array"] as! NSArray
            let arr_Example = dict_response["exmaple_array"] as! NSArray
            let arr_Image = dict_response["image_array"] as! NSArray
            
            let obj : OCRSelectionObject = arr_Main[btn_Click!.tag] as! OCRSelectionObject
            obj.arr_Traslation = []
            obj.arr_Meaning = []
            obj.arr_Example = []
            obj.arr_Inflection = []
            obj.arr_Image = []
            obj.arr_Synonym = []
            obj.arr_AnotherWord = []
            obj.arr_ConvertString = []
            
            
            var bool_ReloadImage : Bool = false
            if arr_Translation.count != 0{
                
                for count in 0..<arr_Translation.count {
                    //Traslation
                    let arr_Translation2 = arr_Translation[count] as! NSArray
                    
                    if arr_Translation2.count != 0{
                        bool_ReloadImage = true
                        
                        var arr_Temp : NSMutableArray = []
                        for count2 in 0..<arr_Translation2.count {
                            arr_Temp.add(arr_Translation2[count2] as! String)
                        }
                        obj.arr_Traslation.add(arr_Temp)
                        
                        obj.arr_ConvertString.add(arr_Translation2[0] as! String)
                    }else{
                        obj.arr_Traslation.add([])
                        obj.arr_ConvertString.add("")
                    }
                    
                    //Traslation
                    let arr_Meaning2 = arr_Meaning[count] as! NSArray
                    
                    if arr_Meaning2.count != 0{
                        
                        var arr_Temp : NSMutableArray = []
                        for count2 in 0..<arr_Meaning2.count {
                            arr_Temp.add(arr_Meaning2[count2] as! String)
                        }
                        obj.arr_Meaning.add(arr_Temp)
                    }else{
                        obj.arr_Meaning.add([])
                    }
                    
                    obj.arr_Example.add([])
                    obj.arr_Inflection.add([])
                    obj.arr_Image.add([])
                    obj.arr_Synonym.add([])
                    obj.arr_AnotherWord.add([])
                }
                
                //Image set
                if arr_Image.count != 0{
                    obj.str_Image = arr_Image[0] as! String
                }
                
                if bool_ReloadImage == false{
                    messageBar.MessageShow(title: "The word \"\(dict_response["word"] as! String)\" is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                }else{
                    obj.str_Selected = increasCount()
                    arr_Main[btn_Click!.tag] = obj;
                    
                    let when3 = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when3) {
                        var item = self.collectionView(self.cv_Word!, numberOfItemsInSection: 0) - 1
                        var lastItemIndex : NSIndexPath = NSIndexPath(row: item, section: 0)
                        self.cv_Word?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.right, animated: true)
                    }
                }
            }
            
            self.manageArrayCollection()
            index_Selected = IndexPath(row: arr_Collection.count - 1, section: 0)
            
            cv_Word.reloadData()
            //Reload image when get result with string
            if bool_ReloadImage == true{
                self.CreateBoxImage()
            }else{
                 messageBar.MessageShow(title: "The word \"\(dict_response["word"] as! String)\" is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
            
        }else if strRequest == "translate_glosbe"{
            let arr_responseData = response["result"] as! NSArray
            
            for j in 0..<arr_responseData.count {
                let dict_response = arr_responseData[j] as! NSDictionary
                
                let arr_Translation = dict_response["translate_array"] as! NSArray
                let arr_Meaning = dict_response["meaning_array"] as! NSArray
                let arr_Example = dict_response["exmaple_array"] as! NSArray
                let arr_Image = dict_response["image_array"] as! NSArray
                
                let obj : OCRSelectionObject = arr_Main[j] as! OCRSelectionObject
                
                var bool_Value : Bool = true
                for k in 0..<j {
                    let objLocal : OCRSelectionObject = arr_Main[k] as! OCRSelectionObject
                    if objLocal.str_Title == obj.str_Title{
                        bool_Value = false
                    }
                }
                
                var bool_match : Bool = false
                if bool_Value == true{
                    //Image set
                    if arr_Image.count != 0{
                        obj.str_Image = arr_Image[0] as! String
                    }
                    
                    obj.arr_Traslation = []
                    obj.arr_Meaning = []
                    obj.arr_Example = []
                    obj.arr_Inflection = []
                    obj.arr_Image = []
                    obj.arr_Synonym = []
                    obj.arr_AnotherWord = []
                    obj.arr_ConvertString = []
                    
                    
                    for count in 0..<arr_Translation.count {
                        //Traslation
                        let arr_Translation2 = arr_Translation[count] as! NSArray
                        
                        if arr_Translation2.count != 0{
                            bool_match = true
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Translation2.count {
                                arr_Temp.add(arr_Translation2[count2] as! String)
                            }
                            obj.arr_Traslation.add(arr_Temp)
                            
                            obj.arr_ConvertString.add(arr_Translation2[0] as! String)
                        }else{
                            obj.arr_Traslation.add([])
                            obj.arr_ConvertString.add("")
                        }
                        
                        for count in 0..<arr_Meaning.count {
                            //Traslation
                            let arr_Meaning2 = arr_Meaning[count] as! NSArray
                            
                            if arr_Meaning2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Meaning2.count {
                                    arr_Temp.add(arr_Meaning2[count2] as! String)
                                }
                                obj.arr_Meaning.add(arr_Temp)
                            }else{
                                obj.arr_Meaning.add([])
                            }
                        }
                        
                        obj.arr_Example.add([])
                        obj.arr_Inflection.add([])
                        obj.arr_Image.add([])
                        obj.arr_Synonym.add([])
                        obj.arr_AnotherWord.add([])
                    }
                    
                    
                    if obj.arr_ConvertString.count != 0{
                        obj.str_Selected = increasCount()
                        arr_Main[j] = obj;
                    }
                }
            }
            cv_Word.reloadData()
            
            manageArrayCollection()
            
              if arr_Collection.count != 0{
                let view = self.storyboard?.instantiateViewController(withIdentifier: "OCRresultview") as! OCRresultview
                view.arr_Get = arr_Collection
                self.navigationController?.pushViewController(view, animated: true)
            }else{
                messageBar.MessageShow(title: "The words are not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
            
        }else if strRequest == "translate_glosbe_Multiple"{
            let arr_responseData = response["result"] as! NSArray
            
            for j in 0..<arr_responseData.count {
                let dict_response = arr_responseData[j] as! NSDictionary
                
                let arr_Translation = dict_response["translate_array"] as! NSArray
                let arr_Meaning = dict_response["meaning_array"] as! NSArray
                let arr_Example = dict_response["exmaple_array"] as! NSArray
                let arr_Image = dict_response["image_array"] as! NSArray
                
                let objTemp : OCRSelectionObject = arr_Collection[j] as! OCRSelectionObject
                let obj : OCRSelectionObject = arr_Main[Int(objTemp.str_TagIndex)!] as! OCRSelectionObject
                
                
                //Image set
                if arr_Image.count != 0{
                    obj.str_Image = arr_Image[0] as! String
                }
                
                obj.arr_Traslation = []
                obj.arr_Meaning = []
                obj.arr_Example = []
                obj.arr_Inflection = []
                obj.arr_Image = []
                obj.arr_Synonym = []
                obj.arr_AnotherWord = []
                obj.arr_ConvertString = []
                
                
                for count in 0..<arr_Translation.count {
                    //Traslation
                    let arr_Translation2 = arr_Translation[count] as! NSArray
                    
                    if arr_Translation2.count != 0{
                        
                        var arr_Temp : NSMutableArray = []
                        for count2 in 0..<arr_Translation2.count {
                            arr_Temp.add(arr_Translation2[count2] as! String)
                        }
                        obj.arr_Traslation.add(arr_Temp)
                        
                        obj.arr_ConvertString.add(arr_Translation2[0] as! String)
                    }else{
                        obj.arr_Traslation.add([])
                        obj.arr_ConvertString.add("")
                    }
                    
                    //Traslation
                    let arr_Meaning2 = arr_Meaning[count] as! NSArray
                    
                    if arr_Meaning2.count != 0{
                        
                        var arr_Temp : NSMutableArray = []
                        for count2 in 0..<arr_Meaning2.count {
                            arr_Temp.add(arr_Meaning2[count2] as! String)
                        }
                        obj.arr_Meaning.add(arr_Temp)
                    }else{
                        obj.arr_Meaning.add([])
                    }
                    
                    obj.arr_Example.add([])
                    obj.arr_Inflection.add([])
                    obj.arr_Image.add([])
                    obj.arr_Synonym.add([])
                    obj.arr_AnotherWord.add([])
                }
                
                obj.str_Selected = "0"
                if obj.arr_ConvertString.count != 0{
                    obj.str_Selected = increasCount()
                    
                }
                arr_Main[Int(objTemp.str_TagIndex)!] = obj;
            }
           
            manageArrayCollection()
            
            if arr_Collection.count != 0{
//                let view = self.storyboard?.instantiateViewController(withIdentifier: "OCRresultview") as! OCRresultview
//                view.arr_Get = arr_Collection
//                self.navigationController?.pushViewController(view, animated: true)
            }else{
                messageBar.MessageShow(title: "The words are not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
            
            cv_Word.reloadData()
            self.CreateBoxImage()
            
        }
        else if strRequest == "translate_lexin"{
            let arr_responseData = response["result"] as! NSArray
            
            if arr_responseData.count != 0{
                let dict_responseData = arr_responseData[0] as! NSDictionary
                
                let arr_Inflection = dict_responseData["inflection_array"] as! NSArray
                let arr_Image = dict_responseData["image_array"] as! NSArray
                let arr_Synonym = dict_responseData["synonym_array"] as! NSArray
                let arr_Another = dict_responseData["another_word_item"] as! NSArray
                
                let arr_Translation = dict_responseData["translate_array"] as! NSArray
                let arr_Meaning = dict_responseData["meaning_array"] as! NSArray
                let arr_Example = dict_responseData["exmaple_array"] as! NSArray
                
                
                var bool_Match : Bool = false
                if arr_Translation.count != 0 {
                    
                    let obj : OCRSelectionObject = arr_Main[btn_Click!.tag] as! OCRSelectionObject
                    
                    obj.arr_Traslation = []
                    obj.arr_Meaning = []
                    obj.arr_Example = []
                    obj.arr_Inflection = []
                    obj.arr_Image = []
                    obj.arr_Synonym = []
                    obj.arr_AnotherWord = []
                    obj.arr_ConvertString = []
                    
                    for count in 0..<arr_Translation.count {
                        //Traslation
                        let arr_Translation2 = arr_Translation[count] as! NSArray
                        
                        if arr_Translation2.count != 0{
                            bool_Match = true
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Translation2.count {
                                arr_Temp.add(arr_Translation2[count2] as! String)
                            }
                            obj.arr_Traslation.add(arr_Temp)
                            
                            obj.arr_ConvertString.add(arr_Translation2[0] as! String)
                        }else{
                            obj.arr_Traslation.add([])
                            obj.arr_ConvertString.add("")
                        }
                    }
                    
                    
                    for count in 0..<arr_Meaning.count {
                        //Traslation
                        let arr_Meaning2 = arr_Meaning[count] as! NSArray
                        
                        if arr_Meaning2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Meaning2.count {
                                arr_Temp.add(arr_Meaning2[count2] as! String)
                            }
                            obj.arr_Meaning.add(arr_Temp)
                        }else{
                            obj.arr_Meaning.add([])
                        }
                    }
                    
                    
                    for count in 0..<arr_Example.count {
                        //Traslation
                        let arr_Example2 = arr_Example[count] as! NSArray
                        
                        if arr_Example2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Example2.count {
                                arr_Temp.add(arr_Example2[count2] as! String)
                            }
                            obj.arr_Example.add(arr_Temp)
                        }else{
                            obj.arr_Example.add([])
                        }
                    }
                    
                    
                    for count in 0..<arr_Inflection.count {
                        //Traslation
                        let arr_Inflection2 = arr_Inflection[count] as! NSArray
                        
                        if arr_Inflection2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Inflection2.count {
                                arr_Temp.add(arr_Inflection2[count2] as! String)
                            }
                            obj.arr_Inflection.add(arr_Temp)
                        }else{
                            obj.arr_Inflection.add([])
                        }
                    }
                    
                    
                    //Image
                    if arr_Image.count != 0{
                        obj.str_Image = arr_Image[0] as! String
                        
                        for i in 0..<arr_Image.count {
                            obj.arr_Image.add(arr_Image[i] as! String)
                        }
                    }
                    
                    for count in 0..<arr_Synonym.count {
                        //Traslation
                        let arr_Synonym2 = arr_Synonym[count] as! NSArray
                        
                        if arr_Synonym2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Synonym2.count {
                                arr_Temp.add(arr_Synonym2[count2] as! String)
                            }
                            obj.arr_Synonym.add(arr_Temp)
                        }else{
                            obj.arr_Synonym.add([])
                        }
                    }
                    
                    
                    for count in 0..<arr_Another.count {
                        //Traslation
                        let arr_Another2 = arr_Another[count] as! NSArray
                        
                        if arr_Another2.count != 0{
                            
                            var arr_Temp : NSMutableArray = []
                            for count2 in 0..<arr_Another2.count {
                                arr_Temp.add(arr_Another2[count2] as! String)
                            }
                            obj.arr_AnotherWord.add(arr_Temp)
                        }else{
                            obj.arr_AnotherWord.add([])
                        }
                    }
                    
                    
                    
                    arr_Main[btn_Click!.tag] = obj;
                    
                    obj.str_Selected = increasCount()
                }
                
                if bool_Match == false{
                    messageBar.MessageShow(title: "The word \"\(dict_responseData["word"] as! NSString)\" is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
                }else{
                    
                    let when3 = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when3) {
                        var item = self.collectionView(self.cv_Word!, numberOfItemsInSection: 0) - 1
                        var lastItemIndex : NSIndexPath = NSIndexPath(row: item, section: 0)
                        self.cv_Word?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.right, animated: true)
                    }
                    
                    self.manageArrayCollection()
                    index_Selected = IndexPath(row: arr_Collection.count - 1, section: 0)
                    
                    cv_Word.reloadData()
                    
                    //Reload image when get result with string
                    if arr_Translation.count != 0{
                        self.CreateBoxImage()
                    }
                }
            }
            
        }
        else if strRequest == "update_dictionary"{
            userObjectUpdate(dict_Get : response)
            
            switch Int(objUser!.traslation_DictionaryName) {
            case 1?:
                img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Google")
                break
            case 2?:
                img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Lexin")
                if objUser?.traslation_ToNameLexin as! String == "swe_eng"{
                    self.img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Lexin2")
                }
                break
            case 3?:
                img_Traslation.image = UIImage(named:"icon_ChangeTraslator_Glosab")
                break
            default:
                break
            }
            
            self.manageServicePresentScreenCalling()
        }else if strRequest == "add_card"{
            let obj2 : OCRSelectionObject = arr_Collection[index_Selected.row] as! OCRSelectionObject
            
            for j in 0..<arr_Main.count {
                let obj : OCRSelectionObject = arr_Main[j] as! OCRSelectionObject
                
                if (obj.str_Title == obj2.str_Title) {
                    obj.str_SaveOrNot = "0"
                    obj.str_CatSave = "\(objUser?.category_SelectedCat as! String)/\(objUser?.category_SelectedSubCat as! String)"
                    obj.str_Level = "3"
                    
                    arr_Main[j] = obj
                }
            }
            cv_Word.reloadData()
        }else if strRequest == "check_card"{
            let responseData = response["response"] as! NSDictionary
            let arr_Traslation = responseData["keyword"] as! NSArray
            
            for count in 0..<arr_Traslation.count {
                let obj : OCRSelectionObject = arr_Main[count] as! OCRSelectionObject
                
                let dict_Result = arr_Traslation[count] as! NSDictionary
                obj.str_SaveOrNot = dict_Result.getStringForID(key : "is_saved")!
                obj.str_CardID = dict_Result["card_id"]  as? String ?? ""
                
                var str_Cat : String = dict_Result["category_name"]  as? String ?? ""
                var str_SubCat : String = dict_Result["sub_category_name"]  as? String ?? ""
                if str_Cat != ""{
                    obj.str_CatSave = "\(str_Cat)/\(str_SubCat)"
                }else{
                    obj.str_CatSave = ""
                }
                
                obj.str_Level = "3"
                
                arr_Main[count] = obj
            }
            cv_Word.reloadData()
        }
            
        else if strRequest == "translate_lexin2"{
            let arr_responseData = response["result"] as! NSArray
            
            for j in 0..<arr_responseData.count {
                let dict_responseData = arr_responseData[j] as! NSDictionary
                
                let arr_Inflection = dict_responseData["inflection_array"] as! NSArray
                let arr_Image = dict_responseData["image_array"] as! NSArray
                let arr_Synonym = dict_responseData["synonym_array"] as! NSArray
                let arr_Another = dict_responseData["another_word_item"] as! NSArray
                
                let arr_Translation = dict_responseData["translate_array"] as! NSArray
                let arr_Meaning = dict_responseData["meaning_array"] as! NSArray
                let arr_Example = dict_responseData["exmaple_array"] as! NSArray
                
                
                let obj : OCRSelectionObject = arr_Main[j] as! OCRSelectionObject
                
                var bool_Match : Bool = false
                if arr_Translation.count != 0 {
                    
                    
                    obj.arr_Traslation = []
                    obj.arr_Meaning = []
                    obj.arr_Example = []
                    obj.arr_Inflection = []
                    obj.arr_Image = []
                    obj.arr_Synonym = []
                    obj.arr_AnotherWord = []
                    obj.arr_ConvertString = []
                    
                    
                    var bool_Value : Bool = true
                    for k in 0..<j {
                        let objLocal : OCRSelectionObject = arr_Main[k] as! OCRSelectionObject
                        if objLocal.str_Title == obj.str_Title{
                            bool_Value = false
                        }
                    }
                    
                    
                    if bool_Value == true{
                        
                        for count in 0..<arr_Translation.count {
                            //Traslation
                            let arr_Translation2 = arr_Translation[count] as! NSArray
                            
                            if arr_Translation2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Translation2.count {
                                    arr_Temp.add(arr_Translation2[count2] as! String)
                                }
                                obj.arr_Traslation.add(arr_Temp)
                                
                                obj.arr_ConvertString.add(arr_Translation2[0] as! String)
                            }else{
                                obj.arr_Traslation.add([])
                                obj.arr_ConvertString.add("")
                            }
                        }
                        
                        
                        for count in 0..<arr_Meaning.count {
                            //Traslation
                            let arr_Meaning2 = arr_Meaning[count] as! NSArray
                            
                            if arr_Meaning2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Meaning2.count {
                                    arr_Temp.add(arr_Meaning2[count2] as! String)
                                }
                                obj.arr_Meaning.add(arr_Temp)
                            }else{
                                obj.arr_Meaning.add([])
                            }
                        }
                        
                        for count in 0..<arr_Example.count {
                            //Traslation
                            let arr_Example2 = arr_Example[count] as! NSArray
                            
                            if arr_Example2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Example2.count {
                                    arr_Temp.add(arr_Example2[count2] as! String)
                                }
                                obj.arr_Example.add(arr_Temp)
                            }else{
                                obj.arr_Example.add([])
                            }
                        }
                        
                        
                        for count in 0..<arr_Inflection.count {
                            //Traslation
                            let arr_Inflection2 = arr_Inflection[count] as! NSArray
                            
                            if arr_Inflection2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Inflection2.count {
                                    arr_Temp.add(arr_Inflection2[count2] as! String)
                                }
                                obj.arr_Inflection.add(arr_Temp)
                            }else{
                                obj.arr_Inflection.add([])
                            }
                        }
                        
                        //Image
                        if arr_Image.count != 0{
                            obj.str_Image = arr_Image[0] as! String
                            
                            for i in 0..<arr_Image.count {
                                obj.arr_Image.add(arr_Image[i] as! String)
                            }
                        }
                        
                        for count in 0..<arr_Synonym.count {
                            //Traslation
                            let arr_Synonym2 = arr_Synonym[count] as! NSArray
                            
                            if arr_Synonym2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Synonym2.count {
                                    arr_Temp.add(arr_Synonym2[count2] as! String)
                                }
                                obj.arr_Synonym.add(arr_Temp)
                            }else{
                                obj.arr_Synonym.add([])
                            }
                        }
                        
                        
                        for count in 0..<arr_Another.count {
                            //Traslation
                            let arr_Another2 = arr_Another[count] as! NSArray
                            
                            if arr_Another2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Another2.count {
                                    arr_Temp.add(arr_Another2[count2] as! String)
                                }
                                obj.arr_AnotherWord.add(arr_Temp)
                            }else{
                                obj.arr_AnotherWord.add([])
                            }
                        }
                        
                        arr_Main[btn_Click!.tag] = obj;
                        
                        obj.str_Selected = increasCount()
                    }
                }
                
                if bool_Match == true{
                    obj.str_Selected = increasCount()
                    arr_Main[j] = obj;
                    
                }
            }
            
            manageArrayCollection()
            
            if arr_Collection.count != 0{
                let view = self.storyboard?.instantiateViewController(withIdentifier: "OCRresultview") as! OCRresultview
                view.arr_Get = arr_Collection
                self.navigationController?.pushViewController(view, animated: true)
            }else{
                messageBar.MessageShow(title: "The words are not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
            }
            
        }
            
            
        else if strRequest == "translate_lexin2_Multiple"{
            let arr_responseData = response["result"] as! NSArray
            
            for j in 0..<arr_responseData.count {
                let dict_responseData = arr_responseData[j] as! NSDictionary
                
                let arr_Inflection = dict_responseData["inflection_array"] as! NSArray
                let arr_Image = dict_responseData["image_array"] as! NSArray
                let arr_Synonym = dict_responseData["synonym_array"] as! NSArray
                let arr_Another = dict_responseData["another_word_item"] as! NSArray
                
                let arr_Translation = dict_responseData["translate_array"] as! NSArray
                let arr_Meaning = dict_responseData["meaning_array"] as! NSArray
                let arr_Example = dict_responseData["exmaple_array"] as! NSArray
                
                
                let objTemp : OCRSelectionObject = arr_Collection[j] as! OCRSelectionObject
                let obj : OCRSelectionObject = arr_Main[Int(objTemp.str_TagIndex)!] as! OCRSelectionObject
                
                var bool_Match : Bool = false
                if arr_Translation.count != 0 {
                    
                    obj.arr_Traslation = []
                    obj.arr_Meaning = []
                    obj.arr_Example = []
                    obj.arr_Inflection = []
                    obj.arr_Image = []
                    obj.arr_Synonym = []
                    obj.arr_AnotherWord = []
                    obj.arr_ConvertString = []
                    
                    
                    var bool_Value : Bool = true
                    for k in 0..<j {
                        let objLocal : OCRSelectionObject = arr_Main[k] as! OCRSelectionObject
                        if objLocal.str_Title == obj.str_Title{
                            bool_Value = false
                        }
                    }
                    
                    
                    if bool_Value == true{
                        
                        for count in 0..<arr_Translation.count {
                            //Traslation
                            let arr_Translation2 = arr_Translation[count] as! NSArray
                            
                            if arr_Translation2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Translation2.count {
                                    arr_Temp.add(arr_Translation2[count2] as! String)
                                }
                                obj.arr_Traslation.add(arr_Temp)
                                
                                obj.arr_ConvertString.add(arr_Translation2[0] as! String)
                            }else{
                                obj.arr_Traslation.add([])
                                obj.arr_ConvertString.add("")
                            }
                        }
                        
                        
                        for count in 0..<arr_Meaning.count {
                            //Traslation
                            let arr_Meaning2 = arr_Meaning[count] as! NSArray
                            
                            if arr_Meaning2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Meaning2.count {
                                    arr_Temp.add(arr_Meaning2[count2] as! String)
                                }
                                obj.arr_Meaning.add(arr_Temp)
                            }else{
                                obj.arr_Meaning.add([])
                            }
                        }
                        
                        for count in 0..<arr_Example.count {
                            //Traslation
                            let arr_Example2 = arr_Example[count] as! NSArray
                            
                            if arr_Example2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Example2.count {
                                    arr_Temp.add(arr_Example2[count2] as! String)
                                }
                                obj.arr_Example.add(arr_Temp)
                            }else{
                                obj.arr_Example.add([])
                            }
                        }
                        
                        
                        for count in 0..<arr_Inflection.count {
                            //Traslation
                            let arr_Inflection2 = arr_Inflection[count] as! NSArray
                            
                            if arr_Inflection2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Inflection2.count {
                                    arr_Temp.add(arr_Inflection2[count2] as! String)
                                }
                                obj.arr_Inflection.add(arr_Temp)
                            }else{
                                obj.arr_Inflection.add([])
                            }
                        }
                        
                        //Image
                        if arr_Image.count != 0{
                            obj.str_Image = arr_Image[0] as! String
                            
                            for i in 0..<arr_Image.count {
                                obj.arr_Image.add(arr_Image[i] as! String)
                            }
                        }
                        
                        for count in 0..<arr_Synonym.count {
                            //Traslation
                            let arr_Synonym2 = arr_Synonym[count] as! NSArray
                            
                            if arr_Synonym2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Synonym2.count {
                                    arr_Temp.add(arr_Synonym2[count2] as! String)
                                }
                                obj.arr_Synonym.add(arr_Temp)
                            }else{
                                obj.arr_Synonym.add([])
                            }
                        }
                        
                        
                        for count in 0..<arr_Another.count {
                            //Traslation
                            let arr_Another2 = arr_Another[count] as! NSArray
                            
                            if arr_Another2.count != 0{
                                
                                var arr_Temp : NSMutableArray = []
                                for count2 in 0..<arr_Another2.count {
                                    arr_Temp.add(arr_Another2[count2] as! String)
                                }
                                obj.arr_AnotherWord.add(arr_Temp)
                            }else{
                                obj.arr_AnotherWord.add([])
                            }
                        }
                        
                        obj.str_Selected = "0"
                        if obj.arr_ConvertString.count != 0{
                            obj.str_Selected = increasCount()
                        }
                        arr_Main[ Int(objTemp.str_TagIndex)!] = obj;
                    }
                }else{
                    
                    obj.arr_Traslation = []
                    obj.arr_Meaning = []
                    obj.arr_Example = []
                    obj.arr_Inflection = []
                    obj.arr_Image = []
                    obj.arr_Synonym = []
                    obj.arr_AnotherWord = []
                    obj.arr_ConvertString = []
                    
                    obj.str_Selected = "0"
                    arr_Main[ Int(objTemp.str_TagIndex)!] = obj;
                }
            }
            
            cv_Word.reloadData()
            self.CreateBoxImage()
        }
    }
    
    func appDataDidFail(_ error: Error, request strRequest: String) {
        if strRequest == "ocrgoogleconvert" || strRequest == "ocrglosbeconvert"{
            messageBar.MessageShow(title: "The word is not in the dictionary" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }
        print(error)
    }
}

extension OCRSelectionViewController : UIAdaptivePresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

