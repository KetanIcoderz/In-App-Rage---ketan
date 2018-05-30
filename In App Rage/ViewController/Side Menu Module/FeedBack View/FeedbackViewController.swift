//
//  FeedbackViewController.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages
import ActionSheetPicker_3_0
class FeedbackViewController: UIViewController {
  
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var tvReview: UITextView!
    @IBOutlet weak var btnSelectSubject: UIButton!
    @IBOutlet weak var lblSubject: UILabel!
    
    var bool_Nav : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        if bool_Nav == false{
            toggleLeft()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func submitClick(_ sender: UIButton) {
      let isValidEmail : Bool = false
      if (txtName.text?.isEmpty)! {
         txtName.becomeFirstResponder()
         messageBar.MessageShow(title: "Please enter your name", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
      }else if(txtEmail.text?.isEmpty)! {
        txtEmail.becomeFirstResponder()
        messageBar.MessageShow(title: "Please enter email address", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
      }else if(tvReview.text?.isEmpty)! {
        tvReview.becomeFirstResponder()
        messageBar.MessageShow(title: "Please enter review text", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
      }else if (isValidEmail ==  validateEmail(enteredEmail: txtEmail.text!)) {
        messageBar.MessageShow(title: "Please enter valid email address", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
      }else {
        
         messageBar.MessageShow(title: "Feedback submited successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
        
        if bool_Nav == false{
            toggleLeft()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
      }
    }
    @IBAction func selectSubjectClick(_ sender: UIButton) {
        let arr_Data: [Any] = ["Feature Request","Other Request"]
      
        let str_Title = "Feature Request"
      
        let picker = ActionSheetStringPicker(title: "Select Subject", rows: arr_Data, initialSelection:selectedIndex(arr: arr_Data as NSArray, value: (str_Title as? NSString)!), doneBlock: { (picker, indexes, values) in
          
          self.lblSubject.text = values as! String
//          self.tbl_Main.reloadData()
          
          if indexes == 0{
            //Set button title for selected button and save button
            //                        btn?.setTitle("Sort", for: .normal)
            //                        self.btn_Filter_Section_Save?.setTitle("Sort", for: .normal)
          }else{
            //Set button title for selected button and save button
            //                        btn?.setTitle(values as! String?, for: .normal)
            //                        self.btn_Filter_Section_Save?.setTitle(values as! String?, for: .normal)
          }
          
          
        }, cancel: {ActionSheetStringPicker in return}, origin: btnSelectSubject)
      
        picker?.hideCancel = false
        picker?.setDoneButton(UIBarButtonItem(title: "DONE", style: .plain, target: nil, action: nil))
        picker?.toolbarButtonsColor = UIColor.black
      
        picker?.show()
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
