//
//  ForumCreateViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 17/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftMessages

class ForumCreateViewController: UIViewController {
    
    //textfield declaration
    @IBOutlet weak var tf_Title: UITextField!
    @IBOutlet weak var tv_Descriptin: UITextView!
    
    //Constant
    @IBOutlet weak var con_BottomTextView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
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
         //   self.con_BottomTextView.constant = 0
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
        //    self.con_BottomTextView.constant =  keyboardHeight
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
    
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_NavigationRight(_ sender: Any) {
        if((tf_Title.text?.isEmpty)!){
            //Alert show for Header
            messageBar.MessageShow(title: "Please enter forum title", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }else if((tv_Descriptin.text?.isEmpty)! || tv_Descriptin.text == "Decription"){
            //Alert show for Header
            messageBar.MessageShow(title: "Please enter forum description", alertType: MessageView.Layout.cardView, alertTheme: .error, TopBottom: true)
        }else{
            messageBar.MessageShow(title: "Forum added successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
            view.endEditing(true)
            self.dismiss(animated: true, completion: nil)
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

extension ForumCreateViewController : UITextViewDelegate{
    // MARK: - Scrollview Manage -
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Decription" {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Decription"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        self.view.layoutIfNeeded()
    }
}
