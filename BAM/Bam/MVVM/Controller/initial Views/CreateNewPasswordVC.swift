//
//  CreateNewPasswordVC.swift
//  Bam
//
//  Created by ADS N URL on 16/03/21.
//

import UIKit
import Alamofire


class CreateNewPasswordVC: UIViewController {
    
    //MARK: - Variables
    var apiHelper = ApiHelper()
    var CREATEPASSWORD = "-1"
    var userManager = UserManager.userManager
    
    //MARK: - IBOutlet Propreties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtPassword: UITextFieldX!
    @IBOutlet weak var txtConfirmPassword: UITextFieldX!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var dontAccountLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    //For Localizable files
    let passwordMessage         = NSLocalizedString("Password is required.", comment: "")
    let confirmPasswordMessage  = NSLocalizedString("Confirm password is required.", comment: "")
    let mismatchPasswordMessage = NSLocalizedString("Password and Confirm password are not matching.", comment: "")
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
//        btn_Submit.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Submit", comment: ""), for: .normal)
//        passwordLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Change Password", comment: "")
//        txtPassword.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Password", comment: "")
//        txtConfirmPassword.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Confirm Password", comment: "")
        
        apiHelper.responseDelegate = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Helping Method
    func apiHit() {
        apiHelper.PostData(urlString: KResetPassword, tag: CREATEPASSWORD, params: ["mobile":"\(userManager.getMobile())","password":"\(txtPassword.text ?? "")","password_confirmation":"\(txtPassword.text ?? "")"])
    }
    
    //MARK: - IBActions
    @IBAction func onBtnBackClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onBtnSubmitClicked(_ sender: Any) {
        
        guard validateData() else { return }
        
//        let alert = UIAlertController(title: "Congratulations", message: "Your registration is successful!!!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (cancel) in
//            DispatchQueue.main.async { self.clearForm() }
//        }))
//
//        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func onBtnSignUpClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Helping Methods
    func clearForm() {
        self.txtConfirmPassword.text = ""
        self.txtPassword.text        = ""
    }
   

}


// MARK: User Define Methods
extension CreateNewPasswordVC {
    
    @objc func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight.height, right: 0)
    }
    
    @objc func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }
    
    func validateData() -> Bool {
        
        guard !txtPassword.text!.isEmptyStr else {
            txtPassword.showError(message: passwordMessage)
            return false
        }
        
        guard !txtConfirmPassword.text!.isEmptyStr else {
            txtConfirmPassword.showError(message: confirmPasswordMessage)
            return false
        }
        
//        guard txtPassword.text == txtConfirmPassword.text else {
//            txtConfirmPassword.showError(message: mismatchPasswordMessage)
//            return false
//        }
        
        if txtPassword.text != txtConfirmPassword.text {
            txtConfirmPassword.showError(message: mismatchPasswordMessage)
        } else {
            apiHit()
        }
        
        return true
    }
}


//MARK: - API Success
extension CreateNewPasswordVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
            let jsonDecoder = JSONDecoder()
            LoadingIndicatorView.hide()
            switch tag {
            case CREATEPASSWORD:
                do{
                    print(responseData)
                    let responce = try jsonDecoder.decode(LoginModel.self/*SuccessModel.self*/, from: responseData.data!)
                   if responce.status == true/*200*/{
                    // create session here
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
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
