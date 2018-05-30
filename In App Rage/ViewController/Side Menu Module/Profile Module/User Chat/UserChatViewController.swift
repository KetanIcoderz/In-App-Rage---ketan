//
//  UserChatViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 26/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class UserChatViewController: UIViewController {

    //tableview Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    //textfield declaration
    @IBOutlet weak var tf_Comment: UITextField!
    @IBOutlet weak var tv_Comment: UITextView!
    
    //Constant
    @IBOutlet weak var con_SearchBarBottom: NSLayoutConstraint!
    @IBOutlet weak var con_SearchBarHeight: NSLayoutConstraint!
    
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
            self.scrollToBottom()
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
        
        var obj = UserChatObject ()
        obj.str_UserMessage = "Martin G Martin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin G"
        obj.str_UserImage = ".30 m"
        obj.str_MessageType = "1"
        arr_Main.add(obj)

        obj = UserChatObject ()
        obj.str_UserMessage = "Martin G Martin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin GMartin G"
        obj.str_UserImage = ".30 m"
        obj.str_MessageType = "2"
        arr_Main.add(obj)

        obj = UserChatObject ()
        obj.str_UserMessage = "Martin G"
        obj.str_UserImage = ".30 m"
        obj.str_MessageType = "1"
        arr_Main.add(obj)
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arr_Main.count-1, section: 0)
            self.tbl_Main.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        var bool_Compaire : Bool = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller is ChatViewController {
                bool_Compaire = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
        if bool_Compaire == false{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func btn_SendMessage(_ sender: Any) {
        
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


extension UserChatViewController : UITextViewDelegate{
    // MARK: - Scrollview Manage -
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Replay" {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Replay"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        var height =  textView.text.height(withConstrainedWidth:CGFloat(GlobalConstants.windowWidth - 110), font :UIFont(name:  GlobalConstants.kFontRegular, size: 17)!)
        
       
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.05, delay: 0.0, options: [.allowAnimatedContent], animations: {
          
            if height + 22 < 50{
                self.con_SearchBarHeight.constant = 50
            }else if height + 22 > 150{
                self.con_SearchBarHeight.constant = 150
            }else{
                self.con_SearchBarHeight.constant = 22 + height
            }
            
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            
            let bottom = textView.contentSize.height - textView.bounds.size.height
            textView.setContentOffset(CGPoint(x: 0, y: bottom), animated: false)
        })
        
        self.view.layoutIfNeeded()
    }
}

class UserChatObject {
    
    // MARK: - Object Group -
    var str_UserMessage: String = ""
    var str_UserImage: String = ""
    var str_MessageType: String = ""
}


class UserChatCellViewController: UITableViewCell {
    
    // MARK: - Table Cell -
    @IBOutlet var lbl_UserMessage : UILabel!
    @IBOutlet var lbl_UserImage : UIImageView!
}


// MARK: - Table Delegate -
extension UserChatViewController : UITableViewDelegate,UITableViewDataSource{
    
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
        }else{
            let obj = arr_Main[indexPath.row] as! UserChatObject
            if obj.str_MessageType == "2"{
                cellIdentifier = "cell1"
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! UserChatCellViewController
        
        if arr_Main.count != 0{
            let obj = arr_Main[indexPath.row] as! UserChatObject
            
            cell.lbl_UserMessage.text = obj.str_UserMessage
            
            
        }else{
            cell.lbl_UserMessage.text = "No list available"
        }
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}



