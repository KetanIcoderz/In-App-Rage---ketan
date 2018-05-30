//
//  InviteViewController.swift
//  Minnaz
//
//  Created by Apple on 08/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController, UISearchBarDelegate {

    //Declaration Tableview
    @IBOutlet var tbl_Main : UITableView!
    
    //Array Declaration
    var arr_Main : NSMutableArray = []
    var arr_Main_Store : NSMutableArray = []
    
    //Other declaration
    @IBOutlet var sb_Search : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Scrollview Manage -
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tbl_Main {
            view.endEditing(true)
        }
    }
    // MARK: - TextField Manage -
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if sb_Search == sb_Search && sb_Search.text == "" {
            
            //Time of end editing than check if no data so we set all data in tableview
            arr_Main = NSMutableArray(array: arr_Main_Store);
            tbl_Main.reloadData()
        }
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let str_TextField = sb_Search.text?.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        if str_TextField != "" {
            arr_Main = []
            let arr_Count = arr_Main_Store
            for count in 0..<arr_Count.count {
                
                let obj : InviteViewObject = arr_Count[count] as! InviteViewObject
                let Str: String = obj.str_Title.lowercased()
                
                var searchText : String = sb_Search.text!
                searchText = searchText.lowercased()
                
                //Specific word with matching
                if Str.lowercased().range(of:searchText) != nil{
                    self.arr_Main.add(obj)
                }
            }
        }else{
            arr_Main = NSMutableArray(array: arr_Main_Store);
        }
        
        view.endEditing(true)
        tbl_Main.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.phase == .began {
            view.endEditing(true)
        }
    }
    
    
    func commanMethod(){
         arr_Main = []
        
        //Demo data
        var obj = InviteViewObject ()
        obj.str_Title = "Martin"
        obj.str_PhoneNumber = "8881234567"
        obj.str_AddFriend = "0"
        
        arr_Main.add(obj)
        
        var obj2 = InviteViewObject ()
        obj2.str_Title = "Martin"
        obj2.str_PhoneNumber = "8881234567"
        obj2.str_AddFriend = "0"
        
        arr_Main.add(obj2)
        
        var ob3 = InviteViewObject ()
        ob3.str_Title = "Martin"
        ob3.str_PhoneNumber = "8881234567"
        ob3.str_AddFriend = "0"
        
        arr_Main.add(ob3)
        
        var obj4 = InviteViewObject ()
        obj4.str_Title = "Martin"
        obj4.str_PhoneNumber = "8881234567"
        obj4.str_AddFriend = "0"
        
        arr_Main.add(obj4)
        
        arr_Main_Store = NSMutableArray(array: arr_Main);

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
    //        toggleLeft()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_AddFriends(_ sender: Any) {
        let obj : InviteViewObject = arr_Main[(sender as AnyObject).tag] as! InviteViewObject
        obj.str_AddFriend = "1"
        arr_Main[(sender as AnyObject).tag] = obj
        tbl_Main.reloadData()
    }
    @IBAction func btn_Share (_ sender : Any){
        shareFunction(textData : "Hey\n\nI just downloaded Minnaz on my iPhone.\n\nIt is a Education Related Application\nGet it now from http://213.188.152.66/home.html#/.",viewPresent: self)
    }
}

//MARK: - Search Object -

class InviteViewObject: NSObject {
    var str_Title : String = ""
    var str_PhoneNumber : String = ""
    var str_AddFriend : String = ""
    
}


//MARK: - Tableview View Cell -
class InviteViewTableviewCell : UITableViewCell{
    //Main Listing
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_phoneNumber: UILabel!
    
    @IBOutlet weak var btn_AddFriends: UIButton!
    
}



//MARK: - Tableview Delegate -

extension InviteViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arr_Main.count != 0{
            return arr_Main.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arr_Main.count == 0{
            return 50
        }

        return UITableViewAutomaticDimension
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell_Identifier = "cell"
        if arr_Main.count == 0{
            cell_Identifier = "nodata"
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! InviteViewTableviewCell
        //    let obj = arrTblPopupData[indexPath.row]

        if arr_Main.count != 0{
            let obj : InviteViewObject = arr_Main[indexPath.row] as! InviteViewObject
            
            cell.lbl_Title.text = obj.str_Title
            cell.lbl_phoneNumber.text = obj.str_PhoneNumber
            
            cell.btn_AddFriends.tag = indexPath.row
            
            if obj.str_AddFriend == "0"{
                cell.btn_AddFriends .setTitle("Add Friend", for: UIControlState.normal)
            }else{
                cell.btn_AddFriends .setTitle("Invited", for: UIControlState.normal)
            }
            
            //Manage font
            cell.lbl_Title.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
            cell.lbl_phoneNumber.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 14))
            
            cell.btn_AddFriends.tag = indexPath.row
            cell.btn_AddFriends.addTarget(self, action:#selector(btn_AddFriends(_:)), for: .touchUpInside)
            
        }else{
            cell.lbl_Title.text = "No friends available"
        }

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



