//
//  UserGlossaryListDetailViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 13/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages

class UserGlossaryListDetailViewController: UIViewController,DismissViewDelegate {

    var arr_Main : NSMutableArray = []
    
    var tbl_reload_Number : NSIndexPath!
    
    //Other Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Other Files -
    func commanMethod(){
        arr_Main = []
        for i in (0..<10) {
            
            let obj = UserGlossaryObject()
            
            obj.str_Title = "Sub Category \(i + 1)"
            arr_Main.add(obj)
        }
    }
        
        
    func indexPaths(forSection section: Int, withNumberOfRows numberOfRows: Int) -> [Any] {
        var indexPaths = [Any]()
        for i in 0..<numberOfRows {
            let indexPath = IndexPath(row: i, section: section)
            indexPaths.append(indexPath)
        }
        return indexPaths
    }
    
    func ClickOption(info: NSInteger) {
        if info == 1 {
          
        }
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_Download(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
        view.bool_Home = true
        view.delegate = self
        view.bool_CategorySubcategoryShow = false
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
        
    }
    @IBAction func btn_DownloadSingal(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
        view.str_AlertTitle = "Save all words if this category to "
        view.bool_Home = true
        view.delegate = self
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
        
    }
    @IBAction func btn_Cell(_ sender : Any){
        self.performSegue(withIdentifier: "word", sender: self)
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

//MARK: - Object Decalration -
class UserGlossaryObject: NSObject {
    
    var str_Title : String = ""
    
    var str_Image : String = ""
    
}


class UserGlossaryCell: UITableViewCell {
    
    @IBOutlet var lbl_Title: UILabel!
    
    @IBOutlet var img_SubCategory: UIImageView!
    
    @IBOutlet var btn_Download: UIButton!
    @IBOutlet var btn_Cell: UIButton!
    
}


extension UserGlossaryListDetailViewController : UITableViewDelegate,UITableViewDataSource{
    // MARK: - Table View -
    func numberOfSections(in tableView: UITableView) -> Int{
        
        if arr_Main.count == 0{
            return 1
        }
        
        return arr_Main.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(((GlobalConstants.windowWidth - 20)/3))
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 70
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var cellIdentifier : String = "section"
         if arr_Main.count == 0 {
            cellIdentifier = "nodata"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)as! UserGlossaryCell
        
        if arr_Main.count != 0 {
            let obj : UserGlossaryObject = arr_Main[section] as! UserGlossaryObject
            
            cell.lbl_Title.text = obj.str_Title
            
            //Button Event
            cell.btn_Download.tag = section;
            cell.btn_Download.addTarget(self, action:#selector(btn_DownloadSingal(_:)), for: .touchUpInside)
            
            //Button Event
            cell.btn_Cell.tag = section;
            cell.btn_Cell.addTarget(self, action:#selector(btn_Cell(_:)), for: .touchUpInside)
            
        }else{
             cell.lbl_Title.text = "No files available"
        }
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier : String = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! AllFilesCell
//

        
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        self.performSegue(withIdentifier: "word", sender: self)
    }


}




