//
//  ExamplePopUpViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 22/02/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit



class ExamplePopUpViewController: UIViewController {

    @IBOutlet weak var lbl_Title: UILabel!
    
    //Declaration Button
    @IBOutlet weak var tbl_Main: UITableView!
    
    @IBOutlet weak var con_PopUpHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btn_Lang: UIButton!
    
    var arr_Data: NSMutableArray!
    
    var str_Title : String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()

        con_PopUpHeight.constant = 410
        if arr_Data.count > 1{
            if arr_Data[1] as! String == ""{
                con_PopUpHeight.constant = 230
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func commanMethod() {
        lbl_Title.text = str_Title
        
        switch Int(objUser!.traslation_DictionaryName) {
        case 1?:
            btn_Lang.setImage(UIImage(named:"icon_Dictionary1"), for: UIControlState.normal)
            break
        case 2?:
            btn_Lang.setImage(UIImage(named:"icon_Dictionary2"), for: UIControlState.normal)
            if validationforLexinEnglishDictionaryShow() == true{
                btn_Lang.setImage(UIImage(named:"icon_Dictionary2-1"), for: UIControlState.normal)
            }
            break
        case 3?:
            btn_Lang.setImage(UIImage(named:"icon_Dictionary3"), for: UIControlState.normal)
            break
        default:
            break
        }
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        dismiss(animated:true, completion: nil)
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



class ExamplePopUpTableViewCell: UITableViewCell {
    
    // MARK: - Table Cell -
    @IBOutlet var lbl_Title: UILabel!
    
}

// MARK: - Table Delegate -
extension ExamplePopUpViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr_Data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier : String = "cell"
        if indexPath.row == 1{
            cellIdentifier = "cell1"
        }else if indexPath.row == 2{
            cellIdentifier = "cell2"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! ExamplePopUpTableViewCell
        
        cell.lbl_Title.text = arr_Data[indexPath.row] as! String
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}

