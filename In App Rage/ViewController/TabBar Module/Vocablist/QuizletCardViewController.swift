//
//  QuizletCardViewController.swift
//  Minnaz
//
//  Created by iCoderz_02 on 01/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import Quizlet_iOS
import FMDB

class QuizletCardViewController: UIViewController {
    
    var aryCardData : NSMutableArray = []
    var arySetData : NSMutableArray = []
    
    var objListSelected : setsListObject = setsListObject()
    
    @IBOutlet var lblTotalFlashCard: UILabel!
    @IBOutlet var lbltopicTitle: UILabel!
    @IBOutlet var lblTopicOwner: UILabel!
    @IBOutlet var btnDownload: UIBarButtonItem!
    
    @IBOutlet var tblViewCard: UITableView!
    
    @IBOutlet var viewDocumentDirectory: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arySetData = []
        
        tblViewCard.tableFooterView = UIView()
        viewDocumentDirectory.isHidden = true;
        
        //        let objstrID = objListSelected.strid
        
        lblTotalFlashCard.text = "00 / \(objListSelected.strTotalCard) Flashcards used"
        
        lbltopicTitle.text = "Search Result for: \(objListSelected.strSearch)"
        
        lblTopicOwner.text = "Created By: \(objListSelected.strCreateBy)"
        
        //Checkif Exist
        arySetData = getSelectedValues(setID: objListSelected.strid as! Int)
        
        if arySetData.count > 0
        {
            navigationItem.rightBarButtonItem = nil
            self.aryCardData = []
            aryCardData = getSavedCardData(setID: objListSelected.strid as! Int)

        }
        else{
        
        indicatorShow()
        Quizlet.shared().viewSet(bySetId: String(describing: objListSelected.strid), success: { (_ responseObject: Any) in
            
            let response = responseObject as! NSDictionary
            if response.count > 0
            {
                self.aryCardData = []
                let aryData = response["terms"] as! NSArray
                for i in (0..<aryData.count)
                {
                    let response = aryData[i] as! NSDictionary
                    
                    let objTerms = cardTermsObject()
                    objTerms.strid = response["id"] ?? 0
                    objTerms.strterm = response["term"] as! String
                    objTerms.strdefinition = response["definition"] as! String
                    
                    let keyExists = response["image"] != nil
                    if keyExists
                    {
                        let aryDataimg = response["image"] as? NSDictionary ?? NSDictionary()
                        
                        if aryDataimg.count > 0
                        {
                            objTerms.strimage = aryDataimg["url"] as! String
                        }
                    }
                    
                    self.aryCardData.add(objTerms)
                }
                self.tblViewCard.reloadData()
                indicatorHide()
            }
            
        }, failure: { (_ error: Error?) in
            indicatorHide()
        })
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        //        toggleLeft()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDownloadPress(_ sender: Any) {
        
        viewDocumentDirectory.isHidden = false;
    }
    
    @IBAction func btnClosePopup(_ sender: Any) {
        
        viewDocumentDirectory.isHidden = true;
    }
    
    @IBAction func CreateCategoryDone(_ sender: Any) {
        indicatorShow()
        perform(#selector(self.StartDownload), with: self, afterDelay: 1.0)
    }
    
    @objc func StartDownload()
    {
        insertQuizletSearchSet()
        if aryCardData.count > 0 {
            insertInTableCard()
        }
        navigationItem.rightBarButtonItem = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //SQLite DB
    
    func insertQuizletSearchSet() {
        
        let setID = objListSelected.strid as! Int
        let setSearch = objListSelected.strSearch
        let setTitle = objListSelected.strtitle
        let setCreateBy = objListSelected.strCreateBy
        let setTermCount = objListSelected.strTotalCard as! Int

        
        database = FMDatabase(path: pathToDatabase!)
        
        if database != nil {
            // Open the database.
            if database.open() {

                let query = "insert into QuizletSearchSet (setID, setSearch, setTitle, setCreateBy, setTermCount) values (\(setID), '\(setSearch)', '\(setTitle)', '\(setCreateBy)', \(setTermCount));"
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                }
                database.close()
            }
            else {
                print("Could not open the database.")
            }
        }
            
        return
        
    }
    
    func insertInTableCard()
    {
        database = FMDatabase(path: pathToDatabase!)
        
        if database != nil {
            // Open the database.
            if database.open() {
                
                
                for i in (0..<aryCardData.count)
                {
                    var query = ""

                    let objSaveCard : cardTermsObject = aryCardData[i] as! cardTermsObject
                    
                    let setID = objListSelected.strid as! Int
                    let cardID = objSaveCard.strid
                    let cardTerm = objSaveCard.strterm
                    let cardDefi = objSaveCard.strdefinition
                    let cardimgURL = objSaveCard.strimage
                    
                    
                    query = "INSERT INTO QuizletCardSet (setID, cardID, cardTerm, cardDefi, cardimgURL) VALUES (\(setID), \(cardID), '\(cardTerm)', '\(cardDefi)', '\(cardimgURL)');"
                    
                    if !database.executeStatements(query) {
                        print("Failed to insert initial data into the database.")
                        print(database.lastError(), database.lastErrorMessage())
                    }

                }
            self.navigationController?.popViewController(animated: true)

                database.close()
            }
            else {
                print("Could not open the database.")
            }
        }
        indicatorHide()
        
        
    }
    
    func getSelectedValues(setID : Int) -> NSMutableArray {

        database = FMDatabase(path: pathToDatabase!)
        
        // Open the database.
        if database.open() {
            let queryString = "select * from QuizletSearchSet where setID = \(setID)"

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

    func getSavedCardData(setID : Int) -> NSMutableArray{
        
        database = FMDatabase(path: pathToDatabase!)
        
        // Open the database.
        if database.open() {
            let queryString = "select * from QuizletCardSet where setID = \(setID)"

            do {
                print(database)
                let results = try database.executeQuery(queryString, values: nil)
                
                while results.next() {
                    let objTerms = cardTermsObject()
                    
                    objTerms.strid = Int(results.int(forColumn: "setID"))
                    objTerms.strterm = results.string(forColumn: "cardTerm")!
                    objTerms.strdefinition = results.string(forColumn: "cardDefi")!
                    objTerms.strimage = results.string(forColumn: "cardimgURL")!
                    
                    self.aryCardData.add(objTerms)

                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        return self.aryCardData
    }
}

class cellCardList: UITableViewCell{
    
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var lblAnsware: UILabel!
}

extension QuizletCardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryCardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "CellReuse", for: indexPath) as! cellCardList
        
        let obj : cardTermsObject = aryCardData[indexPath.row] as! cardTermsObject
        
        cell.lblCount.text = "\(indexPath.row+1)"
        
        cell.lblQuestion.text = "\(obj.strterm)"
        
        cell.lblAnsware.text = "\(obj.strdefinition)"
        
        cell.selectionStyle = .none
        
        return cell
    }
}






