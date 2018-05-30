//
//  GroupViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 09/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class GroupViewController: UIViewController {

    //tableview Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    //Aarray declartion
    var arr_Main : NSMutableArray = []
    
    
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
        
        var obj = GroupViewObject ()
        obj.str_UserName = "Martin G"
        obj.str_RemainingTime = ".30 m"
        obj.str_CommentTitle = "Anna Appleseed"
        obj.str_CommentDescription = "It is a long estimated fact that a reader will be distracted"
        obj.str_CommentCount = "12"
        obj.str_LikeCount = "114"
        obj.str_CommentOrNot = "0"
        obj.str_LikeOrNot = "0"
        obj.str_UserProfile = ""
        obj.str_UserType = "School Admin"
        arr_Main.add(obj)
        
        obj = GroupViewObject ()
        obj.str_UserName = "John Appleseed"
        obj.str_RemainingTime = ".2 m"
        obj.str_CommentTitle = "Anna Appleseed"
        obj.str_CommentDescription = "It is a long estimated fact that a reader will be distracted. It is a long estimated fact that a reader will be distracted. It is a long estimated fact that a reader will be distracted"
        obj.str_CommentCount = "12"
        obj.str_LikeCount = "114"
        obj.str_CommentOrNot = "0"
        obj.str_LikeOrNot = "0"
        obj.str_UserProfile = ""
        obj.str_UserType = "School Admin"
        arr_Main.add(obj)
        
        obj = GroupViewObject ()
        obj.str_UserName = "Martin G"
        obj.str_RemainingTime = "30 m"
        obj.str_CommentTitle = "Anna Appleseed"
        obj.str_CommentDescription = "It is a long estimated fact that a reader will be distracted"
        obj.str_CommentCount = "12"
        obj.str_LikeCount = "114"
        obj.str_CommentOrNot = "0"
        obj.str_LikeOrNot = "0"
        obj.str_UserProfile = ""
        obj.str_UserType = "School Admin"
        arr_Main.add(obj)
    }
    
    @IBAction func btn_More(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message:nil , preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Block user", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler:{ (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Report", style: UIAlertActionStyle.default, handler:{ (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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


class GroupViewObject {
    
     // MARK: - Object Group -
    var str_UserName: String = ""
    var str_RemainingTime: String = ""
    var str_CommentTitle: String = ""
    var str_CommentDescription: String = ""
    var str_CommentCount: String = ""
    var str_LikeCount: String = ""
    var str_CommentOrNot: String = ""
    var str_LikeOrNot: String = ""
    var str_UserType: String = ""
    
    var str_UserProfile: String = ""
}



class GroupCellViewController: UITableViewCell {
    // MARK: - Table Cell -
    @IBOutlet var lbl_UserName : UILabel!
    @IBOutlet var lbl_RemainingTime : UILabel!
    @IBOutlet var lbl_CommentTitle : UILabel!
    @IBOutlet var lbl_CommentDescription : UILabel!
    @IBOutlet var lbl_CommentCount : UILabel!
    @IBOutlet var lbl_LikeCount : UILabel!
    @IBOutlet var lbl_UserType : UILabel!
    
    @IBOutlet var img_User : UIImageView!
    
    @IBOutlet var lbl_NoData : UILabel!
    
    @IBOutlet var btn_More : UIButton!
}

// MARK: - Table Delegate -
extension GroupViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arr_Main.count == 0{
            return 1
        }
        return arr_Main.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier : String = "cell"
        if arr_Main.count == 0{
            cellIdentifier = "nodata"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! GroupCellViewController
        
        if arr_Main.count != 0{
            let obj = arr_Main[indexPath.row] as! GroupViewObject
            
            cell.lbl_UserName.text = obj.str_UserName
            cell.lbl_RemainingTime.text = obj.str_RemainingTime
            cell.lbl_CommentTitle.text = obj.str_CommentTitle
            cell.lbl_CommentDescription.text = obj.str_CommentDescription
            cell.lbl_CommentCount.text = obj.str_CommentCount
            cell.lbl_LikeCount.text = obj.str_LikeCount
            cell.lbl_UserType.text = obj.str_UserType
            
            //Manage font
            cell.lbl_UserName.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
            cell.lbl_UserType.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
            cell.lbl_RemainingTime.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
            cell.lbl_CommentTitle.font = UIFont(name: GlobalConstants.kFontBold, size: manageFont(font: 17))
            cell.lbl_CommentDescription.font = UIFont(name: GlobalConstants.kFontLight, size: manageFont(font: 13))
            cell.lbl_CommentCount.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
            cell.lbl_LikeCount.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
            
            cell.btn_More.tag = indexPath.row
            cell.btn_More.addTarget(self, action:#selector(btn_More(_:)), for: .touchUpInside)
            
        }else{
            cell.lbl_NoData.text = "No list available"
        }
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if arr_Main.count != 0{
            self.performSegue(withIdentifier: "commentdetail", sender: self)
        }
    }
    
}

