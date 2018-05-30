//
//  ContactStudentViewController.swift
//  Minnaz
//
//  Created by Apple on 03/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class ContactStudentViewController: UIViewController {

    //Button declaration
    @IBOutlet weak var btn_FriendRequest : UIButton!
    
    //Lavel Declaration
    @IBOutlet weak var lbl_NumberOfRequest : UILabel!
    @IBOutlet weak var lbl_FrindRequestUserName : UILabel!
    
    //Image Declaration
    @IBOutlet weak var img_FriendImage : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Button Event -
    @IBAction func btn_Share(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Delete Chat", style: UIAlertActionStyle.default, handler: { (action) in
            
            
        }))
        alert.addAction(UIAlertAction(title: "Block contact", style: UIAlertActionStyle.default, handler: { (action) in
            
            
        }))
        alert.addAction(UIAlertAction(title: "Un-Friend", style: UIAlertActionStyle.default, handler: { (action) in
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func btn_UserProfile(_ sender: Any){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        view.bool_OtherProfile = true
        view.bool_SchoolProfile = true
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func btn_FriendRequest(_ sender : Any){
        
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
extension ContactStudentViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 10
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! ChatCell

        if section == 0{
             cell.lblUserName.text = "Admin"
        }else if section == 1{
             cell.lblUserName.text = "Classmate"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier : String = "cell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! ChatCell

        cell.lblUserName.text = "My Class \(indexPath.row + 1)"
        cell.lblUserMessage.text = "8881234567"

        if indexPath.section == 0 {
            if indexPath.row == 0{
                cell.lblUserName.text = "School admin"
            }else if indexPath.row == 1{
                cell.lblUserName.text = "Teacher"
            }
        }

        //Manage font
        cell.lblUserName.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        cell.lblUserMessage.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 14))
        
        cell.btn_Share.tag = indexPath.row
        cell.btn_Share.addTarget(self, action:#selector(btn_Share(_:)), for: .touchUpInside)

        cell.btn_UserProfile.tag = indexPath.row
        cell.btn_UserProfile.addTarget(self, action:#selector(btn_UserProfile(_:)), for: .touchUpInside)

        cell.selectionStyle = .none
        return cell;
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action:UITableViewRowAction, indexPath:IndexPath) in
          print("delete at:\(indexPath)")
        }
        delete.backgroundColor = .red
    
        let more = UITableViewRowAction(style: .default, title: "More") { (action:UITableViewRowAction, indexPath:IndexPath) in
          let alert = UIAlertController(title: GlobalConstants.appName, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
          alert.addAction(UIAlertAction(title: "Chat", style: UIAlertActionStyle.default, handler: { (action) in
            
          }))
          alert.addAction(UIAlertAction(title: "Invite", style: UIAlertActionStyle.default, handler: { (action) in
            
          }))
          
          alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
          print("more at:\(indexPath)")
        }
        more.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
    
        return [delete, more]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        view.bool_OtherProfile = true
        view.bool_SchoolProfile = true
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
