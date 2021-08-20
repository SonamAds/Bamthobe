//
//  ProfileVC.swift
//  Bam
//
//  Created by ADS N URL on 17/03/21.
//

import UIKit
import Alamofire


class ProfileVC: UIViewController {

    // MARK:- Variables
    var apiHelper = ApiHelper()
    var GETPROFILE = "1"
    var userManager = UserManager.userManager
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var profileView:UIView!
    @IBOutlet weak var profileImgView:UIImageView!
    @IBOutlet weak var NameLbl:UITextField!
    @IBOutlet weak var phoneNumberLbl:UITextField!
    @IBOutlet weak var emailLbl:UITextField!
    @IBOutlet weak var genderLbl:UITextField!
    @IBOutlet weak var genderIV:UIButton!
    @IBOutlet weak var editBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        profileImgView.layer.cornerRadius = profileView.frame.size.height/2
//        profileImgView.layer.borderColor = AppUsedColors.appColor.cgColor
        apiHelper.responseDelegate = self
       // profileSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
//        profileSetup()
    }

    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: KGetProfile, tag: GETPROFILE)
    }
    
    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_editChanges(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_gender(_ sender: UIButton) {
    }
}


//MARk: - API
extension ProfileVC: ApiResponseDelegate{
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
            let jsonDecoder = JSONDecoder()
            LoadingIndicatorView.hide()
            switch tag {
            case GETPROFILE:
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
                    NameLbl.text = responce.data?.name
                    phoneNumberLbl.text = responce.data?.mobile
                    emailLbl.text = responce.data?.email
                    genderLbl.text = responce.data?.gender
                    profileImgView.sd_setImage(with: URL(string: responce.data?.image ?? ""), placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                        self.profileImgView.image = image
                        self.profileImgView.contentMode = .scaleToFill
                    }
                   }else if responce.status == false {
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
