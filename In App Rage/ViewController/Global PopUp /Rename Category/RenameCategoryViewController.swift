//
//  RenameCategoryViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 13/02/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages

class RenameCategoryViewController: UIViewController {

    //Declaration TextFiled
    @IBOutlet weak var tf_CategoryName: UITextField!
    
    //Declaration Button
    @IBOutlet weak var btn_Accept: UIButton!
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        dismiss(animated:true, completion: nil)
    }
    @IBAction func btn_Accept(_ sender:Any){
        if tf_CategoryName.text != ""{
            
            //Alert show for Header
            messageBar.MessageShow(title: "Rename Category Successfully" as NSString, alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
        
            dismiss(animated:true, completion: nil)
        }
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
