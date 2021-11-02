//
//  SignupVC.swift
//  Bam
//
//  Created by ADS N URL on 16/03/21.
//

import UIKit
import Alamofire


class SignupVC: UIViewController {
    
    //MARK: - Variables
    var apiHelper = ApiHelper()
    var SIGNUP = "-1"
    var userManager = UserManager.userManager
    
    
    //MARK: - IBOutlet Propreties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtFullName: UITextFieldX!
    @IBOutlet weak var txtMobileNumber: UITextFieldX!
    @IBOutlet weak var txtEmail: UITextFieldX!
    @IBOutlet weak var txtPassword: UITextFieldX!
    @IBOutlet weak var txtConfirmPassword: UITextFieldX!
    @IBOutlet weak var btn_Google: UIButton!
    @IBOutlet weak var btn_Twitter: UIButton!
    @IBOutlet weak var btn_Instagram: UIButton!
    @IBOutlet weak var btn_Signup: UIButton!
    @IBOutlet weak var signup: UILabel!
    @IBOutlet weak var dontAccountLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    
    //For Localizable files
    let fullNameMessage        = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Full name is required", comment: "")// LocalizationSystem.sharedInstance.localizedStringForKey(key: "Full name is required.", comment: "")
    let MobileNumberMessage         = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Mobile number is required", comment: "")//LocalizationSystem.sharedInstance.localizedStringForKey(key: "Mobile number is required.", comment: "")
    let emailMessage            = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Email is required", comment: "")//LocalizationSystem.sharedInstance.localizedStringForKey(key: "Email is required.", comment: "")
    let emailValidationMessage    = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Invalid Email", comment: "")//LocalizationSystem.sharedInstance.localizedStringForKey(key: "Invalid Email.", comment: "")
    let passwordMessage         = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Password is required", comment: "")//LocalizationSystem.sharedInstance.localizedStringForKey(key: "Password is required.", comment: "")
    let confirmPasswordMessage  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Confirm Password is required", comment: "")//LocalizationSystem.sharedInstance.localizedStringForKey(key: "Confirm password is required.", comment: "")
    let mismatchPasswordMessage = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Password and Confirm Password are not matching", comment: "")//LocalizationSystem.sharedInstance.localizedStringForKey(key: "Password and Confirm password are not matching.", comment: "")

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        
        txtMobileNumber.delegate = self
        let quote = "Already have an Account? Sign In" //"Don't have an Account? Sign Up"
        let attributedQuote = NSMutableAttributedString(string: quote)
        attributedQuote.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 25, length: 7))
        
        dontAccountLbl.attributedText = attributedQuote
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
        apiHelper.PostData(urlString: KSignUp, tag: SIGNUP, params: ["device_token":userManager.getDeviceToken(), "name":"\(txtFullName.text ?? "")","email":"\(txtEmail.text ?? "")","mobile":"\(txtMobileNumber.text ?? "")","password":"\(txtPassword.text ?? "")","password_confirmation":"\(txtPassword.text ?? "")"])
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
    
    @IBAction func onBtnGoogleClicked(_ sender: Any) {
        SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Coming Soon", comment: ""), interval: 4)

    }
    
    @IBAction func onBtnTwitterClicked(_ sender: Any) {
        SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Coming Soon", comment: ""), interval: 4)

    }
    
    @IBAction func onBtnInstagramClicked(_ sender: Any) {
        SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Coming Soon", comment: ""), interval: 4)

    }
    
    @IBAction func onBtnSignUpClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Helping Methods
    func clearForm() {
        self.txtFullName.text      = ""
        self.txtMobileNumber.text   = ""
        self.txtEmail.text         = ""
        self.txtConfirmPassword.text = ""
        self.txtPassword.text       = ""
    }
}


// MARK: User Define Methods
extension SignupVC {
    
    @objc func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight.height, right: 0)
    }
    
    @objc func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }
    
    func validateData() -> Bool {
        
        guard !txtFullName.text!.isEmptyStr else {
            txtFullName.showError(message: fullNameMessage)
            return false
        }
        
        guard !txtMobileNumber.text!.isEmptyStr else {
            txtMobileNumber.showError(message: MobileNumberMessage)
            return false
        }
        
        guard !txtEmail.text!.isEmptyStr else {
            txtEmail.showError(message: emailMessage)
            return false
        }

        guard txtEmail.text != "" && isValidEmail(testStr: txtEmail.text!) == true else {
            txtEmail.showError(message: emailValidationMessage)
            return false
        }
        guard !txtPassword.text!.isEmptyStr else {
            txtPassword.showError(message: passwordMessage)
            return false
        }
        
        guard !txtConfirmPassword.text!.isEmptyStr else {
            txtConfirmPassword.showError(message: confirmPasswordMessage)
            return false
        }
        
//        guard txtPassword.text != txtConfirmPassword.text else {
//            txtConfirmPassword.showError(message: mismatchPasswordMessage)
//            return false
//        }
        
//        guard txtPassword.text?.count ?? 0 < 6 else {
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


//MARK: - UITextField Delegate
extension SignupVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobileNumber {
        let cs = NSCharacterSet(charactersIn: "0123456789").inverted
        let filtered: String = string.components(separatedBy: cs).joined(separator: "")
        let stringLength: String? = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if (stringLength?.count ?? 0) > 10 {
            return false
        } else {
            return string == filtered
        }
//        } else if textField == txtPassword || textField == txtConfirmPassword {
//            let cs = NSCharacterSet(charactersIn: "0123456789").inverted
//            let filtered: String = string.components(separatedBy: cs).joined(separator: "")
//            let stringLength: String? = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//            if (stringLength?.count ?? 0) < 10 {
//                return false
//            } else {
//                return string == filtered
//            }
        }
        return false
    }
}


//MARK: - API Success
extension SignupVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
            let jsonDecoder = JSONDecoder()
            LoadingIndicatorView.hide()
            switch tag {
            case SIGNUP:
                do{
                    print(responseData)
                    let responce = try jsonDecoder.decode(LoginModel.self, from: responseData.data!)
                   if responce.status == true/*200*/{
                    // create session here
                    userManager.setlogin(login: true)
                    userManager.setUserId(id: responce.data?.id ?? 0)
                    userManager.setUserEmail(email: responce.data?.email ?? "")
                    userManager.setUserName(name: responce.data?.name ?? "")
                    userManager.setImage(image: responce.data?.image ?? "")
                    userManager.setType(type: responce.data?.type ?? "")
                    userManager.setMobile(mobile: responce.data?.mobile ?? "")
                    userManager.setRole(roleId: responce.data?.role_id ?? "")
                    userManager.setGender(gender: responce.data?.gender ?? "")
                    userManager.setApiToken(apiToken: responce.data?.token ?? "")

                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerifyVC") as! OtpVerifyVC
                    vc.passedView = 0
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
