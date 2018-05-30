//
//  VocablistViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 16/11/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import Floaty
import SwiftMessages

class VocablistViewController: UIViewController,FloatyDelegate,DismissEditDeleteMoveCategoryDelegate {
    
    @IBOutlet var vwCreateCategory : UIView!
    
    //Other Declaration
    @IBOutlet weak var vw_Floty: Floaty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
        
        
        
        
        
        
        //        item.icon = UIImage(named:"icon_AddAnimation")
        //        item.title = "Add"
        //        item.handler = { item in
        //            self.vw_Floty.close()
        //        }
        //        vw_Floty.addItem(item: item)
        
    }
    func ClickOptionEditCategory(info: NSInteger) {
        if info == 1 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "RenameCategoryViewController") as! RenameCategoryViewController
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true)
            
        }else if info == 3{
            let alert = UIAlertController(title: GlobalConstants.appName, message: "Are you sure you want to delete this Category ?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                //Alert show for Header
                messageBar.MessageShow(title: "Sub Category Deleted Successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Button Method -
    @IBAction func btn_Section(_ sender: Any) {
        self.performSegue(withIdentifier: "segueShowQuizletSearch", sender: self)
    }
    @objc func longPressEvent(_ sender: UILongPressGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "EditDeleteMoveCategoryViewController") as! EditDeleteMoveCategoryViewController
        view.delegate = self
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        self.present(view, animated: true)
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if cardDetailsView == nil{
            cardDetailsView = segue.destination as! CardDetailsViewController
        }
    }
    
    
    @IBAction func addCategoryClick(_ sender: UIButton) {
        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
    @IBAction func createCategoryHiddenClick(_ sender: UIButton) {
        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
    @IBAction func createCategoryPopupDoneClick(_ sender: UIButton) {
        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
}
class VocablistCell : UICollectionViewCell {
    
    @IBOutlet var imgVwBackground: UIImageView!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblPercentage: UILabel!
    @IBOutlet var lblWords: UILabel!
    @IBOutlet var btnSearchOnline: UIButton!
    
}
extension VocablistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK: - Collection View -
extension VocablistViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((GlobalConstants.windowWidth-20)/3), height: CGFloat(((GlobalConstants.windowWidth-20)/3) * 1.375))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellVocablist", for: indexPath) as! VocablistCell
        cell.btnSearchOnline.addTarget(self, action:#selector(btn_Section(_:)), for: .touchUpInside)
        cell.btnAdd.addTarget(self, action:#selector(addCategoryClick(_:)), for: .touchUpInside)
        
        //Manage font
        cell.lblCategory.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        cell.lblPercentage.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        cell.lblWords.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        
        if objUser?.user_Type == "0"{
            cell.lblCategory.text = "Category \(indexPath.row + 1)"
            
        }else{
            if indexPath.row == 0 {
                cell.lblCategory.text = "School"
            }else{
                cell.lblCategory.text = "Category \(indexPath.row)"
            }
        }
        
        var longPressGesture = UILongPressGestureRecognizer()
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressEvent(_:)))
        longPressGesture.isEnabled = true
        cell.addGestureRecognizer(longPressGesture)
        
        
        //    if indexPath.row == 0 {
        //      cell.btnAdd.isHidden = false
        //      cell.lblWords.isHidden = true
        //      cell.lblPercentage.isHidden = true
        //      cell.lblCategory.isHidden = true
        //      cell.imgVwBackground.image = UIImage(named:"box1")
        //      cell.btnSearchOnline.isHidden = false
        //
        //    }else {
        cell.btnSearchOnline.isHidden = true
        cell.lblWords.isHidden = false
        cell.lblPercentage.isHidden = false
        cell.lblCategory.isHidden = false
        cell.btnAdd.isHidden = true
        cell.imgVwBackground.image = UIImage(named:"box2")
        
        //    }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueCardDetails", sender: self)
    }
}
