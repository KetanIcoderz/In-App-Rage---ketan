//
//  SearchQuizletViewController.swift
//  Minnaz
//
//  Created by iCoderz_02 on 01/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit
import Quizlet_iOS

class SearchQuizletViewController: UIViewController {

    @IBOutlet var txtSearchbar: UITextField!
    @IBOutlet var tblViewSetList: UITableView!
    @IBOutlet var btnSavedRecord: UIBarButtonItem!
    
    var arySetData:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewSetList.tableFooterView = UIView()
        
        //Quizlet
        Quizlet.shared().start(withClientID: CLIENT_ID, withSecretKey: SECRET_KEY, withRedirectURI: "quizletdemo://after_oauth")
        
        Quizlet.shared().authorize({(_: Void) -> Void in
            print("User was authorized")
            
        }, failure: {(_ error: Error?) -> Void in
            print("User wasn't authorized")
        })
        //
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        //        toggleLeft()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSavedData(_ sender: Any) {

        self.performSegue(withIdentifier: "segueSavedRecord", sender: nil)
    }
    
    @IBAction func btnSearchOnQuizlet(_ sender: Any) {
        
        let strSearch : String = txtSearchbar.text!
        
        self.view.endEditing(true);
        
        if strSearch.characters.count > 0
        {
            indicatorShow()

            Quizlet.shared().searchSets(withParameters: ["q": txtSearchbar.text ?? ""], success: {(_ responseObject: Any) -> Void in
                
                let response = responseObject as! NSDictionary
                if response.count > 0
                {
                    self.arySetData = []
                    
                    let aryData = response["sets"] as! NSArray
                    for i in (0..<aryData.count)
                    {
                        let response = aryData[i] as! NSDictionary
                        
                        let objSetList = setsListObject()
                        objSetList.strid = response["id"] as! Int
                        objSetList.strtitle = response["title"] as! String
                        objSetList.strCreateBy = response["created_by"] as! String
                        objSetList.strTotalCard = response["term_count"] as! Int
                        
                        objSetList.strSearch = strSearch
                        
                        self.arySetData.add(objSetList)
                    }
                    
                    indicatorHide()

                    self.tblViewSetList.reloadData()
//                    self.performSegue(withIdentifier: "segueSetList", sender: self.arySetData)
                }
            }, failure: {(_ error: Error?) -> Void in
                indicatorHide()
            })
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class cellSetsList: UITableViewCell{
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblCellDetails: UILabel!
    @IBOutlet var lblFlashcard: UILabel!
}

extension SearchQuizletViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        cell.lblTitle.text = txtSearchbar.text
        
        cell.lblCellDetails.text = "\(obj.strtitle)"
        
        cell.lblFlashcard.text = "\(obj.strTotalCard) flashcards"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj : setsListObject = arySetData[indexPath.row] as! setsListObject
        self.performSegue(withIdentifier: "segueDetailsScreen", sender: obj)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDetailsScreen"{
            
            let viewSub = segue.destination as? QuizletCardViewController
            viewSub?.objListSelected = sender as! setsListObject
        }
    }
    
}

