//
//  CardDetailsViewController.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit



class CardDetailsViewController: UIViewController {
    //Collectionview declaration
    @IBOutlet weak var cv_HeaderSelection : UICollectionView!
    
    //Other declaationdeclaration
    var indexpath_Header : NSIndexPath = NSIndexPath(row: 0, section: 0)
    var arr_Header = ["Review","Subcategory","All Words"]
    
    //Tabbar button
    @IBOutlet weak var btnProfile : UIButton!
    @IBOutlet weak var btnChatOther : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
        //        cardDetailsView = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Page view controller -
    var CardPageViewController: CardPageViewController? {
        didSet {
            CardPageViewController?.tutorialDelegate = self
        }
    }
    
    //MARK: - Other Files -
    func commanMethod(){
        cv_HeaderSelection.backgroundColor = UIColor(patternImage: image(with:GlobalConstants.appColor))
        self.navigationItem.titleView = UIImageView.init(image: UIImage(named:"navigationTitle"))
        
        //Tab Bar Button
        btnProfile.layer.cornerRadius = btnProfile.frame.size.width/2
        btnProfile.layer.masksToBounds = true
        
        btnChatOther.layer.cornerRadius = btnProfile.frame.size.width/2
        btnChatOther.layer.masksToBounds = true
        
        if objUser?.user_Type == "1"{
            btnChatOther.isHidden = false
        }else{
            btnChatOther.isHidden = true
        }
    }
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        //        toggleLeft()
        self.navigationController?.popViewController(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let CardPageViewController = segue.destination as? CardPageViewController {
            self.CardPageViewController = CardPageViewController
        }
    }
    @IBAction func btn_NavigationRight(_ sender: Any) {
        AsStudent = "0"
        let view = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    @IBAction func btn_NavigationRight2(_ sender: Any) {
        AsStudent = "1"
        let view = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(view, animated: true)
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
extension CardDetailsViewController: CardPageViewControllerDelegate {
    
    func CardPageViewController(_ CardPageViewController: CardPageViewController, didUpdatePageCount count: Int) {
        
    }
    func CardPageViewController(_ CardPageViewController: CardPageViewController,
                                didUpdatePageIndex index: Int) {
        indexpath_Header = NSIndexPath(row: index, section: 0)
        self.cv_HeaderSelection.reloadData()
        
        CardPageViewController.scrollToViewController(index: index)
        //        cv_Main_TabBar.reloadData()
    }
    
}

//MARK: - Collection View -
extension CardDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr_Header.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        let str_Image : String = arr_Header[indexPath.row]
        //        let starWidth = str_Image.widthOfString(usingFont: UIFont(name:  GlobalConstants.kFontBold, size: 16)!) + 20
        
        return CGSize(width: CGFloat(GlobalConstants.windowWidth/3), height: collectionView.frame.size.height)
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
            let btnImage = UIImage(named: "review_un")
            btnIcon.setImage(btnImage , for: .normal)
            let btnImage2 = UIImage(named: "review_se")
            btnIcon.setImage(btnImage2 , for:.selected)
        }else if indexPath.row == 1 {
            let btnImage = UIImage(named: "subcategory_un")
            btnIcon.setImage(btnImage , for:.normal)
            let btnImage1 = UIImage(named: "subcategory_se")
            btnIcon.setImage(btnImage1 , for:.selected)
        }else {
            let btnImage = UIImage(named: "allwords_un")
            btnIcon.setImage(btnImage , for: .normal)
            let btnImage2 = UIImage(named: "allwords_se")
            btnIcon.setImage(btnImage2 , for:.selected)
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
        CardPageViewController?.scrollToPreviewsViewController(indexCall:indexPath.row)
        indexpath_Header = indexPath as NSIndexPath
        cv_HeaderSelection.reloadData()
    }
}
