//
//  StatisticsViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 16/11/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController,ChartViewDelegate {
  
  //mark - PieChart
  @IBOutlet var PieChatView: PieChartView!
  @IBOutlet var sliderX: UISlider!
  @IBOutlet var sliderY: UISlider!
  @IBOutlet var sliderTextX: UITextField!
  @IBOutlet var sliderTextY: UITextField!
    
	@IBOutlet var btn_Word: UIButton!
    @IBOutlet var btn_Minute: UIButton!
  
    @IBOutlet var viewLastWeek: UIView!
    @IBOutlet var viewLastMonth: UIView!
    
    @IBOutlet var btn_Class : UIButton!
    
    var CategoryName = [] as NSArray
    var CategoryPer = [] as NSArray
  
    @IBOutlet var tblViewProblematic: UITableView!
    var tbl_reload_Number : Int = 0
    var isHighLighted:Bool = false

    var months = ["Mon", "Tue", "Wed",
                  "Thu", "Fri", "Sat",
                  "Sun"]
    
    var itemData = [5, 15, 20, 30, 15, 25, 5]
  
  var isSubCategory : Bool = false
  
  //CombineChart
  @IBOutlet var CombinChart: CombinedChartView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Minnaz"
    
    let l1 = PieChatView.legend
    l1.form = .none
    l1.textColor = .clear
    //        l1.horizontalAlignment = .right
    //        l1.verticalAlignment = .top
    //        l1.orientation = .horizontal
    //        l1.xEntrySpace = 7
    //        l1.yEntrySpace = 0
    //        l1.yOffset = 0
    
    CategoryName = ["Category A", "Category B", "Category C"]
    CategoryPer  = [30, 50, 20]
    
    self.updateChartData()
    PieChatView.delegate = self
    PieChatView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    
    //CombineChart

    self.CreateCombineChart()
    viewLastWeek.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1)

  }
    override func viewWillAppear(_ animated: Bool) {
        if objUser?.user_Type == "0"{
            btn_Class.isHidden = true
        }else{
            btn_Class.isHidden = false
        }
    }
  
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
        //        l.wordWrapEnabled = true
        //        l.horizontalAlignment = .center
        //        l.verticalAlignment = .bottom
        //        l.orientation = .horizontal
        //        l.drawInside = false
        
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
  //Pie Chart
  func updateChartData() {
    
    PieChatView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    
    self.setDataCount(CategoryName.count, range: 100)
  }
  
  func setDataCount(_ count: Int, range: UInt32)
  {
    let entries = (0..<count).map { (i) -> PieChartDataEntry in
      // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
      
      return PieChartDataEntry(value: Double(CategoryPer[i] as! Int32),
                               label: CategoryName[i % CategoryName.count] as? String)
    }
    
    let set = PieChartDataSet(values: entries, label: "")
    set.drawIconsEnabled = false
    //        set.sliceSpace = 2
    
    //RJ Change
    set.colors =
         [UIColor(red: 239/255, green: 213/255, blue: 88/255, alpha: 1)]
       + [UIColor(red: 245/255, green: 88/255, blue: 67/255, alpha: 1)]
       + [UIColor(red: 21/255, green: 197/255, blue: 236/255, alpha: 1)]
    
    let data = PieChartData(dataSet: set)
    
    let pFormatter = NumberFormatter()
    pFormatter.numberStyle = .percent
    pFormatter.maximumFractionDigits = 1
    pFormatter.multiplier = 1
    pFormatter.percentSymbol = " %"
    
    data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    
    data.setValueFont(.systemFont(ofSize: 11, weight: .bold))
    data.setValueTextColor(.white)
    
    PieChatView.data = data
    PieChatView.highlightValues(nil)
  }
  
  
  // TODO: Cannot override from extensions
  //extension DemoBaseViewController: ChartViewDelegate {
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight){
    
    NSLog("chartValueSelected");
    
    if chartView == PieChatView && isSubCategory == false
    {
      isSubCategory = true;
      if highlight.x == 0
      {
        CategoryName = ["Sub Category A", "Sub Category B", "Sub Category C", "Sub Category D", "Sub Category E"]
        CategoryPer  = [30, 10, 30, 20,10]
        
      }
      else if highlight.x == 1
      {
        CategoryName = ["Sub Category A", "Sub Category B", "Sub Category C", "Sub Category D"]
        CategoryPer  = [30, 40, 20,10]
        
      }
      else if highlight.x == 2
      {
        CategoryName = ["Sub Category A", "Sub Category B", "Sub Category C", "Sub Category D", "Sub Category E", "Sub Category F", "Sub Category G"]
        CategoryPer  = [5, 10, 30, 15, 20, 5, 15]
        
      }
      self.updateChartData()
      
    }
    else{
      isSubCategory = false;
      CategoryName = ["Category A", "Category B", "Category C"]
      CategoryPer  = [30, 50, 20]
      
      self.updateChartData()
    }
  }
  
  func chartValueNothingSelected(_ chartView: ChartViewBase) {
    NSLog("chartValueNothingSelected");
  }
  
  func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
    
  }
  
  func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
    
  }
  
  
  //Combine chart
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
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
 
    // MARK: - Other Event -
    func selectedButton(){
        
    }
    
  // MARK: - Button Event -
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
    

    @IBAction func btn_Share (_ sender : Any){
        shareFunction(textData : "Statistics From Minnaz \n\n|Word|\nLast Week : 320\nLast Month : 680\nTotal : 1000\n\n|Minutes\nLast Week : 20\nLast Month : 80\nTotal : 100",viewPresent: self)
    }
}

extension StatisticsViewController: IAxisValueFormatter {
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return months[Int(value) % months.count]
  }
}

class HeaderCell: UITableViewCell {
    
    @IBOutlet var btn_Click: UIButton!
    @IBOutlet var btnUpDown: UIButton!
    
    
    @IBOutlet var lbl_Title: UILabel!
}

class StatisticeCell: UITableViewCell {
   
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var viewCount: UIView!
    
    @IBOutlet var lbl_WordCount: UILabel!
    @IBOutlet var lbl_MinuteCount: UILabel!
}
extension StatisticsViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader") as! HeaderCell
        
        if isHighLighted == true
        {
            cell.btnUpDown.isSelected = true
        }
        else
        {
            cell.btnUpDown.isSelected = false
        }
        
        cell.btn_Click.tag = section;
        cell.btn_Click.addTarget(self, action:#selector(btn_Section(_:)), for: .touchUpInside)

        return cell
    }

    @IBAction func btn_Section(_ sender: UIButton) {
        
        if  isHighLighted == true {
            tbl_reload_Number = 0
            isHighLighted = false
            tblViewProblematic.reloadData()
        }
        else{
            tbl_reload_Number = 2
            isHighLighted = true
            tblViewProblematic.reloadData()
            tblViewProblematic.scrollToRow(at: IndexPath(item:1, section: 0), at: .bottom, animated: true)
        }
        
        
//        tblViewProblematic.setContentOffset(CGPoint(x: 0, y: CGFLOAT_MAX), animated: true)

    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return tbl_reload_Number
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellStatistic", for:indexPath as IndexPath) as! StatisticeCell
    
     cell.lblTitle.text = "Problematic Word"
      cell.selectionStyle = .none
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            
        }
    }
}
