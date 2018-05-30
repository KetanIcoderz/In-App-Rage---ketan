//
//  SaveQuizletViewController.swift
//  Minnaz
//
//  Created by iCoderz_02 on 02/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import FMDB

class SaveQuizletViewController: UIViewController {
    
    var arySetData:NSMutableArray = []
    @IBOutlet var tblViewSetList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arySetData = getSavedSet()
        
        tblViewSetList.tableFooterView = UIView()
        
        tblViewSetList.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSavedSet() -> NSMutableArray{
        
        database = FMDatabase(path: pathToDatabase!)
        
        // Open the database.
        if database.open() {
            let queryString = "select * from QuizletSearchSet order by id desc"
            
            do {
                print(database)
                let results = try database.executeQuery(queryString, values: nil)
                
                while results.next() {
                    let objSetList = setsListObject()
                    
                    objSetList.strid        = Int(results.int(forColumn: "setID"))
                    objSetList.strSearch    = results.string(forColumn: "setSearch")!
                    objSetList.strtitle     = results.string(forColumn: "setTitle")!
                    objSetList.strCreateBy  = results.string(forColumn: "setCreateBy")!
                    objSetList.strTotalCard = Int(results.int(forColumn: "setTermCount"))

                    self.arySetData.add(objSetList)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        return self.arySetData
    }
    
}


extension SaveQuizletViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arySetData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseable", for: indexPath) as! cellSetsList
        
        let obj : setsListObject = arySetData[indexPath.row] as! setsListObject
        
        cell.lblTitle.text = "\(obj.strSearch)"
        
        cell.lblCellDetails.text = "\(obj.strtitle)"
        
        cell.lblFlashcard.text = "\(obj.strTotalCard) flashcards"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj : setsListObject = arySetData[indexPath.row] as! setsListObject
        self.performSegue(withIdentifier: "segueShowCards", sender: obj)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueShowCards"{
            
            let viewSub = segue.destination as? QuizletCardViewController
            viewSub?.objListSelected = sender as! setsListObject
        }
    }
    
}


