//
//  StatisticsUserViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 16/11/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import Charts

class StatisticsUserViewController: UIViewController,ChartViewDelegate {

    
    //Other Declaration
    @IBOutlet weak var tbl_Main: UITableView!
    
	@IBOutlet var btn_Word: UIButton!
    @IBOutlet var btn_Minute: UIButton!
  
    @IBOutlet var viewLastWeek: UIView!
    @IBOutlet var viewLastMonth: UIView!
    
    var CategoryName = [] as NSArray
    var CategoryPer = [] as NSArray
    
    var tbl_reload_Number : NSIndexPath!
    var isHighLighted:Bool = false

    var months = ["Mon", "Tue", "Wed",
                  "Thu", "Fri", "Sat",
                  "Sun"]
    
    var itemData = [5, 15, 20, 30, 15, 25, 5]
  
    var isSubCategory : Bool = false
    
    var arr_Category : NSMutableArray = []
  
    //CombineChart
    @IBOutlet var CombinChart: CombinedChartView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()

        self.title = "Minnaz"

        CategoryName = ["Category A", "Category B", "Category C"]
        CategoryPer  = [30, 50, 20]



        //CombineChart

        self.CreateCombineChart()
        viewLastWeek.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     // MARK: - Combine chart -
    func CreateCombineChart()
    {
        //        CombinChart.delegate = self
        CombinChart.chartDescription?.enabled = false
        CombinChart.drawBarShadowEnabled = false
        CombinChart.highlightFullBarEnabled = false
        
        CombinChart.backgroundColor = UIColor.black
        
        CombinChart.drawOrder = [DrawOrder.bar.rawValue,
                                 DrawOrder.line.rawValue]
        
        let l = CombinChart.legend
        l.form = .none
        l.textColor = .clear
        
        let rightAxis = CombinChart.rightAxis
        rightAxis.axisMinimum = 0
        
        rightAxis.labelTextColor = UIColor.black
        
        let leftAxis = CombinChart.leftAxis
        leftAxis.axisMinimum = 0
        
        leftAxis.labelTextColor = UIColor.white
        
        let xAxis = CombinChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        
        xAxis.labelTextColor = UIColor.white
        
        self.setChartData()
    }
    
    func setChartData() {
        let data = CombinedChartData()
        data.lineData = generateLineData()
        data.barData = generateBarData()

        CombinChart.xAxis.axisMaximum = data.xMax + 0.25


        CombinChart.data = data
    }
  
