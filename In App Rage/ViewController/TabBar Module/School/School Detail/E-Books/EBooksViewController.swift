//
//  EBooksViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 09/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class EBooksViewController: UIViewController {

    //Declaration Tableview
    @IBOutlet var cv_Main : UICollectionView!
    
    //Aarray declartion
    var arr_Main : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Other Files -
    func commanMethod(){
        
        var obj = EBooksViewControllerObject ()
        obj.str_Name = "EBook 1"
        obj.str_Image = "1"
        obj.str_Date = "15-5-2017"
        obj.str_Remainig = "2 days"
        arr_Main.add(obj)
        
        obj = EBooksViewControllerObject ()
        obj.str_Name = "EBook 2"
        obj.str_Image = "21"
        obj.str_Date = "15-5-2017"
        obj.str_Remainig = "2 days"
        arr_Main.add(obj)
        
        obj = EBooksViewControllerObject ()
        obj.str_Name = "EBook 3"
        obj.str_Image = "21"
        obj.str_Date = "15-5-2017"
        obj.str_Remainig = "2 days"
        arr_Main.add(obj)
        
        obj = EBooksViewControllerObject ()
        obj.str_Name = "EBook 4"
        obj.str_Image = "21"
        obj.str_Date = "15-5-2017"
        obj.str_Remainig = "2 days"
        arr_Main.add(obj)
        
        obj = EBooksViewControllerObject ()
        obj.str_Name = "EBook 5"
        obj.str_Image = "21"
        obj.str_Date = "15-5-2017"
        obj.str_Remainig = "2 days"
        arr_Main.add(obj)
        
        obj = EBooksViewControllerObject ()
        obj.str_Name = "EBook 6"
        obj.str_Image = "21"
        obj.str_Date = "15-5-2017"
        obj.str_Remainig = "2 days"
        arr_Main.add(obj)
        
        obj = EBooksViewControllerObject ()
        obj.str_Name = "EBook 7"
        obj.str_Image = "21"
        obj.str_Date = "15-5-2017"
        obj.str_Remainig = "2 days"
        arr_Main.add(obj)
        
        obj = EBooksViewControllerObject ()
        obj.str_Name = "EBook 8"
        obj.str_Image = "21"
        obj.str_Date = "15-5-2017"
        obj.str_Remainig = "2 days"
        arr_Main.add(obj)
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


//MARK: - Friends Object -
class EBooksViewControllerObject: NSObject {
    
    var str_Name : String = ""
    var str_Image : String = ""
    var str_Date : String = ""
    var str_Remainig : String = ""
}




class EBooksViewControllerCell : UICollectionViewCell {
    
    @IBOutlet var img_Preview: UIImageView!
    
    @IBOutlet var lbl_Tital: UILabel!
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var lbl_Remaining: UILabel!
    
}

//MARK: - Collection View -
extension EBooksViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if arr_Main.count == 0{
            return 1
        }
        return arr_Main.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if arr_Main.count == 0{
            cv_Main.isUserInteractionEnabled = false
            return CGSize(width: cv_Main.frame.size.width, height: cv_Main.frame.size.height)
        }
        
        cv_Main.isUserInteractionEnabled = true
        return CGSize(width: CGFloat((GlobalConstants.windowWidth-20)/3), height: CGFloat((GlobalConstants.windowWidth-20)/3) * 1.35)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var str_Identifier : String = "cell"
        
        if arr_Main.count == 0{
            str_Identifier = "nodata"
        }
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: str_Identifier, for: indexPath) as! EBooksViewControllerCell
      
        if arr_Main.count != 0{
            let obj : EBooksViewControllerObject = arr_Main[indexPath.row] as! EBooksViewControllerObject
            
            cell.lbl_Tital.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
            cell.lbl_Date.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 10))
            cell.lbl_Remaining.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 10))

            cell.lbl_Tital.text = obj.str_Name
            cell.lbl_Date.text = obj.str_Date
            cell.lbl_Remaining.text = obj.str_Remainig
        }
//        cell.img_Preview.image = UIImage(named:"box2")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if arr_Main.count != 0{
        }
    }
}
