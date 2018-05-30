
//
//  SettingsViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 14/11/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    //tableview Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    //View Declaration
    @IBOutlet weak var vwAchievement: UIView!
    
    //Button Declaration
    @IBOutlet weak var btnProfile : UIButton!
    
    //Label Declaartion
    @IBOutlet weak var lbl_SchoolName : UILabel!
    @IBOutlet weak var lbl_UserName : UILabel!
    @IBOutlet weak var lbl_EmailAddress : UILabel!
    
    //Image Declaration
    @IBOutlet weak var img_UserProfile : UIImageView!
    
    var tbl_reload_Number : NSIndexPath!
    
    //Comman Declaration
    var bool_OtherProfile : Bool = false
    var bool_SchoolProfile : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commanMethod()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        //Manage Data with user
        img_UserProfile.sd_setImage(with: URL(string: (objUser?.user_Image)!), placeholderImage: UIImage(named:"img_PlaceSignUp"))
        lbl_UserName.text = objUser?.user_Name
        lbl_EmailAddress.text = objUser?.user_Email
        lbl_SchoolName.text = objUser?.user_SchoolName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Other Files -
    func commanMethod(){
        
        //Table view header heigh set
        let vw : UIView = tbl_Main.tableHeaderView!
        vw.frame = CGRect(x: 0, y: 0, width: GlobalConstants.windowWidth, height:(GlobalConstants.windowHeight*0.3)+60)
        tbl_Main.tableHeaderView = vw;
        
        btnProfile.layer.cornerRadius = btnProfile.frame.size.width/2
        btnProfile.layer.masksToBounds = true
        
        if bool_OtherProfile == true{
            btnProfile .setImage(UIImage(named:"icon_Chat"), for: UIControlState.normal)
        }else{
            btnProfile .setImage(UIImage(named:"edit"), for: UIControlState.normal)
        }
        
        
            
        if bool_SchoolProfile == false && bool_OtherProfile == false{
            if objUser?.user_Type == "0"{
                 lbl_SchoolName.isHidden = true
            }else{
                lbl_SchoolName.isHidden = false
            }
        }else{
            lbl_SchoolName.isHidden = true
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
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        if bool_OtherProfile == true || bool_SchoolProfile == true{
            self.navigationController?.popViewController(animated: true)
        }else{
            toggleLeft()
        }
    }
    @IBAction func btn_NavigationRight(_ sender: Any) {
        if bool_OtherProfile == true{
            
            self.performSegue(withIdentifier: "chat", sender: self)
            
//            let view = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//            self.navigationController?.pushViewController(view, animated: true)
        }else{
            let view = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            view.isEditMode = true
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    @IBAction func hideAchivementClick(_ sender: Any) {
      //        toggleLeft()
      vwAchievement.isHidden = true
    }
    @IBAction func btn_Section(_ sender: Any) {
        //Change Password
        if (sender as AnyObject).tag == 2{
            self.performSegue(withIdentifier: "changepassword", sender: self)
        }else  if (sender as AnyObject).tag == 3{
            self.performSegue(withIdentifier: "glosary", sender: self)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
//            view.modalPresentationStyle = .custom
//            view.modalTransitionStyle = .crossDissolve
//            present(view, animated: true)
        }
        
        //Get animation with table view reload data
        tbl_Main.beginUpdates()
        if ((tbl_reload_Number) != nil) {
            if (tbl_reload_Number.section == (sender as AnyObject).tag) {
              
              if (sender as AnyObject).tag == 0{
                //Delete Cell
                // let objDelete : PurchaseObject = arr_Main[tbl_reload_Number.section]
                let arr_DeleteIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows: 2)
                tbl_Main.deleteRows(at: arr_DeleteIndex as! [IndexPath], with: .automatic)
              }else{
                //Delete Cell
                // let objDelete : PurchaseObject = arr_Main[tbl_reload_Number.section]
                let arr_DeleteIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows: 1)
                tbl_Main.deleteRows(at: arr_DeleteIndex as! [IndexPath], with: .automatic)
              }
              
                
                tbl_reload_Number = nil;
            }else{
                //Delete Cell
                // let objDelete : PurchaseObject = arr_Main[tbl_reload_Number.section]
              
              
              if tbl_reload_Number.section == 0{
                let arr_DeleteIndex = self.indexPaths(forSection: tbl_reload_Number.section, withNumberOfRows:2)
                tbl_Main.deleteRows(at: arr_DeleteIndex as! [IndexPath], with: .automatic)
              }else if tbl_reload_Number.section == 1{
                let arr_DeleteIndex = self.indexPaths(forSection: tbl_reload_Number.section, withNumberOfRows:1)
                tbl_Main.deleteRows(at: arr_DeleteIndex as! [IndexPath], with: .automatic)
              }
                
                if (sender as AnyObject).tag == 0{
                    tbl_reload_Number = IndexPath(row: 0, section: (sender as AnyObject).tag) as NSIndexPath!
                    
                    //Add Cell
                    //let obj : PurchaseObject = arr_Main[(sender as AnyObject).tag]
                    let arr_AddIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows:2)
                    tbl_Main.insertRows(at: arr_AddIndex as! [IndexPath], with: .automatic)
                }else if (sender as AnyObject).tag == 1{
                  tbl_reload_Number = IndexPath(row: 0, section: (sender as AnyObject).tag) as NSIndexPath!
                  
                  //Add Cell
                  //let obj : PurchaseObject = arr_Main[(sender as AnyObject).tag]
                  let arr_AddIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows:1)
                  tbl_Main.insertRows(at: arr_AddIndex as! [IndexPath], with: .automatic)
                }else{
                    tbl_reload_Number = nil;
                }
            }
        }else{
            if (sender as AnyObject).tag == 0{
                tbl_reload_Number = IndexPath(row: 0, section: (sender as AnyObject).tag) as NSIndexPath!
                
                //Add Cell
                //let obj : PurchaseObject = arr_Main[(sender as AnyObject).tag]
                let arr_AddIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows: 2)
                tbl_Main.insertRows(at: arr_AddIndex as! [IndexPath], with: .automatic)
            }else if (sender as AnyObject).tag == 1{
              tbl_reload_Number = IndexPath(row: 0, section: (sender as AnyObject).tag) as NSIndexPath!
              
              //Add Cell
              //let obj : PurchaseObject = arr_Main[(sender as AnyObject).tag]
              let arr_AddIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows: 1)
              tbl_Main.insertRows(at: arr_AddIndex as! [IndexPath], with: .automatic)
          }
        }
        
        tbl_Main.endUpdates()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.tbl_Main.reloadData()
        })
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


