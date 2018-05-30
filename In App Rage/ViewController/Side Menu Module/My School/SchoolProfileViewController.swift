//
//  SchoolProfileViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 13/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class SchoolProfileViewController: UIViewController {

    
    //Other Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    
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
        
        //Table view header heigh set
        let vw : UIView = tbl_Main.tableHeaderView!
        vw.frame = CGRect(x: 0, y: 0, width: GlobalConstants.windowWidth, height:(GlobalConstants.windowHeight*0.3523238381))
        tbl_Main.tableHeaderView = vw;
        
    }
    
    // MARK: - Button Event -
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




//MARK: - Object Decalration -

class SchoolProfileCell: UITableViewCell {
    
    @IBOutlet var lbl_Icon: UIImageView!
    
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var lbl_Value: UILabel!
    
}

extension SchoolProfileViewController : UITableViewDelegate,UITableViewDataSource{
    // MARK: - Table View -

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier : String = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! SchoolProfileCell
        
        switch indexPath.row {
        case 0:
            cell.lbl_Title.text = "Address"
            cell.lbl_Value.text = "450 Serra Mall, Standford \nCA 94304, \nUSA"
            cell.lbl_Icon.image = UIImage(named:"icon_AddressUser")
            break
        case 1:
            cell.lbl_Title.text = "Website"
            cell.lbl_Value.text = "www.stanford.ed"
            cell.lbl_Icon.image = UIImage(named:"icon_WebsiteUser")
            break
        case 2:
            cell.lbl_Title.text = "Phone No"
            cell.lbl_Value.text = "+11 2340 8459 32"
            cell.lbl_Icon.image = UIImage(named:"icon_PhoneUser")
            break
            
        default:
            break
        }
        
        return cell;
    }

    
}




