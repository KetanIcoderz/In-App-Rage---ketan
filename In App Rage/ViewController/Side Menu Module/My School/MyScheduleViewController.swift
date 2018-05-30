//
//  ViewController.swift
//  CalendarDemo
//
//  Created by iCoderz_07 on 16/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

import WRCalendarView

class MyScheduleViewController: UIViewController, UIGestureRecognizerDelegate {

    //Week calendar view
    @IBOutlet weak var weekView: WRWeekView!
    
    @IBOutlet weak var lbl_Month: UILabel!
    @IBOutlet weak var lbl_Week: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Week Calendar View
        self.setupCalendarData()
        self.commanMethod()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        // weekView.calendarType = .week
        //weekView.calendarType = .day
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - WRCalendarView -
    func setupCalendarData() {
        weekView.setCalendarDate(Date())
        weekView.delegate = self
    }
    @objc func moveToToday() {
        weekView.setCalendarDate(Date(), animated: true)
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return min(statusBarSize.width, statusBarSize.height)
    }
    
    func detailView(){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let view = storyboard.instantiateViewController(withIdentifier: "MyFilesPopUpViewController") as! MyFilesPopUpViewController
//        view.modalPresentationStyle = .custom
//        view.modalTransitionStyle = .crossDissolve
//        present(view, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "TodayLessonViewController") as! TodayLessonViewController
        view.modalPresentationStyle = .custom
        view.modalTransitionStyle = .crossDissolve
        present(view, animated: true)
        
    }
    
    // MARK: - Other Method -
    func commanMethod(){
        
        //add today button
        let rightButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(moveToToday))
        navigationItem.rightBarButtonItem = rightButton
        
        //add events
        weekView.addEvent(event: WREvent.make(date: Date(), chunk: 1.hours, title: "Two Event" , numberofEvent : "2"))
        
        var dateGet =  dateStartToDayStart(date:"2018-02-21 10:00:00",type:"2")
        
        weekView.addEvent(event: WREvent.make(date:dateGet as Date, chunk: 1.hours, title: "Three Event" , numberofEvent : "3"))
        
        var dateGet2 =  dateStartToDayStart(date:"2018-02-21 2:00:00",type:"2")
        
        weekView.addEvent(event: WREvent.make(date:dateGet2 as Date, chunk: 1.hours, title: "One Event" , numberofEvent : "1"))
        
//
//        dateGet =  dateStartToDayStart(date:"2018-02-18 00:00:00",type:"1")
//
//        weekView.addEvent(event: WREvent.make(date:dateGet as Date, chunk: 24.hours, title: "Big Event"))
//        
//        dateGet =  dateStartToDayStart(date:"2018-02-19 00:00:00",type:"1")
//
//        weekView.addEvent(event: WREvent.make(date:dateGet as Date, chunk: 24.hours, title: "Big Event"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_Today(_ sender : Any){
        weekView.setCalendarDate(Date(), animated: true)
    }
}


extension MyScheduleViewController: WRWeekViewDelegate {
    func view(startDate: Date, interval: Int) {
        print(startDate, interval)
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: startDate)
        let year = calendar.component(.year, from: startDate)
        lbl_Month.text = monthName(number : month)
        
        let weekOfYear = calendar.component(.weekOfYear, from: startDate)
        print(weekOfYear)
        lbl_Week.text =  String(year) + "  Week " + String(weekOfYear)
        
    }
    func monthName (number : Int) -> String{
        let str_Value = ""
        
        switch number {
        case 1:
            return "Jan"
            break
        case 2:
            return "Feb"
            break
        case 3:
            return "Mar"
            break
        case 4:
            return "Apr"
            break
        case 5:
            return "May"
            break
        case 6:
            return "Jun"
            break
        case 7:
            return "Jul"
            break
        case 8:
            return "Aug"
            break
        case 9:
            return "Sep"
            break
        case 10:
            return "Oct"
            break
        case 11:
            return "Nov"
            break
        case 12:
            return "Dec"
            break
        default:
            break
        }
        
        return str_Value
    }
    
    func tap(date: Date) {
        self.detailView()
        print(date)
    }
    
    func selectEvent(_ event: WREvent) {
        print(event.title)
    }
}


//MARK: - Collection View -
extension MyScheduleViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        let str_Image : String = arr_Header[indexPath.row]
        //        let starWidth = str_Image.widthOfString(usingFont: UIFont(name:  GlobalConstants.kFontBold, size: 16)!) + 20
        
        return CGSize(width: CGFloat(GlobalConstants.windowWidth/7), height: CGFloat(GlobalConstants.windowWidth/7))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        
        return cell
    }

}

