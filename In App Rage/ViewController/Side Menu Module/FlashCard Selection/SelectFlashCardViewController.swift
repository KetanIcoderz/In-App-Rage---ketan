//
//  SelectFlashCardViewController.swift
//  Minnaz
//
//  Created by Apple on 27/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit

class SelectFlashCardViewController: UIViewController {
    var arrColor:[UIColor] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    // MARK: - Setup View
    func viewSetup() {
      arrColor.append(UIColor(red: 0/255, green: 201/255, blue: 55/255, alpha: 1.0))
      arrColor.append(UIColor(red: 76/255, green: 131/255, blue: 253/255, alpha: 1.0))
      arrColor.append(UIColor(red: 164/255, green: 83/255, blue: 251/255, alpha: 1.0))
      arrColor.append(UIColor(red: 249/255, green: 70/255, blue: 179/255, alpha: 1.0))
      arrColor.append(UIColor(red: 188/255, green: 180/255, blue: 2/255, alpha: 1.0))
      arrColor.append(UIColor(red: 242/255, green: 249/255, blue: 56/255, alpha: 1.0))
      arrColor.append(UIColor(red: 178/255, green: 236/255, blue: 2/255, alpha: 1.0))
      arrColor.append(UIColor(red: 51/255, green: 255/255, blue: 180/255, alpha: 1.0))
      arrColor.append(UIColor(red: 43/255, green: 255/255, blue: 43/255, alpha: 1.0))
      arrColor.append(UIColor(red: 255/255, green: 210/255, blue: 3/255, alpha: 1.0))
      arrColor.append(UIColor(red: 255/255, green: 164/255, blue: 2/255, alpha: 1.0))
      arrColor.append(UIColor(red: 255/255, green: 174/255, blue: 87/255, alpha: 1.0))
      arrColor.append(UIColor(red: 255/255, green: 73/255, blue: 1/255, alpha: 1.0))
      arrColor.append(UIColor(red: 151/255, green: 123/255, blue: 182/255, alpha: 1.0))
      arrColor.append(UIColor(red: 242/255, green: 143/255, blue: 185/255, alpha: 1.0))
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
extension SelectFlashCardViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return arrColor.count
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    //        let str_Image : String = arr_Header[indexPath.row]
    //        let starWidth = str_Image.widthOfString(usingFont: UIFont(name:  GlobalConstants.kFontBold, size: 16)!) + 20
    
    return CGSize(width: CGFloat(GlobalConstants.windowWidth/5), height: collectionView.frame.size.height)
  }
 
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    let viewColor : UIView = (cell.viewWithTag(100))!
    viewColor.backgroundColor = arrColor[indexPath.row]
//    let lbl_Title : UILabel = cell.viewWithTag(100) as! UILabel
//    let lbl_Image : UIImageView = cell.viewWithTag(101) as! UIImageView
//    let btnIcon : UIButton = cell.viewWithTag(102) as! UIButton
//    lbl_Title.text = arr_Header[indexPath.row]
//    if indexPath.row == 0 {
//      let btnImage = UIImage(named: "tab1_un")
//      btnIcon.setImage(btnImage , for: .normal)
//      let btnImage2 = UIImage(named: "tab1_se")
//      btnIcon.setImage(btnImage2 , for:.selected)
//    }else if indexPath.row == 1 {
//      let btnImage = UIImage(named: "tab2_un")
//      btnIcon.setImage(btnImage , for:.normal)
//      let btnImage1 = UIImage(named: "tab2_se")
//      btnIcon.setImage(btnImage1 , for:.selected)
//    }else {
//      let btnImage = UIImage(named: "tab3_un")
//      btnIcon.setImage(btnImage , for: .normal)
//      let btnImage2 = UIImage(named: "tab3_se")
//      btnIcon.setImage(btnImage2 , for:.selected)
//    }
//    lbl_Title.textColor = UIColor.white
//    lbl_Image.isHidden = true
//    btnIcon.isSelected = false
//
//
//    if indexpath_Header.row == indexPath.row {
//      lbl_Title.textColor = GlobalConstants.appGreenColor
//      lbl_Image.isHidden = false
//      btnIcon.isSelected = true
//    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    HomePageViewController?.scrollToPreviewsViewController(indexCall:indexPath.row)
//    indexpath_Header = indexPath as NSIndexPath
//    cv_HeaderSelection.reloadData()
  }
}
