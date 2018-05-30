//
//  HistorySettingViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 16/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class HistorySettingViewController: UIViewController {

    //Collectionview declaration
    @IBOutlet weak var cv_Main : UICollectionView!
    
    //Other
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
        
        var obj = HistoryViewControllerObject ()
        obj.str_Date = "13/1/2018"
        obj.str_WinType = "1"
        obj.str_Percentage = "75%"
        obj.str_TotalWord = "200 words/week"
        arr_Main.add(obj)
        
        obj = HistoryViewControllerObject ()
        obj.str_Date = "06/1/2018"
        obj.str_WinType = "2"
        obj.str_Percentage = "75%"
        obj.str_TotalWord = "234 words/week"
        arr_Main.add(obj)
        
        obj = HistoryViewControllerObject ()
        obj.str_Date = "30/12/2017"
        obj.str_WinType = "2"
        obj.str_Percentage = "75%"
        obj.str_TotalWord = "234 words/week"
        arr_Main.add(obj)
        
    }
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
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


//MARK: - Friends Object -
class HistoryViewControllerObject: NSObject {
    
    var str_Date : String = ""
    var str_WinType : String = ""
    var str_Percentage : String = ""
    var str_TotalWord : String = ""
}

class HistorySettingCellViewController : UICollectionViewCell {
    
    @IBOutlet var lbl_NoData: UILabel!
    
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var lbl_Percentage: UILabel!
    @IBOutlet var lbl_NumberOfWord: UILabel!
    
    @IBOutlet var img_HistoryTab: UIImageView!
    
}


//MARK: - Collection View -
extension HistorySettingViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr_Main.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(GlobalConstants.windowWidth/3), height: CGFloat((GlobalConstants.windowWidth/3) * 1.3))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var str_Identifier : String = "cell"
        
        if arr_Main.count == 0{
            str_Identifier = "nodata"
        }
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: str_Identifier, for: indexPath) as! HistorySettingCellViewController
        
        if arr_Main.count != 0{
            let obj : HistoryViewControllerObject = arr_Main[indexPath.row] as! HistoryViewControllerObject
            
            cell.lbl_Date.text = obj.str_Date
            cell.lbl_Percentage.text = obj.str_Percentage
            cell.lbl_NumberOfWord.text = obj.str_TotalWord
            
            if obj.str_WinType == "1"{
                cell.img_HistoryTab.image = UIImage(named:"img_Bronze_HistoryTab")
            }else if obj.str_WinType == "2"{
                cell.img_HistoryTab.image = UIImage(named:"img_Gold_HistoryTab")
            }
        }else{
            cell.lbl_NoData.text = "No history found"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

