//
//  EditDeleteMoveCategoryViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 13/02/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

protocol DismissEditDeleteMoveCategoryDelegate: class {
    func ClickOptionEditCategory(info: NSInteger)
}

class EditDeleteMoveCategoryViewController: UIViewController {

    weak var delegate :DismissEditDeleteMoveCategoryDelegate? = nil
    
    @IBOutlet weak var con_Width: NSLayoutConstraint!
    
    //Declaration TextFiled
    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var btn_Delete: UIButton!
    @IBOutlet weak var btn_Move: UIButton!
    
    //Declaration TextFiled
    @IBOutlet weak var lbl_Edit: UILabel!
    @IBOutlet weak var lbl_Delete: UILabel!
    @IBOutlet weak var lbl_Move: UILabel!
    
    var bool_Move : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if bool_Move == false{
            btn_Move.removeFromSuperview()
            lbl_Move.removeFromSuperview()
            con_Width.constant = 134
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        dismiss(animated:true, completion: nil)
    }
    @IBAction func btn_Edit(_ sender:Any){
        self.dismiss(animated: true) {
            self.delegate?.ClickOptionEditCategory(info: 1)
        }
    }
    @IBAction func btn_Move(_ sender:Any){
        self.dismiss(animated: true) {
            self.delegate?.ClickOptionEditCategory(info: 2)
        }
    }
    @IBAction func btn_Delete(_ sender:Any){
        self.dismiss(animated: true) {
            self.delegate?.ClickOptionEditCategory(info: 3)
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
