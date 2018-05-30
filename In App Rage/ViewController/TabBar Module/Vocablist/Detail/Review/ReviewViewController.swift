//
//  ReviewViewController.swift
//  Minnaz
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 iCoderz. All rights reserved.
//

import UIKit
import Koloda
import pop

var str_CatgorySaved = "Category"

private let numberOfCards: Int = 5
private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1

class ReviewViewController: UIViewController {
    weak var  txtWord : UITextField!
    
    var lblGoogleWord : UILabel!
    var lblOtherWord : UILabel!
    
    var viewCard : UIView!
    var viewFront : UIView!
    var viewLine1 : UIView!
    var viewLine2 : UIView!
    var viewWordDetails : UIView!
    
    var imgVwWord : UIImageView!
    var imgOtherDict : UIImageView!
    var imgGoogle : UIImageView!
    
    var btnVolume : UIButton!
    var btnEditPhoto : UIButton!
    var btnGoogle : UIButton!
    var btnOtherDict : UIButton!
    var btnDetailDictIcon : UIButton!
    var btnCloseDialogImage : UIButton!
    var btnEditWordImage : UIButton!
    var btnEditImage : UIButton!
    var btnWordDetail : UIButton!
    
    @IBOutlet var btnAddCard : UIButton!
    @IBOutlet var btnRemovCard : UIButton!
    
    @IBOutlet weak var btn_SaveFavorite : UIButton!
    
//    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var kolodaView: CustomKolodaView!
    
    //Image Picker
    let picker = UIImagePickerController()
    
    var isShowCardAllDetails: Bool = false
    var longPressGesture = UILongPressGestureRecognizer()
    
    var arr_TinderView : NSMutableArray  = []
    
    var int_Selected : Int = 0
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.viewSetup()
        
