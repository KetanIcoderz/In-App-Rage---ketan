//
//  ShowSelectedImageViewController.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit

class ShowSelectedImageViewController: UIViewController {
    
    var selectedImage =  UIImage()
    @IBOutlet var viewShowFavorite: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewShowFavorite.image = selectedImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
      //        toggleLeft()
      self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  
}
