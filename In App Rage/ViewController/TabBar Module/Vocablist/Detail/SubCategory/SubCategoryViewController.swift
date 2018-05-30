//
//  SubCategoryViewController.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import Floaty
import SwiftMessages

var selectedSection: Int = -1

class SubCategoryViewController: UIViewController,FloatyDelegate,DismissEditDeleteMoveCategoryDelegate,DismissViewDelegate {
    
    @IBOutlet var vwCreateCategory : UIView!
    
    //Other Declaration
    @IBOutlet weak var vw_Floty: Floaty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        vw_Floty.close()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Method -
    func commanMethod(){
        
        let item = FloatyItem()
        item.hasShadow = true
        item.buttonColor = UIColor(red: 124/255, green: 224/255, blue: 195/255, alpha: 1.0)
        item.titleColor = UIColor.white
        item.titleShadowColor = UIColor(red: 127/255, green: 191/255, blue: 101/255, alpha: 1.0)
        item.icon = UIImage(named:"icon_SearchPopUp")
        item.title = " "
        item.handler = { item in
            self.performSegue(withIdentifier: "segueShowQuizletSearch", sender: self)
            self.vw_Floty.close()
        }
        vw_Floty.addItem(item: item)
        
        let item2 = FloatyItem()
        item2.hasShadow = true
        item2.buttonColor = UIColor(red: 124/255, green: 224/255, blue: 195/255, alpha: 1.0)
        item2.titleColor = UIColor.white
        item2.titleShadowColor = UIColor(red: 127/255, green: 191/255, blue: 101/255, alpha: 1.0)
        item2.icon = UIImage(named:"icon_AddPopUp")
        item2.title = " "
        item2.handler = { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true)
            self.vw_Floty.close()
        }
        vw_Floty.addItem(item: item2)
        
    }
    func ClickOptionEditCategory(info: NSInteger) {
        if info == 1 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "RenameCategoryViewController") as! RenameCategoryViewController
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true)
            
        }else if info == 2{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
            view.bool_Home = true
            view.delegate = self
            view.bool_CategorySubcategoryShow = false
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            present(view, animated: true)
        }else if info == 3{
            let alert = UIAlertController(title: GlobalConstants.appName, message: "Are you sure you want to delete this Sub Category ?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                //Alert show for Header
                messageBar.MessageShow(title: "Sub Category Deleted Successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func ClickOption(info: NSInteger) {
        if info == 1 {
            
        }
    }
    
    //MARK: - Button Method -
    @IBAction func addCategoryClick(_ sender: UIButton) {
        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
    @IBAction func createCategoryHiddenClick(_ sender: UIButton) {
        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
    @IBAction func createCategoryPopupDoneClick(_ sender: UIButton) {
        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
    @IBAction func btn_Redirect(_ sender: UIButton) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SearchQuizletViewController") as! SearchQuizletViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    @objc func longPressEvent(_ sender: UILongPressGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "EditDeleteMoveCategoryViewController") as! EditDeleteMoveCategoryViewController
        view.bool_Move = true
        view.delegate = self
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        self.present(view, animated: true)
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
//MARK: - Collection View -
extension SubCategoryViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

         return CGSize(width: CGFloat((GlobalConstants.windowWidth-20)/3), height: CGFloat(((GlobalConstants.windowWidth-20)/3) * 1.375))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var str_Identifier : String  = "cellVocablist"
        
        //    if indexPath.row == 0{
        //        str_Identifier = "first"
        //    }
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: str_Identifier, for: indexPath) as! VocablistCell
        
        
        if objUser?.user_Type == "0"{
            cell.lblCategory.text = "Category \(indexPath.row + 1)"
            
        }else{
            if indexPath.row == 0 {
                cell.lblCategory.text = "School"
            }else{
                cell.lblCategory.text = "Category \(indexPath.row)"
            }
        }
        
        //Manage font
        cell.lblCategory.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        cell.lblPercentage.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        cell.lblWords.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        
        
        //    if indexPath.row == 0 {
        //        cell.btnAdd.addTarget(self, action:#selector(btn_Redirect(_:)), for: .touchUpInside)
        //
        //    }else {
        
        cell.btnAdd.addTarget(self, action:#selector(addCategoryClick(_:)), for: .touchUpInside)
        
        cell.btnSearchOnline.isHidden = true
        cell.lblWords.isHidden = false
        cell.lblPercentage.isHidden = false
        cell.lblCategory.isHidden = false
        cell.btnAdd.isHidden = true
        cell.imgVwBackground.image = UIImage(named:"box2")
        
        var longPressGesture = UILongPressGestureRecognizer()
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressEvent(_:)))
        longPressGesture.isEnabled = true
        cell.addGestureRecognizer(longPressGesture)
        
        //    }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //         if indexPath.row != 0 {
        
        str_CatgorySaved = "Category/Sub1"
        let indexpath_Header : NSIndexPath = NSIndexPath(row: 0, section: 0)
        cardDetailsView?.collectionView((cardDetailsView?.cv_HeaderSelection)!, didSelectItemAt: indexpath_Header as IndexPath)
        selectedSection = indexPath.row
        //        }
        //    cardDetailsView?.scrollToPreviewsViewController(indexCall:indexPath.row)
        
        
        //    self.performSegue(withIdentifier: "segueCardDetails", sender: self)
    }
}
extension SubCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
