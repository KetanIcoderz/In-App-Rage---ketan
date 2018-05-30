//
//  AllFilesStudentViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 13/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class AllFilesStudentViewController: UIViewController {

    var arr_Main : NSMutableArray = []
    
    var tbl_reload_Number : NSIndexPath!
    
    //Other Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Other Files -
    func commanMethod(){
        arr_Main = []
        for i in (0..<10) {
            
            let obj = AllFilesObject()
            
            obj.str_Title = "Lesson \(i + 1)"
           
            obj.arr_Detail = []
            //Product Image
            for i in (0..<6) {
                 let obj2 = AllFilesObject()
                
                obj2.str_FileName = "File Name"
                obj2.str_Image = "File Name"
                obj2.str_Date = "12/1/2018"
                obj2.str_Selected = "0"
                
                obj.arr_Detail.add(obj2)
            }
            
            arr_Main.add(obj)
        }
    }
        
        
    func indexPaths(forSection section: Int, withNumberOfRows numberOfRows: Int) -> [Any] {
        var indexPaths = [Any]()
        for i in 0..<numberOfRows {
            let indexPath = IndexPath(row: i, section: section)
            indexPaths.append(indexPath)
        }
        return indexPaths
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_Section(_ sender: Any) {
        //Get animation with table view reload data
        tbl_Main.beginUpdates()
        if ((tbl_reload_Number) != nil) {
            if (tbl_reload_Number.section == (sender as AnyObject).tag) {
                
                //Delete Cell
                let arr_DeleteIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows: 1)
                tbl_Main.deleteRows(at: arr_DeleteIndex as! [IndexPath], with: .automatic)
                
                tbl_reload_Number = nil;
            }else{
                //Delete Cell
                let arr_DeleteIndex = self.indexPaths(forSection: tbl_reload_Number.section, withNumberOfRows:1)
                tbl_Main.deleteRows(at: arr_DeleteIndex as! [IndexPath], with: .automatic)

                tbl_reload_Number = IndexPath(row: 0, section: (sender as AnyObject).tag) as NSIndexPath!

                let arr_AddIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows:1)
                tbl_Main.insertRows(at: arr_AddIndex as! [IndexPath], with: .automatic)
            }
        }else{
                tbl_reload_Number = IndexPath(row: 0, section: (sender as AnyObject).tag) as NSIndexPath!
                let arr_AddIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows: 1)
                tbl_Main.insertRows(at: arr_AddIndex as! [IndexPath], with: .automatic)
        }
        
        tbl_Main.endUpdates()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.tbl_Main.reloadData()
        })
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


//MARK: - Object Decalration -
class AllFilesObject: NSObject {
    
    var str_Title : String = ""
    
    var str_FileName : String = ""
    var str_Image : String = ""
    var str_Selected : String = ""
    var str_Date : String = ""
    
    var arr_Detail : NSMutableArray = []
    
}
class AllFilesCell: UITableViewCell {
    
    @IBOutlet var lbl_Title: UILabel!
    
    @IBOutlet var btn_Click: UIButton!
    
    @IBOutlet var cv_Sub : UICollectionView!
    
}

extension AllFilesStudentViewController : UITableViewDelegate,UITableViewDataSource{
    // MARK: - Table View -
    func numberOfSections(in tableView: UITableView) -> Int{
        
        if arr_Main.count == 0{
            return 1
        }
        
        return arr_Main.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arr_Main.count == 0{
            return 1
        }
        
        //If search and result 0 than show no data cell
        if ((tbl_reload_Number) != nil) {
            if (tbl_reload_Number.section == section) {
                return 1;
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(((GlobalConstants.windowWidth - 20)/3))
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var cellIdentifier : String = "section"
         if arr_Main.count == 0 {
            cellIdentifier = "nodata"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)as! AllFilesCell
        
        if arr_Main.count != 0 {
            let obj : AllFilesObject = arr_Main[section] as! AllFilesObject
            
            cell.lbl_Title.text = obj.str_Title
            
            //Button Event
            cell.btn_Click.tag = section;
            cell.btn_Click.addTarget(self, action:#selector(btn_Section(_:)), for: .touchUpInside)
            
        }else{
             cell.lbl_Title.text = "No files available"
        }
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier : String = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! AllFilesCell
//
        cell.cv_Sub.tag = indexPath.section
        cell.cv_Sub.delegate = self
        cell.cv_Sub.dataSource = self
        cell.cv_Sub.reloadData()
        
        return cell;
    }



}


class AllFilesCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet var lbl_FileName: UILabel!
    @IBOutlet var lbl_Date: UILabel!
    
    @IBOutlet var img_File: UIImageView!
    @IBOutlet var img_RejectOrAccept: UIImageView!
    
}



//MARK: - Collection View -
extension AllFilesStudentViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let obj : AllFilesObject = arr_Main[collectionView.tag] as! AllFilesObject
       
        if obj.arr_Detail.count != 0{
            return obj.arr_Detail.count
        }
       
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let obj : AllFilesObject = arr_Main[collectionView.tag] as! AllFilesObject

        if obj.arr_Detail.count != 0{
             return CGSize(width: CGFloat((GlobalConstants.windowWidth - 40)/3), height: CGFloat((GlobalConstants.windowWidth - 40)/3))
        }
        
        return CGSize(width: CGFloat(GlobalConstants.windowWidth - 40), height: CGFloat(GlobalConstants.windowWidth/3))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var str_Identifier : String = "cell"
        
        let obj : AllFilesObject = arr_Main[collectionView.tag] as! AllFilesObject
        
        if obj.arr_Detail.count == 0{
            str_Identifier = "nodata"
        }
       
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: str_Identifier, for: indexPath) as! AllFilesCollectionViewCell
        
        if obj.arr_Detail.count != 0{
            let obj2 : AllFilesObject = obj.arr_Detail[indexPath.row] as! AllFilesObject
            
            cell.lbl_FileName.text = obj2.str_FileName
            cell.lbl_Date.text = obj2.str_Date
            
        }else{
            cell.lbl_FileName.text = "No File Available"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}

