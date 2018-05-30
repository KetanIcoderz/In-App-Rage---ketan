//
//  LinksViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 09/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class LinksViewController: UIViewController {
    
    //Declaration Tableview
    @IBOutlet var tbl_Main : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


// MARK: - Tableview Files -
class LinkTableviewCell : UITableViewCell{
    //MARK: - Tableview View Cell -
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var img_Title: UIImageView!
}


extension LinksViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    
        return CGFloat(Int((GlobalConstants.windowHeight * 60)/GlobalConstants.screenHeightDeveloper))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var str_Identifier : String = "cell"

        let cell = tableView.dequeueReusableCell(withIdentifier: str_Identifier, for:indexPath as IndexPath) as! LinkTableviewCell
        
        cell.lbl_Title.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))

        switch indexPath.row {
        case 0:
            cell.lbl_Title.text = "External Link"
            cell.img_Title.image = UIImage(named:"icon_Youtube")

            break
        case 1:
            cell.lbl_Title.text = "External Link"
            cell.img_Title.image = UIImage(named:"icon_Crome")

            break
        case 2:
            cell.lbl_Title.text = "External Link"
            cell.img_Title.image = UIImage(named:"icon_Youtube")

            break
        case 3:
            cell.lbl_Title.text = "External Link"
            cell.img_Title.image = UIImage(named:"icon_Crome")
            
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}



