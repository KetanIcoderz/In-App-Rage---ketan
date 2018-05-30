//
//  ExamplePopUpViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 22/02/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit



class ExamplePopUpViewController2: UIViewController {

    
    //Declaration Button
    @IBOutlet weak var tbl_Main: UITableView!
    
    @IBOutlet weak var con_PopUpHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btn_Lang: UIButton!

    var obj_Get = OCRSelectionObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()

        con_PopUpHeight.constant = CGFloat(GlobalConstants.windowHeight - 150)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func commanMethod() {
        switch Int(objUser!.traslation_DictionaryName) {
        case 1?:
            btn_Lang.setImage(UIImage(named:"icon_Dictionary1"), for: UIControlState.normal)
            break
        case 2?:
            btn_Lang.setImage(UIImage(named:"icon_Dictionary2"), for: UIControlState.normal)
            if validationforLexinEnglishDictionaryShow() == true{
                btn_Lang.setImage(UIImage(named:"icon_Dictionary2-1"), for: UIControlState.normal)
            }
            break
        case 3?:
            btn_Lang.setImage(UIImage(named:"icon_Dictionary3"), for: UIControlState.normal)
            break
        default:
            break
        }
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        dismiss(animated:true, completion: nil)
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





// MARK: - Table Delegate -
extension ExamplePopUpViewController2 : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        switch section {
        case 0:
            
            var str_syno : String = ""
            for i in 0..<obj_Get.arr_Synonym.count {
                if i == 0{
                    str_syno = "\(obj_Get.arr_Synonym[i] as! String)"
                }else{
                    str_syno = "\(str_syno),\(obj_Get.arr_Synonym[i] as! String)"
                }
            }
            
            if str_syno != ""{
                let starWidth = str_syno.widthOfString(usingFont: UIFont(name:  GlobalConstants.kFontRegular, size: manageFont(font: 22))!)
            
                if starWidth > CGFloat(GlobalConstants.windowWidth - 85) {
                    return 65
                }
            }
            
            //Header for description
           return 50
            break
        case 1:
            
            //Example
            if obj_Get.arr_Example.count != 0{
                return 50
            }else{
                return 0
            }
            break
            
        case 2:
            
            //Inflexation
            if obj_Get.arr_Inflection.count != 0{
                return 50
            }else{
                return 0
            }
            break
            
        default:
            break
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! ExamplePopUpTableViewCell
        
        
        switch section {
        case 0:
            var str_syno : String = ""
            for i in 0..<obj_Get.arr_Synonym.count {
                if i == 0{
                    str_syno = "\(obj_Get.arr_Synonym[i] as! String)"
                }else{
                    str_syno = "\(str_syno),\(obj_Get.arr_Synonym[i] as! String)"
                }
            }
            
            if str_syno != ""{
                cell.lbl_Title.text = "\(obj_Get.str_Title) (\(str_syno))"
            }else{
                cell.lbl_Title.text = "\(obj_Get.str_Title)"
            }

            break
        case 1:
            cell.lbl_Title.text = "Example"
            
            break
            
        case 2:
            cell.lbl_Title.text = "Compositions"
            
            break
        default:
            break
        }
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
           
            return 1
            
            break
        case 1:
            //Example
            if obj_Get.arr_Example.count != 0{
                return 1
            }
            
            break
            
        case 2:
            //Inflexation
            if obj_Get.arr_Inflection.count != 0{
                return 1
            }
            
            break
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier : String = "cell"
     
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! ExamplePopUpTableViewCell
        
        
        switch indexPath.section {
        case 0:
            
            var str_other : String = ""
            for i in 0..<obj_Get.arr_AnotherWord.count {
                if i == 0{
                    str_other = "\(obj_Get.arr_AnotherWord[i] as! String)"
                }else{
                    str_other = "\(str_other),\(obj_Get.arr_AnotherWord[i] as! String)"
                }
            }
            
            var str_meaning : String = ""
            for i in 0..<obj_Get.arr_Meaning.count {
                str_meaning = "\(str_meaning)\n\(obj_Get.arr_Meaning[i] as! String)"
            }
            
            if str_other != ""{
                cell.lbl_Title.text = "(\(str_other))\n\(str_meaning)"
            }else{
                cell.lbl_Title.text = "\(str_meaning)"
            }
            
            break
        case 1:
            var str_example : String = ""
            for i in 0..<obj_Get.arr_Example.count {
                str_example = "\(str_example)\n\(obj_Get.arr_Example[i] as! String)"
            }
            cell.lbl_Title.text = str_example
            break
            
        case 2:
            var str_infle : String = ""
            for i in 0..<obj_Get.arr_Inflection.count {
                str_infle = "\(str_infle)\n\(obj_Get.arr_Inflection[i] as! String)"
            }
            cell.lbl_Title.text = str_infle
            break
            
        default:
            break
        }
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}

