//
//  ChatViewController.swift
//  Minnaz
//
//  Created by Apple on 03/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
  //Collectionview declaration
  @IBOutlet weak var cv_HeaderSelection : UICollectionView!
    
  //Other declaationdeclaration
  var indexpath_Header : NSIndexPath = NSIndexPath(row: 0, section: 0)
  var arr_Header = ["Messages","Contacts"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //MARK: - Other Files -
  func commanMethod() {
    cv_HeaderSelection.backgroundColor = UIColor(patternImage: image(with:GlobalConstants.appColor))
    
     if AsStudent == "0"{
        arr_Header = ["Messages","Contacts"]
     }else{
        arr_Header = ["Messages","My Class"]
    }
  }
    
    
    //MARK: - Page view controller -
    var ChatPageViewController: ChatPageViewController? {
      didSet {
        ChatPageViewController?.tutorialDelegate = self
      }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let ChatPageViewController = segue.destination as? ChatPageViewController {
        self.ChatPageViewController = ChatPageViewController
        
      }
    }
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
      //        toggleLeft()
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

//MARK: - Pageview controller Delegate -
extension ChatViewController: ChatPageViewControllerDelegate {
  
  func ChatPageViewController(_ ChatPageViewController: ChatPageViewController, didUpdatePageCount count: Int) {
    
  }
  func ChatPageViewController(_ ChatPageViewController: ChatPageViewController,
                              didUpdatePageIndex index: Int) {
    indexpath_Header = NSIndexPath(row: index, section: 0)
    self.cv_HeaderSelection.reloadData()
    
    ChatPageViewController.scrollToViewController(index: index)
    //        cv_Main_TabBar.reloadData()
  }
  
}

//MARK: - Collection View -
extension ChatViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return arr_Header.count
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    //        let str_Image : String = arr_Header[indexPath.row]
    //        let starWidth = str_Image.widthOfString(usingFont: UIFont(name:  GlobalConstants.kFontBold, size: 16)!) + 20
    
    return CGSize(width: CGFloat(GlobalConstants.windowWidth/2), height: collectionView.frame.size.height)
  }

  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    
    let lbl_Title : UILabel = cell.viewWithTag(100) as! UILabel
    let lbl_Image : UIImageView = cell.viewWithTag(101) as! UIImageView
    let btnIcon : UIButton = cell.viewWithTag(102) as! UIButton
    
    lbl_Title.text = arr_Header[indexPath.row]
    
    //Manage font
    lbl_Title.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
    
    if indexPath.row == 0 {
      let btnImage = UIImage(named: "message_un")
      btnIcon.setImage(btnImage , for: .normal)
      let btnImage2 = UIImage(named: "message_se")
      btnIcon.setImage(btnImage2 , for:.selected)
    }else if indexPath.row == 1 {
      let btnImage = UIImage(named: "contact_un")
      btnIcon.setImage(btnImage , for:.normal)
      let btnImage1 = UIImage(named: "contact_se")
      btnIcon.setImage(btnImage1 , for:.selected)
    }else if indexPath.row == 2 {
        let btnImage = UIImage(named: "contact_un")
        btnIcon.setImage(btnImage , for:.normal)
        let btnImage1 = UIImage(named: "contact_se")
        btnIcon.setImage(btnImage1 , for:.selected)
    }

    
    
    lbl_Title.textColor = UIColor.white
    lbl_Image.isHidden = true
    btnIcon.isSelected = false
    
    if indexpath_Header.row == indexPath.row {
      lbl_Title.textColor = GlobalConstants.appGreenColor
      lbl_Image.isHidden = false
      btnIcon.isSelected = true
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    ChatPageViewController?.scrollToPreviewsViewController(indexCall:indexPath.row)
    indexpath_Header = indexPath as NSIndexPath
    cv_HeaderSelection.reloadData()
  }
}