        arr_TinderView.add("icon_DownloadBlue")
        arr_TinderView.add("icon_DownloadBlue")
        arr_TinderView.add("icon_DownloadBlue")
        arr_TinderView.add("icon_DownloadBlue")
        arr_TinderView.add("icon_DownloadBlue")
        
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        
//        kolodaView.dataSource = self
//        kolodaView.delegate = self
    }
    //str_CatgorySaved
    override func viewWillAppear(_ animated: Bool) {
        btn_SaveFavorite.setTitle(str_CatgorySaved,for: .normal)
        
        btn_SaveFavorite.titleLabel?.font =  UIFont(name: GlobalConstants.kFontRegular, size: manageFont(font: 15))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewSetup() {
        picker.delegate = self
        
        viewCard.backgroundColor = cardDefaultColor
        viewWordDetails.backgroundColor = cardDefaultColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBarButton(_:)))
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressEvent(_:)))
        longPressGesture.isEnabled = false
        viewCard.addGestureRecognizer(longPressGesture)
        viewCard.addGestureRecognizer(tapGesture)
        
        self.showAndHideOtherViews(true)
        viewFront.isHidden = false
        viewWordDetails.isHidden = true
    }
    //MARK: - Gesture Method -
    @objc func tapBarButton(_ sender: UITapGestureRecognizer) {
        
        let vw = kolodaView.viewForCard(at: int_Selected) as? OverlayView

        if vw != nil{
            for subview in (vw?.subviews)! {
                self.vw_ManageTag(int_Value: subview.tag, view: subview)

                for subview2 in (subview.subviews) {
                    self.vw_ManageTag(int_Value: subview2.tag, view: subview2)

                    for subview3 in (subview2.subviews) {
                        self.vw_ManageTag(int_Value: subview3.tag, view: subview3)
                    }
                }
            }
            
            longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressEvent(_:)))
            viewCard.addGestureRecognizer(longPressGesture)
            
            txtWord.isEnabled = false
            btnCloseDialogImage.isHidden = true
            btnEditWordImage.isHidden = true
            btnEditImage.isHidden = true
            if isShowCardAllDetails {
                isShowCardAllDetails = false
                UIView.transition(with: viewCard, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                self.showAndHideOtherViews(true)
                longPressGesture.isEnabled = false
                btnEditPhoto.isUserInteractionEnabled = false
            }else {
                isShowCardAllDetails = true
                UIView.transition(with: viewCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                longPressGesture.isEnabled = true
                btnEditPhoto.isUserInteractionEnabled = true
                self.showAndHideOtherViews(false)
            }
        }
    }
    @objc func longPressEvent(_ sender: UILongPressGestureRecognizer) {
        txtWord.isEnabled = true
        btnCloseDialogImage.isHidden = false
        btnEditWordImage.isHidden = false
        btnEditImage.isHidden = false
        print("long preessssss")
    }
    
    // MARK: - Function -
    func showCameraOption() {
        self.picker.navigationBar.tintColor = UIColor.white
        let alert = UIAlertController(title: GlobalConstants.appName, message: "Select Photo Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                self.picker.allowsEditing = true
                self.picker.sourceType = .camera
                
                self.present(self.picker, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (action) in
            self.picker.allowsEditing = true
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func showAndHideOtherViews(_ isShow: Bool) {
        viewFront.isHidden = !isShow
        txtWord.isHidden = isShow
        viewLine1.isHidden = isShow
        viewLine2.isHidden = isShow
        btnGoogle.isHidden = isShow
        btnEditPhoto.isHidden = isShow
        btnOtherDict.isHidden = isShow
        lblGoogleWord.isHidden = isShow
        lblOtherWord.isHidden = isShow
        imgVwWord.isHidden = isShow
        btnVolume.isHidden = isShow
        
        imgGoogle.isHidden = isShow
        imgOtherDict.isHidden = isShow
    }
    
    
    // MARK: - Button Event -
    @IBAction func editPhotoClick(_ sender: Any) {
        self.showCameraOption()
        //        toggleLeft()
    }
    @IBAction func backWordDetailsClick(_ sender: Any) {
        //        toggleLeft()
        viewWordDetails.isHidden = true
    }
    @IBAction func googleClick(_ sender: Any) {
        //        toggleLeft()
        viewWordDetails.isHidden = false
        btnDetailDictIcon.setImage(UIImage(named:"google"), for: .normal)
    }
    @IBAction func otherDictClick(_ sender: Any) {
        //        toggleLeft()
        viewWordDetails.isHidden = false
        btnDetailDictIcon.setImage(UIImage(named:"convert"), for: .normal)
    }
    @IBAction func btn_Accept(_ sender: Any) {
        kolodaView?.swipe(.right)
        if int_Selected == arr_TinderView.count - 2{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btn_Reject(_ sender: Any) {
        kolodaView?.swipe(.left)
        if int_Selected == arr_TinderView.count - 2{
                self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btn_CloseEdit(_ sender: Any) {
        btnCloseDialogImage.isHidden = true
        btnEditWordImage.isHidden = true
        btnEditImage.isHidden = true
        
        txtWord.isEnabled = false
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
extension ReviewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension ReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        imgVwWord.image = pickedImage

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ReviewViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
    
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        
        int_Selected = index
        
        print(index)
    }
    
}


extension ReviewViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return arr_TinderView.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .slow
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let vw = Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
        
       for subview in (vw?.subviews)! {
            self.vw_ManageTag(int_Value: subview.tag, view: subview)

            for subview2 in (subview.subviews) {
                self.vw_ManageTag(int_Value: subview2.tag, view: subview2)

                for subview3 in (subview2.subviews) {
                    self.vw_ManageTag(int_Value: subview3.tag, view: subview3)
                }
            }
        }

        self.viewSetup()
        
        return vw!
    }
    
    func vw_ManageTag(int_Value : Int,view : Any) {
        
        switch int_Value {
        case 100:
            self.viewCard = view as! UIView
         break
        case 101:
            self.viewWordDetails = view as! UIView
            break
        case 102:
            self.viewFront = view as! UIView
            break
        case 103:
            self.viewLine1 = view as! UIView
            break
        case 104:
            self.viewLine2 = view as! UIView
            break
        case 201:
            self.txtWord = view as! UITextField
            break
        case 301:
            self.lblGoogleWord = view as! UILabel
            break
        case 302:
            self.lblOtherWord = view as! UILabel
            break
        case 401:
            self.btnVolume = view as! UIButton
            break
        case 402:
            self.btnEditPhoto = view as! UIButton
            self.btnEditPhoto.addTarget(self, action:#selector(self.editPhotoClick(_:)), for: .touchUpInside)
            break
        case 403:
            self.btnOtherDict = view as! UIButton
            self.btnOtherDict.addTarget(self, action:#selector(self.otherDictClick(_:)), for: .touchUpInside)
            break
        case 404:
            self.btnDetailDictIcon = view as! UIButton
            self.btnOtherDict.addTarget(self, action:#selector(self.btn_CloseEdit(_:)), for: .touchUpInside)
            break
        case 405:
            self.btnCloseDialogImage = view as! UIButton
            self.btnCloseDialogImage.addTarget(self, action:#selector(self.btn_CloseEdit(_:)), for: .touchUpInside)
            break
        case 406:
            self.btnEditWordImage = view as! UIButton
            self.btnEditWordImage.addTarget(self, action:#selector(self.btn_CloseEdit(_:)), for: .touchUpInside)
            break
        case 407:
            self.btnEditImage = view as! UIButton
            break
        case 408:
            self.btnGoogle = view as! UIButton
            self.btnGoogle.addTarget(self, action:#selector(self.googleClick(_:)), for: .touchUpInside)
            break
        case 409:
            self.btnWordDetail = view as! UIButton
            self.btnWordDetail.addTarget(self, action:#selector(self.backWordDetailsClick(_:)), for: .touchUpInside)
            break
        case 501:
            self.imgVwWord = view as! UIImageView
            break
        case 502:
            self.imgOtherDict = view as! UIImageView
            break
        case 503:
            self.imgGoogle = view as! UIImageView
            break
            
        default:
            break
        }
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
    }
}
