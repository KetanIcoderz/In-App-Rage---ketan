//
//  SchoolViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 09/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class SchoolViewController: UIViewController {

    //Declaration Tableview
    @IBOutlet var tbl_Main : UITableView!
    
    //Aarray declartion
    var arr_Main : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Other Files -
    func commanMethod(){
        
        var obj = SchoolListObject ()
        obj.str_Name = "Lesson 1"
        obj.str_Image = "1"
        arr_Main.add(obj)
        
        obj = SchoolListObject ()
        obj.str_Name = "Lesson 2"
        obj.str_Image = "21"
        arr_Main.add(obj)
        
        obj = SchoolListObject ()
        obj.str_Name = "Lesson 3"
        obj.str_Image = "21"
        arr_Main.add(obj)
        
        obj = SchoolListObject ()
        obj.str_Name = "Lesson 4"
        obj.str_Image = "21"
        arr_Main.add(obj)
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


//MARK: - Friends Object -
class SchoolListObject: NSObject {
    
    var str_Name : String = ""
    var str_Image : String = ""
}



// MARK: - Tableview Files -
class SchoolListTableviewCell : UITableViewCell{
    //MARK: - Tableview View Cell -
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var img_Title: UIImageView!
}


extension SchoolViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if arr_Main.count == 0{
            tbl_Main.isUserInteractionEnabled = false
            return tableView.frame.size.height
        }
        
        tbl_Main.isUserInteractionEnabled = true
        return CGFloat(Int((GlobalConstants.windowHeight * 60)/GlobalConstants.screenHeightDeveloper))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arr_Main.count == 0{
            return 1
        }
        return arr_Main.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var str_Identifier : String = "cell"
        
        if arr_Main.count == 0{
            str_Identifier = "nodata"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: str_Identifier, for:indexPath as IndexPath) as! SchoolListTableviewCell
        
        if arr_Main.count != 0{
            let obj : SchoolListObject = arr_Main[indexPath.row] as! SchoolListObject
            
            cell.lbl_Title.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
            
            //Value Set
            cell.lbl_Title.text = obj.str_Name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arr_Main.count != 0{
            self.performSegue(withIdentifier: "schooldetail", sender: self)
        }

    }
    
}

