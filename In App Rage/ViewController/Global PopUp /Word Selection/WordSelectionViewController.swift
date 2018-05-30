//
//  WordSelectionViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 22/02/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import AutoScrollLabel


protocol DismissWordSelectionDelegate: class {
    func ClickDismissWordSelectionOption(info: NSMutableArray)
}

class WordSelectionViewController: UIViewController {

    //Declaration Button
    @IBOutlet weak var tbl_Main: UITableView!
    
    @IBOutlet weak var con_PopUpHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btn_SelectALl: UIButton!
    
    var arr_Data: NSMutableArray!
    
    weak var delegate :DismissWordSelectionDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
    
        con_PopUpHeight.constant = CGFloat(arr_Data.count * 70) + 150 > CGFloat(GlobalConstants.windowHeight) ?  CGFloat(GlobalConstants.windowHeight - 100) :  CGFloat(arr_Data.count * 70) + 150
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func commanMethod() {
        
        for count in 0..<arr_Data.count {
            let obj = arr_Data[count] as! OCRSelectionObject
            obj.str_SaveOrNot = "1"
            arr_Data[count] = obj
        }
        
        self.selectAllOrNot()
    }
    func selectAllOrNot(){
        
        btn_SelectALl.isSelected = true

        for count in 0..<arr_Data.count {
            let obj = arr_Data[count] as! OCRSelectionObject
            
            if obj.str_SaveOrNot == "0"{
                btn_SelectALl.isSelected = false
                break
            }
        }
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        dismiss(animated:true, completion: nil)
    }

    @IBAction func btn_Save(_ sender:Any){
        self.dismiss(animated: true) {
            self.delegate?.ClickDismissWordSelectionOption(info: self.arr_Data)
        }
    }
    @IBAction func btn_SelectALl(_ sender:Any){
        
        if btn_SelectALl.isSelected == false{
            btn_SelectALl.isSelected = true
            
            for count in 0..<arr_Data.count {
                let obj = arr_Data[count] as! OCRSelectionObject
                obj.str_SaveOrNot = "1"
                arr_Data[count] = obj
            }
        }else{
            btn_SelectALl.isSelected = false
            
            for count in 0..<arr_Data.count {
                let obj = arr_Data[count] as! OCRSelectionObject
                obj.str_SaveOrNot = "0"
                arr_Data[count] = obj
            }
        }
        
        tbl_Main.reloadData()
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



class WordSelctionTableViewCell: UITableViewCell {
    
    // MARK: - Table Cell -
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var lbl_Cat: UILabel!
    @IBOutlet var lbl_Level: UILabel!
    
    @IBOutlet var btn_Selection: UIButton!
    
    
    @IBOutlet weak var lbl_Title2: CBAutoScrollLabel!
    
}

// MARK: - Table Delegate -
extension WordSelectionViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr_Data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath as IndexPath) as! WordSelctionTableViewCell
        
        let obj = arr_Data[indexPath.row] as! OCRSelectionObject
        
        if cell.lbl_Title.text == ""{
            cell.lbl_Title2.text = obj.str_Title
            cell.lbl_Title2.textColor = UIColor.black
            cell.lbl_Title2.font = UIFont(name: GlobalConstants.kFontSemiBold, size: manageFont(font: 17))!
            cell.lbl_Title2.scrollDirection = CBAutoScrollDirection.left
        }
    
        cell.lbl_Title.text = obj.str_Title
        cell.lbl_Cat.text = obj.str_CatSave
        cell.lbl_Level.text = "Level : \(obj.str_Level)"
        
        if obj.str_SaveOrNot == "0"{
            cell.btn_Selection.setImage(UIImage(named:"Checkmark_un"), for: UIControlState.normal)
        }else{
            cell.btn_Selection.setImage(UIImage(named:"Checkmark_se"), for: UIControlState.normal)
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath as IndexPath) as! WordSelctionTableViewCell
        
        let obj = arr_Data[indexPath.row] as! OCRSelectionObject
        if obj.str_SaveOrNot == "0"{
            obj.str_SaveOrNot = "1"
        }else{
            obj.str_SaveOrNot = "0"
        }
        arr_Data[indexPath.row] = obj
//
        self.selectAllOrNot()
        tbl_Main.reloadData()
    }
    
}