  func generateLineData() -> LineChartData {
    
    let entries = (0..<itemData.count).map {
      (i) -> ChartDataEntry in
      return ChartDataEntry(x: Double(i) + 0.3, y: Double( itemData[i]))
    }
    
    let set = LineChartDataSet(values: entries, label: "Line DataSet")
    set.setColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1))
    set.lineWidth = 2.0
    set.setCircleColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1))
    set.circleRadius = 5
    set.circleHoleRadius = 2.5
    set.fillColor = UIColor(red: 255/255, green: 255/255, blue: 31/255, alpha: 1)
    set.mode = .linear
    set.drawValuesEnabled = true
    set.valueFont = .systemFont(ofSize: 10)
    set.valueTextColor = UIColor.clear
    set.axisDependency = .left
    
    return LineChartData(dataSet: set)
  }
  
  func generateBarData() -> BarChartData
  {
    
    let entries1 = (0..<itemData.count).map { (i) -> BarChartDataEntry in
      return BarChartDataEntry(x: 0, y: Double(itemData[i]))
    }
    let entries2 = (0..<itemData.count).map { _ -> BarChartDataEntry in
      return BarChartDataEntry(x: 0, y: Double( 0))
    }
    
    let set1 = BarChartDataSet(values: entries1, label: "Bar 1")
    set1.setColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 0.3))
    set1.valueTextColor = .clear
    set1.valueFont = .systemFont(ofSize: 10)
    set1.axisDependency = .left
    
    let set2 = BarChartDataSet(values: entries2, label: "")
    set2.stackLabels = ["Stack 1", "Stack 2"]
    set2.colors = [UIColor(red: 61/255, green: 165/255, blue: 255/255, alpha: 0)]
    set2.valueTextColor = UIColor(red: 61/255, green: 165/255, blue: 255/255, alpha: 0)
    set2.valueFont = .systemFont(ofSize: 10)
    set2.axisDependency = .left
    
    let groupSpace = 0.06
    let barSpace = 0.02 // x2 dataset
    let barWidth = 0.45 // x2 dataset
    // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
    
    let data = BarChartData(dataSets: [set1, set2])
    data.barWidth = barWidth
    
    // make this BarData object grouped
    data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
    
    return data
  }
  
  
  
 
    // MARK: - Other Event -
    func commanMethod(){
        
        var obj = StatiticsUserObject()
        obj.str_Cat_Title = "Student XYZ "
        obj.str_Cat_Image = ""
        obj.str_Word_Count = "100"
        obj.str_Minute_Count = "200"
        obj.arr_SubCategory = ["123"]
        arr_Category.add(obj)
        
        obj = StatiticsUserObject()
        obj.str_Cat_Title = "Student XYZ "
        obj.str_Cat_Image = ""
        obj.str_Word_Count = "100"
        obj.str_Minute_Count = "200"
        obj.arr_SubCategory = ["123"]
        arr_Category.add(obj)
        
        obj = StatiticsUserObject()
        obj.str_Cat_Title = "Student XYZ "
        obj.str_Cat_Image = ""
        obj.str_Word_Count = "100"
        obj.str_Minute_Count = "200"
        obj.arr_SubCategory = ["123"]
        arr_Category.add(obj)
        
        obj = StatiticsUserObject()
        obj.str_Cat_Title = "Student XYZ "
        obj.str_Cat_Image = ""
        obj.str_Word_Count = "100"
        obj.str_Minute_Count = "200"
        obj.arr_SubCategory = ["123"]
        arr_Category.add(obj)
        
        obj = StatiticsUserObject()
        obj.str_Cat_Title = "Student XYZ "
        obj.str_Cat_Image = ""
        obj.str_Word_Count = "100"
        obj.str_Minute_Count = "200"
        obj.arr_SubCategory = ["123"]
        arr_Category.add(obj)
        
        
        //Last Cell
        obj = StatiticsUserObject()
        obj.str_Cat_Title = "Top Problematic Words"
        obj.str_Cat_Image = ""
        obj.str_Word_Count = "100"
        obj.str_Minute_Count = "200"
        
        obj.arr_SubCategory = []
        let obj2 = StatiticsUserObject()
        obj2.str_SubCategory_Title = "Problematic Words"
        obj2.str_SubCategory_Count = "20"
        obj.arr_SubCategory.add(obj2)
        obj.arr_SubCategory.add(obj2)
        arr_Category.add(obj)
        
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
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func wordClick(_ sender: UIButton) {
        btn_Word.isSelected = true
        btn_Minute.isSelected = false

        btn_Word.backgroundColor = UIColor.black
        btn_Minute.backgroundColor = UIColor(red: 19/256.0, green: 18/256.0, blue: 40/256.0, alpha: 1.0)

    }
    @IBAction func minutesClick(_ sender: UIButton) {
        btn_Minute.isSelected = true
        btn_Word.isSelected = false

        btn_Minute.backgroundColor = UIColor.black
        btn_Word.backgroundColor = UIColor(red: 19/256.0, green: 18/256.0, blue: 40/256.0, alpha: 1.0)
    }
    
    @IBAction func btnLastWeekPress(_ sender: Any) {
        months = ["Mon", "Tue", "Wed",
                      "Thu", "Fri", "Sat",
                      "Sun"]
        
        itemData = [5, 15, 20, 30, 15, 25, 5]
        
        self.CreateCombineChart()
        viewLastWeek.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1)
        viewLastMonth.backgroundColor = UIColor.white

    }
    
    @IBAction func btnLastMonthPress(_ sender: Any) {
        months = ["Jan", "Feb", "Mar",
                      "Apr", "May", "Jun",
                      "Jul", "Aug", "Sep",
                      "Oct", "Nov", "Dec"]
        
        itemData = [5, 10, 15, 20, 30, 35, 25, 20, 10, 5, 15, 5]
        
        self.CreateCombineChart()
        viewLastMonth.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1)
        viewLastWeek.backgroundColor = UIColor.white

    }
    
    @IBAction func btn_Section(_ sender: Any) {
        
        var bool_Animation : Bool = false
        //Get animation with table view reload data
        tbl_Main.beginUpdates()
        if ((tbl_reload_Number) != nil) {
            if (tbl_reload_Number.section == (sender as AnyObject).tag) {
                
                //Delete Cell
                let obj : StatiticsUserObject = arr_Category[((sender as AnyObject).tag)] as! StatiticsUserObject
                
                let arr_DeleteIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows: obj.arr_SubCategory.count)
                tbl_Main.deleteRows(at: arr_DeleteIndex as! [IndexPath], with: .automatic)
                
                tbl_reload_Number = nil;
            }else{
                //Delete Cell
                let obj : StatiticsUserObject = arr_Category[tbl_reload_Number.section] as! StatiticsUserObject
                
                let arr_DeleteIndex = self.indexPaths(forSection: tbl_reload_Number.section, withNumberOfRows:obj.arr_SubCategory.count)
                tbl_Main.deleteRows(at: arr_DeleteIndex as! [IndexPath], with: .automatic)
                
                tbl_reload_Number = IndexPath(row: 0, section: (sender as AnyObject).tag) as NSIndexPath!
                let obj2 : StatiticsUserObject = arr_Category[((sender as AnyObject).tag)] as! StatiticsUserObject
                
                let arr_AddIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows:obj2.arr_SubCategory.count)
                tbl_Main.insertRows(at: arr_AddIndex as! [IndexPath], with: .automatic)
                
                bool_Animation = true
            }
        }else{
            let obj : StatiticsUserObject = arr_Category[((sender as AnyObject).tag)] as! StatiticsUserObject

            tbl_reload_Number = IndexPath(row: 0, section: (sender as AnyObject).tag) as NSIndexPath!
            let arr_AddIndex = self.indexPaths(forSection: ((sender as AnyObject).tag), withNumberOfRows:obj.arr_SubCategory.count)
            tbl_Main.insertRows(at: arr_AddIndex as! [IndexPath], with: .automatic)
            
            bool_Animation = true
        }
        
        tbl_Main.endUpdates()
        
        if ((sender as AnyObject).tag) == self.arr_Category.count - 1 && bool_Animation == true
        {
                self.tbl_Main.scrollToRow(at: IndexPath(item:0, section: ((sender as AnyObject).tag)), at: .bottom, animated: true)
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            
            self.tbl_Main.reloadData()
        })
    }
    
}

