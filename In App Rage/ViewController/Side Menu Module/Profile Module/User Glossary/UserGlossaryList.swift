//
//  UserGlossaryList.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit

class UserGlossaryList: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Method -
    func commanMethod(){
        
    }
    
    //MARK: - Button Method -
    @IBAction func addCategoryClick(_ sender: UIButton) {
//        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
    @IBAction func createCategoryHiddenClick(_ sender: UIButton) {
//        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
    @IBAction func createCategoryPopupDoneClick(_ sender: UIButton) {
//        vwCreateCategory.isHidden = !vwCreateCategory.isHidden
    }
    @IBAction func btn_Redirect(_ sender: UIButton) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SearchQuizletViewController") as! SearchQuizletViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    @IBAction func btn_Back(_ sender:Any){
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
//MARK: - Collection View -
extension UserGlossaryList : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       return CGSize(width: CGFloat((GlobalConstants.windowWidth-20)/3), height: CGFloat(((GlobalConstants.windowWidth-20)/3) * 1.375))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var str_Identifier : String  = "cellVocablist"

        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: str_Identifier, for: indexPath) as! VocablistCell
        
        cell.lblCategory.text = "Category \(indexPath.row + 1)"
        
        //Manage font
        cell.lblCategory.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        cell.lblPercentage.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        cell.lblWords.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        
        cell.btnAdd.addTarget(self, action:#selector(addCategoryClick(_:)), for: .touchUpInside)
        
        cell.btnSearchOnline.isHidden = true
        cell.lblWords.isHidden = false
        cell.lblPercentage.isHidden = false
        cell.lblCategory.isHidden = false
        cell.btnAdd.isHidden = true
        cell.imgVwBackground.image = UIImage(named:"box2")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "subcategory", sender: self)
        
    }
}
extension UserGlossaryList: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
