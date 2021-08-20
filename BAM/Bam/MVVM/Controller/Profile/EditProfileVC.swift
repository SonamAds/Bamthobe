//
//  EditProfileVC.swift
//  Bam
//
//  Created by ADS N URL on 17/03/21.
//

import UIKit
import Alamofire
import Photos

class EditProfileVC: UIViewController {

    // MARK:- Variables
    let picker = UIImagePickerController()
    var genderSlected = 0
    var apiHelper = ApiHelper()
    var UPDATEPROFILE = "1"
    var userManager = UserManager.userManager
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var profileView:UIView!
    @IBOutlet weak var profileImgView:UIImageView!
    @IBOutlet weak var profileEditBtn:UIButton!
    @IBOutlet weak var profileTapGesture:UITapGestureRecognizer!

    @IBOutlet weak var NameLbl:UITextField!
    @IBOutlet weak var phoneNumberLbl:UITextField!
    @IBOutlet weak var emailLbl:UITextField!
    @IBOutlet weak var genderMaleIV:UIButton!
    @IBOutlet weak var genderFemaleIV:UIButton!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var saveBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        NameLbl.text = userManager.getUserName()
        phoneNumberLbl.text = userManager.getMobile()
        emailLbl.text = userManager.getUserEmail()
        if userManager.getGender() == "Male" {
            genderMaleIV.setImage(#imageLiteral(resourceName: "_Icons - Check"), for: .normal)
            genderFemaleIV.setImage(nil, for: .normal)
            genderSlected = 1
        } else {
            genderFemaleIV.setImage(#imageLiteral(resourceName: "_Icons - Check"), for: .normal)
            genderMaleIV.setImage(nil, for: .normal)
            genderSlected = 2
        }
        profileImgView.sd_setImage(with: URL(string: userManager.getImage()), placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            self.profileImgView.image = image
            self.profileImgView.contentMode = .scaleToFill
        }
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        profileSetup()
    }
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.UploadReq(urlString: KUpdateProfile, tag: UPDATEPROFILE, params: ["name":"\(NameLbl.text ?? "")","gender":"\(genderSlected == 1 ? "Male": "Female")","email":"\(emailLbl.text ?? "")"], upImage: profileImgView.image!)
    }

    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_Image(_ sender: Any) {
        openActionSheet()
    }
    
    @IBAction func btnTap_saveChanges(_ sender: UIButton) {
        if NameLbl.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Name", interval: 2)
            return
            
        } else if phoneNumberLbl.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Mobile Number", interval: 2)
            return
            
        } else if emailLbl.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Email ID", interval: 2)
            return
            
        } else if genderSlected == 0 {
            SnackBar().showSnackBar(view: self.view, text: "Select Gender", interval: 2)
            return
            
        } else {
            apiHit()
        }
    }
    
    @IBAction func btnTap_genderMale(_ sender: UIButton) {
        genderSlected = 1
        genderMaleIV.setImage(#imageLiteral(resourceName: "_Icons - Check"), for: .normal)
        genderFemaleIV.setImage(nil, for: .normal)
    }
    
    @IBAction func btnTap_genderFemale(_ sender: UIButton) {
        genderSlected = 2
        genderFemaleIV.setImage(#imageLiteral(resourceName: "_Icons - Check"), for: .normal)
        genderMaleIV.setImage(nil, for: .normal)
    }
}


extension EditProfileVC {
    func openActionSheet() {
        let alert:UIAlertController=UIAlertController(title: "Upload Options", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Take a Photo", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        if UI_USER_INTERFACE_IDIOM() != .phone {
            alert.popoverPresentationController?.permittedArrowDirections = .any
//            var rect = sender.bounds
//            rect.origin.x = view.frame.size.width
//            rect.origin.y = rect.origin.y + 50
            alert.popoverPresentationController?.sourceView = view
//            alert.popoverPresentationController?.sourceRect = rect
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Camera And Gallery Open
    func openGallary()
    {
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.present(self.picker, animated: true, completion: {
                })
                }
            }
        }
    }
    
    //MARK:- Camera Open
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            picker.sourceType = UIImagePickerController.SourceType.camera
            self .present(picker, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
}

//MARK: - UIImage Picker delegate
extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /*if*/ let pickedImage:UIImage = (info[.originalImage] as? UIImage)! //  {
        UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
        profileImgView.image = pickedImage
        profileImgView.contentMode = .scaleToFill
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


//MARk: - API
extension EditProfileVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case UPDATEPROFILE:
                do{
                    print(responseData)
                    let responce = try jsonDecoder.decode(LoginModel.self, from: responseData.data!)
                   if responce.status == true/*200*/{
                    // create session here
                        userManager.setUserId(id: responce.data?.id ?? 0)
                        userManager.setUserEmail(email: responce.data?.email ?? "")
                        userManager.setUserName(name: responce.data?.name ?? "")
                        userManager.setImage(image: responce.data?.image ?? "")
                        userManager.setType(type: responce.data?.type ?? "")
                        userManager.setMobile(mobile: responce.data?.mobile ?? "")
                        userManager.setRole(roleId: responce.data?.role_id ?? "")
                        userManager.setGender(gender: responce.data?.gender ?? "")
                        userManager.setApiToken(apiToken: responce.data?.token ?? "")
                        self.navigationController?.popViewController(animated: true)
                    
                   } else if responce.status == false {
                        LoadingIndicatorView.hide()
                        SnackBar().showSnackBar(view: self.view, text: "\(responce.message ?? "")", interval: 4)
                    }
                }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
            default:
                break
        }
    }


    func onFailure(msg: String) {
        LoadingIndicatorView.hide()
        SnackBar().showSnackBar(view: self.view, text: "\(msg)", interval: 4)
    }

    func onError(error: AFError) {
        LoadingIndicatorView.hide()
        SnackBar().showSnackBar(view: self.view, text: "\(error)", interval: 4)
    }


}