extension StatisticsUserViewController: IAxisValueFormatter {
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return months[Int(value) % months.count]
  }
}


class StatiticsUserObject {
    var str_Cat_Title: String = ""
    var str_Cat_Image: String = ""
    
    var str_Word_Count: String = ""
    var str_Minute_Count: String = ""
    
    var arr_SubCategory : NSMutableArray = []
    var str_SubCategory_Title: String = ""
    var str_SubCategory_Count: String = ""
}


extension StatisticsUserViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return arr_Category.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if arr_Category.count == indexPath.section + 1{
            return 50
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var str_Identifier  = "section"
        if arr_Category.count == section + 1{
            str_Identifier  = "section2"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: str_Identifier) as! HeaderCell
        
        let obj : StatiticsUserObject = arr_Category[section] as! StatiticsUserObject
        cell.lbl_Title.text = obj.str_Cat_Title
        
        cell.btnUpDown.isSelected = false
        if ((tbl_reload_Number) != nil) {
            if (tbl_reload_Number.section == section) {
                cell.btnUpDown.isSelected = true
            }
        }
        
        cell.btn_Click.tag = section;
        cell.btn_Click.addTarget(self, action:#selector(btn_Section(_:)), for: .touchUpInside)

        return cell
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //If search and result 0 than show no data cell
        if ((tbl_reload_Number) != nil) {
            if (tbl_reload_Number.section == section) {
                
                let obj : StatiticsUserObject = arr_Category[section] as! StatiticsUserObject
                return obj.arr_SubCategory.count
//                if arr_Category.count == section + 1{
//
//                }else{
//                    return 1
//                }
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var str_Identifier  = "cell"
        if arr_Category.count - 1 == tbl_reload_Number.section{
            str_Identifier  = "cell2"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: str_Identifier, for:indexPath as IndexPath) as! StatisticeCell

        let obj : StatiticsUserObject = arr_Category[indexPath.section] as! StatiticsUserObject
        
        if arr_Category.count - 1 == tbl_reload_Number.section{
            let obj2 : StatiticsUserObject = obj.arr_SubCategory[indexPath.row] as! StatiticsUserObject
            
            cell.lblTitle.text = obj2.str_SubCategory_Title
            cell.lblCount.text = obj2.str_SubCategory_Count
            
        }else{
            
            cell.lbl_WordCount.text = obj.str_Word_Count
            cell.lbl_MinuteCount.text = obj.str_Minute_Count
        }
        
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
