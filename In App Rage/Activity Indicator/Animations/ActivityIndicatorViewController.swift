//
//  ActivityIndicatorViewController.swift
//  Demo_All_iOS
//
//  Created by JENEYUS on 19/01/17.
//  Copyright © 2017 JENEYUS. All rights reserved.
//

import UIKit
import Foundation


class ActivityIndicatorViewController: UIViewController,NVActivityIndicatorViewable {

    var set_Title = "Loading..."
    var set_Paddng: CGFloat = 20
    var set_Color: UIColor = UIColor.white
    var set_IndicatorStype: Int = 1 //Set as 1 to 31 different types
    var set_IndicatorBackGroundShow: Bool = false
    var set_IndicatorBackGroundColor: UIColor = UIColor.darkGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func IndicatorShow() {
        //BackGround Set
        let img_BG = UIImageView(frame: self.view.frame)
        img_BG.alpha = 0.5
        img_BG.backgroundColor = UIColor.darkGray
        self.view.addSubview(img_BG)
        
        //Indicator
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,type: NVActivityIndicatorType(rawValue:set_IndicatorStype)!)
        activityIndicatorView.center = self.view.center
        activityIndicatorView.padding = set_Paddng
        activityIndicatorView.color = set_Color
        activityIndicatorView.startAnimating()
        
        //Title Set
        let animationTypeLabel = UILabel(frame: frame)
        animationTypeLabel.text = set_Title
        animationTypeLabel.sizeToFit()
        animationTypeLabel.textColor = UIColor.white
        animationTypeLabel.frame.origin.x = 5
        animationTypeLabel.frame.origin.y = activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height
        animationTypeLabel.frame.size.width = self.view.frame.size.width - 10
        animationTypeLabel.textAlignment = NSTextAlignment.center
        
        //Indicator BackGround
        let indicatorBGImage = UIImageView(frame: frame)
        indicatorBGImage.backgroundColor = set_IndicatorBackGroundColor
        indicatorBGImage.center = self.view.center
        indicatorBGImage.alpha = 0.5
        indicatorBGImage.layer.cornerRadius = 5.0
        indicatorBGImage.layer.masksToBounds = true
        indicatorBGImage.isHidden = set_IndicatorBackGroundShow
        
        self.view.addSubview(indicatorBGImage)
        self.view.addSubview(activityIndicatorView)
        self.view.addSubview(animationTypeLabel)
        
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
