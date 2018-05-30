//
//  MyFilesViewController.swift
//  Minnaz
//
//  Created by iCoderz_07 on 09/01/18.
//  Copyright © 2018 iCoderz. All rights reserved.
//

import UIKit

class MyFilesViewController: UIViewController, UINavigationControllerDelegate {

    //Collectionview declaration
    @IBOutlet weak var cv_Main : UICollectionView!
    
    //Other
     var arr_Main : NSMutableArray = []
    
    
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
        
        var obj = MyFilesViewControllerObject ()
        obj.str_Name = "File 1"
        obj.str_Image = "1"
        obj.str_Selected = "1"
        obj.str_Info = "1"
        arr_Main.add(obj)
        
        obj = MyFilesViewControllerObject ()
        obj.str_Name = "File 2"
        obj.str_Image = "21"
        obj.str_Selected = "1"
        obj.str_Info = "0"
        arr_Main.add(obj)
        
        obj = MyFilesViewControllerObject ()
        obj.str_Name = "File 3"
        obj.str_Image = "21"
        obj.str_Selected = "1"
        obj.str_Info = "0"
        arr_Main.add(obj)
        
        obj = MyFilesViewControllerObject ()
        obj.str_Name = "File 4"
        obj.str_Image = "21"
        obj.str_Selected = "0"
        obj.str_Info = "1"

        arr_Main.add(obj)
        
        obj = MyFilesViewControllerObject ()
        obj.str_Name = "File 5"
        obj.str_Image = "21"
        obj.str_Selected = "1"
        obj.str_Info = "1"
        arr_Main.add(obj)
        
        obj = MyFilesViewControllerObject ()
        obj.str_Name = "File 6"
        obj.str_Image = "21"
        obj.str_Selected = "1"
        obj.str_Info = "0"
        arr_Main.add(obj)
        
        obj = MyFilesViewControllerObject ()
        obj.str_Name = "File 7"
        obj.str_Image = "21"
        obj.str_Selected = "1"
        obj.str_Info = "0"
        arr_Main.add(obj)
        
        obj = MyFilesViewControllerObject ()
        obj.str_Name = "File 8"
        obj.str_Image = "21"
        obj.str_Selected = "1"
        obj.str_Info = "0"
        arr_Main.add(obj)
    }
    
    // MARK: - Button Event -
    @IBAction func btn_PickImage(_ sender:Any){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func btn_Info(_ sender: Any) {
        self.performSegue(withIdentifier: "popup", sender: self)
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


//MARK: - Friends Object -
class MyFilesViewControllerObject: NSObject {
    
    var str_Name : String = ""
    var str_Image : String = ""
    var str_Selected : String = ""
    var str_Info : String = ""
}

class MyFilesViewControllerCell : UICollectionViewCell {
    
    @IBOutlet var img_Preview: UIImageView!
    @IBOutlet var img_Seletected: UIImageView!
    
    @IBOutlet var btn_Info: UIButton!
    
    @IBOutlet var lbl_Tital: UILabel!
    
}


//MARK: - Collection View -
extension MyFilesViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr_Main.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(GlobalConstants.windowWidth/3), height: CGFloat(GlobalConstants.windowWidth/3))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var str_Identifier : String = "cell"
        
        if arr_Main.count == 0{
            str_Identifier = "nodata"
        }
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: str_Identifier, for: indexPath) as! MyFilesViewControllerCell
        
        if arr_Main.count != 0{
            let obj : MyFilesViewControllerObject = arr_Main[indexPath.row] as! MyFilesViewControllerObject
            
            cell.lbl_Tital.text = obj.str_Name
            
            if obj.str_Selected == "0"{
                cell.img_Seletected.image = UIImage(named:"icon_Wrong_File")
            }else{
                cell.img_Seletected.image = UIImage(named:"icon_Right_File")
            }
            
            cell.btn_Info.isHidden = true
            if obj.str_Info == "1"{
                cell.btn_Info.isHidden = false
            }
        }
        
        //Manage font
        cell.lbl_Tital.font = UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 17))
        
        cell.btn_Info.tag = indexPath.row
        cell.btn_Info.addTarget(self, action:#selector(btn_Info(_:)), for: .touchUpInside)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MyFilesViewController : UIImagePickerControllerDelegate{
    //MARK: - Imagepicker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
      
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}



