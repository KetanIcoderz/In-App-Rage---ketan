//
//  UserGlossaryWord.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import SwiftMessages

class UserGlossaryWord: UIViewController, DismissViewDelegate {
    var isShowCardAllDetails: Bool = false
    var longPressGesture = UILongPressGestureRecognizer()
    
    var arrCards = [Array<CardDetailsObject>]()
    
    var bool_Move : Bool = false
    
    @IBOutlet var collectionVw: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        bool_Move = true
        
        if selectedSection != -1 {
            
            let when = DispatchTime.now() + 0.3
            DispatchQueue.main.asyncAfter(deadline: when) {
                if let attributes = self.collectionVw.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: NSIndexPath.init(row: 0, section: selectedSection-1) as IndexPath) {
                    self.collectionVw.setContentOffset(CGPoint(x: 0, y: attributes.frame.origin.y - self.collectionVw.contentInset.top), animated: true)
                }
                selectedSection = -1
            }
        }else{
            if let attributes = collectionVw.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: NSIndexPath.init(row: 0, section: 0) as IndexPath) {
                collectionVw.setContentOffset(CGPoint(x: 0, y: attributes.frame.origin.y - collectionVw.contentInset.top), animated: true)
            }
        }
        collectionVw.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Custom Method -
    func setupView() {
        var subArray1:[CardDetailsObject] = []
        
        var obj = CardDetailsObject()
        obj.strCardName = "Bill"
        obj.strCardImageUrl = "photoDefault"
        obj.strCardOtherMeaning = "Car"
        obj.strCardGoogleMeaning = "Car"
        obj.isCardFront = true
        subArray1.append(obj)
        
        obj = CardDetailsObject()
        obj.strCardName = "Bill"
        obj.strCardImageUrl = "photoDefault"
        obj.strCardOtherMeaning = "Car"
        obj.strCardGoogleMeaning = "Car"
        obj.isCardFront = true
        subArray1.append(obj)
        
        obj = CardDetailsObject()
        obj.strCardName = "Bill"
        obj.strCardImageUrl = "photoDefault"
        obj.strCardOtherMeaning = "Car"
        obj.strCardGoogleMeaning = "Car"
        obj.isCardFront = true
        subArray1.append(obj)
        
        obj = CardDetailsObject()
        obj.strCardName = "Bill"
        obj.strCardImageUrl = "photoDefault"
        obj.strCardOtherMeaning = "Car"
        obj.strCardGoogleMeaning = "Car"
        obj.isCardFront = true
        subArray1.append(obj)
        
        obj = CardDetailsObject()
        obj.strCardName = "Bill"
        obj.strCardImageUrl = "photoDefault"
        obj.strCardOtherMeaning = "Car"
        obj.strCardGoogleMeaning = "Car"
        obj.isCardFront = true
        subArray1.append(obj)
        
        obj = CardDetailsObject()
        obj.strCardName = "Bill"
        obj.strCardImageUrl = "photoDefault"
        obj.strCardOtherMeaning = "Car"
        obj.strCardGoogleMeaning = "Car"
        obj.isCardFront = true
        subArray1.append(obj)
        
        arrCards.append(subArray1)
        
    }
    
    func ClickOption(info: NSInteger) {
        if info == 1 {
            
        }
    }
    
    //MARK: - Gesture Method -
    //Called, when long press occurred
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if bool_Move == true{
            
//            let view = self.storyboard?.instantiateViewController(withIdentifier: "ReviewDetailViewController") as! ReviewDetailViewController
//            self.navigationController?.pushViewController(view, animated: true)
//
//            bool_Move = false
        }
        
    }
    
    @objc func tapBarButton(_ sender: UITapGestureRecognizer) {
        
        let p = sender.location(in: collectionVw)
        if let indexPath = collectionVw.indexPathForItem(at: p) {
            // get the cell at indexPath (the one you long pressed)
            let subArr =  arrCards[indexPath.section]
            let obj = subArr[indexPath.row]
            if obj.isCardFront {
                obj.isCardFront = false
                let cell = collectionVw.cellForItem(at: indexPath)
                UIView.transition(with: cell!, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                self.showHideOtherViews(cell as! AllWordsCell, isShow: false)
                longPressGesture.isEnabled = true
            }else {
                obj.isCardFront = true
                let cell = collectionVw.cellForItem(at: indexPath)
                UIView.transition(with: cell!, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                self.showHideOtherViews(cell as! AllWordsCell, isShow: true)
                longPressGesture.isEnabled = true
            }
            //        collectionVw.reloadData()
            // do stuff with the cell
        } else {
            print("couldn't find index path")
        }
        
        ///
        /*
         if isShowCardAllDetails {
         isShowCardAllDetails = false
         let p = sender.location(in: collectionVw)
         
         if let indexPath = collectionVw.indexPathForItem(at: p) {
         // get the cell at indexPath (the one you long pressed)
         let cell = collectionVw.cellForItem(at: indexPath)
         UIView.transition(with: cell!, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
         self.showHideOtherViews(cell as! AllWordsCell, isShow: true)
         longPressGesture.isEnabled = true
         // do stuff with the cell
         } else {
         print("couldn't find index path")
         }
         
         }else {
         isShowCardAllDetails = true
         let p = sender.location(in: collectionVw)
         
         if let indexPath = collectionVw.indexPathForItem(at: p) {
         // get the cell at indexPath (the one you long pressed)
         let cell = collectionVw.cellForItem(at: indexPath)
         // do stuff with the cell
         UIView.transition(with: cell!, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
         longPressGesture.isEnabled = true
         self.showHideOtherViews(cell as! AllWordsCell, isShow: false)
         //          self.showAndHideOtherViews(false)
         } else {
         print("couldn't find index path")
         }
         }
         */
    }
    
    func showHideOtherViews(_ cell: AllWordsCell, isShow: Bool) {
        
        cell.imgVwWordPhoto.isHidden = isShow
        cell.lblWordCenter.isHidden = !isShow
        cell.lblWord.isHidden = isShow
        cell.lblGoogleMeaning.isHidden = isShow
        cell.lblOtherDictMeaning.isHidden = isShow
        cell.btnGoogle.isHidden = isShow
        cell.btnOtherDict.isHidden = isShow
        cell.btnSpeak.isHidden = isShow
        
    }
    
    //MARK: Button Event -
    @IBAction func btn_Back(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Download(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SelectCategoryPopUpViewController") as! SelectCategoryPopUpViewController
        view.bool_Home = true
        view.str_AlertTitle = "Save all words if this category to "
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
extension UserGlossaryWord: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let subArr = arrCards[section]
        return subArr.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return arrCards.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((GlobalConstants.windowWidth-20)/3), height: CGFloat(((GlobalConstants.windowWidth-20)/3) * 1.375))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView : UICollectionReusableView? = nil
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            let lblTitle: UILabel = headerView.viewWithTag(100) as! UILabel
            lblTitle.text = String(format:"Sub Category %d",indexPath.section+1)
            
            //Manage font
            lblTitle.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
            
            headerView.backgroundColor = UIColor.clear;
            return headerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
        
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellVocablist", for: indexPath) as! AllWordsCell
        //    cell.lblWordCenter.text = String(format:"Lesson %d",indexPath.row)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBarButton(_:)))
        
        let tapGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        cell.addGestureRecognizer(tapGesture2)
        
        
        cell.addGestureRecognizer(tapGesture)
        let arrSub = arrCards[indexPath.section]
        let objCard = arrSub[indexPath.row]
        
        let subArr =  arrCards[indexPath.section]
        let obj = subArr[indexPath.row]
        if obj.isCardFront {
            self.showHideOtherViews(cell , isShow: true)
        }else {
            self.showHideOtherViews(cell , isShow: false)
        }
        
        cell.imgVwWordPhoto.image = UIImage.init(named: (objCard.strCardImageUrl))
        cell.lblWord.text = objCard.strCardName
        cell.lblWordCenter.text = objCard.strCardName
        cell.lblGoogleMeaning.text = objCard.strCardGoogleMeaning
        cell.lblOtherDictMeaning.text = objCard.strCardOtherMeaning
        
        //Manage font
        cell.lblWord.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
        
        //    self.showHideOtherViews(cell , isShow: !objCard.isCardFront)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //    self.performSegue(withIdentifier: "segueCardDetails", sender: self)
    }
}