class SettingsCell: UITableViewCell {
    // MARK: - Table Cell -
    
    @IBOutlet var lbl_Title: UILabel!
    
    @IBOutlet var img_Icon: UIImageView!
    @IBOutlet var img_RightArrow: UIImageView!
    
    @IBOutlet var btn_Click: UIButton!
    
}


extension SettingsViewController : UITableViewDelegate,UITableViewDataSource{
    // MARK: - Table View -
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 4;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //If search and result 0 than show no data cell
        if ((tbl_reload_Number) != nil) {
            if (tbl_reload_Number.section == section) {
              if section == 0 {
                return 2;
                
              }else if section == 1 {
                return 1;
                
              }
                //Count declaration
                //let obj : HomeObject = arr_Main[section]
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath.section == 1 {
        return 100
      }
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 2 {
            if objUser?.user_AccountType == "FB" || objUser?.user_AccountType == "Gplus"{
                return 0
            }
        }
        
        if bool_OtherProfile == true{
            if section == 2 {
                return 0
            }
        }else{
            if section == 1 {
                return 0
            }
        }
        return 70
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! SettingsCell
        
        cell.img_RightArrow.isHidden = true
        cell.img_Icon.isHidden = false
        switch section {
            case 0:
                 cell.lbl_Title.text = "Achievements"
                 cell.img_Icon.image = UIImage.init(named: "achivements")
                 cell.img_RightArrow.isHidden = false
                break
            case 1:
                  cell.lbl_Title.text = "Statistics"
                  cell.img_Icon.image = UIImage.init(named: "Statistics")
                  cell.img_RightArrow.isHidden = false
                  break
            case 2:
                cell.lbl_Title.text = "Change Password"
                cell.img_Icon.image = UIImage.init(named: "password")
                break
            case 3:
              cell.lbl_Title.text = "Glossary List"
              cell.img_Icon.image = UIImage.init(named: "download")
              break
            default:
                break
        }

        //Button Event
        cell.btn_Click.tag = section;
        cell.btn_Click.addTarget(self, action:#selector(btn_Section(_:)), for: .touchUpInside)
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       var cellIdentifier : String = "cell"
      if indexPath.section == 1 {
        cellIdentifier = "cell1"
      }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! SettingsCell
        
        if indexPath.section == 0 {
            cell.img_RightArrow.isHidden = true
            
            switch indexPath.row {
            case 0:
                cell.lbl_Title.text = "Current Week"
                cell.img_RightArrow.isHidden = false
                break
            case 1:
                cell.lbl_Title.text = "History"
                break
            default:
                break
            }
            
        }else if indexPath.section == 1 {
          
      }
      return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      if indexPath.section == 0 {
        switch indexPath.row {
            case 0:
              vwAchievement.isHidden = false
              break
            
            case 1:
               self.performSegue(withIdentifier: "history", sender: self)
            break
            
            case 2:
                
//                self.present(view, animated: true, completion: nil)
                
                break
            default:
              break
        }
    }
  }
}
