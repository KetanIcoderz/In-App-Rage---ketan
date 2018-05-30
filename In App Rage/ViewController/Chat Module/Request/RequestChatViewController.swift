//
//  RequestChatViewController.swift
//  Minnaz
//
//  Created by Apple on 03/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class RequestChatViewController: UIViewController {

    //tableview Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     @IBAction func btn_Accept(_ sender: Any){
        
    }
    @IBAction func btn_Reject(_ sender: Any){
        
    }

    @IBAction func btn_Back(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
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
class RequestChatCell: UITableViewCell {
   @IBOutlet var lbl_UserName : UILabel!
    
   @IBOutlet var img_UserProfile : UIImageView!
    
    @IBOutlet var btn_Accept : UIButton!
    @IBOutlet var btn_Reject : UIButton!
}

extension RequestChatViewController: UITableViewDelegate,UITableViewDataSource{
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
      }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
      }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier : String = "cell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! RequestChatCell

        //Manage font
        cell.lbl_UserName.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        
        cell.lbl_UserName.text = "UserName \(indexPath.row + 1) sent you a friend request"
        
        cell.btn_Accept.tag = indexPath.row
        cell.btn_Accept.addTarget(self, action:#selector(btn_Accept(_:)), for: .touchUpInside)
        cell.btn_Reject.tag = indexPath.row
        cell.btn_Reject.addTarget(self, action:#selector(btn_Reject(_:)), for: .touchUpInside)
        
        
        cell.selectionStyle = .none
        return cell;
     }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        view.bool_OtherProfile = true
        if AsStudent == "1"{
            view.bool_SchoolProfile = true
        }
        self.navigationController?.pushViewController(view, animated: true)
    }
}
