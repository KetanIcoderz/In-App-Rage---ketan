//
//  TodayLessonViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 22/02/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class TodayLessonViewController: UIViewController {

    //Declaration Button
    @IBOutlet weak var tbl_Main: UITableView!
    
    @IBOutlet weak var con_PopUpHeight: NSLayoutConstraint!
    
    var arr_Data: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
        con_PopUpHeight.constant = CGFloat(arr_Data.count * 50) + 72 > CGFloat(GlobalConstants.windowHeight) ?  CGFloat(GlobalConstants.windowHeight) :  CGFloat(arr_Data.count * 50) + 72
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func commanMethod() {
        
        arr_Data = []
        
        var obj = TodayLessonObject()
        obj.str_Lesson_Name = "Lesson 1"
        obj.str_Lesson_Time = "2:00 PM"
        arr_Data.add(obj)
        
        obj = TodayLessonObject()
        obj.str_Lesson_Name = "Lesson 2"
        obj.str_Lesson_Time = "2:00 PM"
        arr_Data.add(obj)
        
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        dismiss(animated:true, completion: nil)
    }
    @IBAction func btn_Info(_ sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MyFilesPopUpViewController") as! MyFilesPopUpViewController
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
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

class TodayLessonObject {
    var str_Lesson_Name: String = ""
    var str_Lesson_Time: String = ""
    var str_Lesson_Image: String = ""
}


class TodayLessonTableViewCell: UITableViewCell {
    
    // MARK: - Table Cell -
    @IBOutlet var lbl_LessonName: UILabel!
    @IBOutlet var lbl_LessonTime: UILabel!
    
    @IBOutlet var img_LessonImage: UIImageView!
    
    @IBOutlet var btn_Info: UIButton!
    
}

// MARK: - Table Delegate -
extension TodayLessonViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr_Data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier : String = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath as IndexPath) as! TodayLessonTableViewCell
        
        let obj = arr_Data[indexPath.row] as! TodayLessonObject
        cell.lbl_LessonName.text = obj.str_Lesson_Name
        cell.lbl_LessonTime.text = obj.str_Lesson_Time
        
        cell.btn_Info.addTarget(self, action:#selector(btn_Info(_:)), for: .touchUpInside)
     
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

