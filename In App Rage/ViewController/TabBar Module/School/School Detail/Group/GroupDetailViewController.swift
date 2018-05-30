//
//  GroupDetailViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 09/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import IQKeyboardManagerSwift

class GroupDetailViewController: UIViewController {

    //tableview Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    //textfield declaration
    @IBOutlet weak var tf_Comment: UITextField!
    
    //Constant
    @IBOutlet weak var con_SearchBarBottom: NSLayoutConstraint!
    
    //Aarray declartion
    var arr_Main : NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()

        //Notificaitno event with keyboard show and hide
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(myKeyboardWillHideHandler),
            name: .UIKeyboardWillHide,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(myKeyboardWillShow),
            name: .UIKeyboardWillShow,
            object: nil)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = true
    }
    override func viewWillAppear(_ animated: Bool) {
        //Text editing manager
        IQKeyboardManager.sharedManager().enable = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Keyboard Delegate -
    @objc func myKeyboardWillHideHandler(_ notification: NSNotification) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowAnimatedContent], animations: {
            self.con_SearchBarBottom.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func myKeyboardWillShow(_ notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        self.view .layoutIfNeeded()
       
       //Scrollview animation when keyboard open
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowAnimatedContent], animations: {
            self.con_SearchBarBottom.constant =  keyboardHeight
            self.view .layoutIfNeeded()
        }, completion: nil)
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.phase == .began {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
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
  
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_More(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message:nil , preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (action) in
            
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


// MARK: - Table Delegate -
extension GroupDetailViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 160
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! GroupCellViewController
        
        let obj = arr_Main[0] as! GroupViewObject
        
        cell.lbl_UserName.text = obj.str_UserName
        cell.lbl_RemainingTime.text = obj.str_RemainingTime
        cell.lbl_CommentTitle.text = obj.str_CommentTitle
        cell.lbl_CommentDescription.text = obj.str_CommentDescription
        cell.lbl_CommentCount.text = obj.str_CommentCount
        cell.lbl_LikeCount.text = obj.str_LikeCount
        
        //Manage font
        cell.lbl_UserName.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        cell.lbl_RemainingTime.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
        cell.lbl_CommentTitle.font = UIFont(name: GlobalConstants.kFontBold, size: manageFont(font: 17))
        cell.lbl_CommentDescription.font = UIFont(name: GlobalConstants.kFontLight, size: manageFont(font: 13))
        cell.lbl_CommentCount.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
        cell.lbl_LikeCount.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
        
        cell.btn_More.tag = 0
        cell.btn_More.addTarget(self, action:#selector(btn_More(_:)), for: .touchUpInside)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if arr_Main.count == 0{
//            return 1
//        }
        return arr_Main.count
//        return 10
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
            cell.lbl_CommentDescription.text = obj.str_CommentDescription
            cell.lbl_CommentCount.text = obj.str_CommentCount
            
            //Manage font
            cell.lbl_UserName.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
            cell.lbl_RemainingTime.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
            cell.lbl_CommentDescription.font = UIFont(name: GlobalConstants.kFontLight, size: manageFont(font: 13))
            cell.lbl_CommentCount.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 13))
            
            cell.btn_More.tag = indexPath.row
            cell.btn_More.addTarget(self, action:#selector(btn_More(_:)), for: .touchUpInside)
            
        }else{
            cell.lbl_NoData.text = "No list available"
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if arr_Main.count != 0{
            let view = self.storyboard?.instantiateViewController(withIdentifier: "GroupDetailViewController") as! GroupDetailViewController
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
}

