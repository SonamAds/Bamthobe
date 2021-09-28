//
//  OtpVerifyVC.swift
//  Bam
//
//  Created by ADS N URL on 16/03/21.
//

import UIKit
import OTPFieldView
import Alamofire

class OtpVerifyVC: UIViewController {
    
    //MARK: - Variables
    var passedView = 0
    var otp = ""
    var otpEntered = false
    var apiHelper = ApiHelper()
    var OTPVERIFIED = "-1"
    var userManager = UserManager.userManager
    
    //MARK: - IBOutlet Propreties
    @IBOutlet var otpTextFieldView: OTPFieldView!
    @IBOutlet var otpView: UIView!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var sentOtp: UILabel!
    @IBOutlet weak var dontAccountLbl: UILabel!
    @IBOutlet weak var resendLbl: UILabel!
    @IBOutlet weak var resendTimerLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    
    //For Localizable files
//    let firstNameMessage        = LocalizationSystem.sharedInstance.localizedStringForKey(key: "First name is required.", comment: "")
//    let lastNameMessage         = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Last name is required.", comment: "")
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
//        let quote = "Don't have an Account? Sign Up"
//        let attributedQuote = NSMutableAttributedString(string: quote)
//        attributedQuote.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 23, length: 7))
//        dontAccountLbl.attributedText = attributedQuote

        //            resendTimerLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Resend:", comment: "")
        
        apiHelper.responseDelegate = self
        setupOtpView()
//        self.otpView.addSubview(setupOtpView())
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helping Method
    func apiHit() {
        if passedView == 0 {
            apiHelper.PostData(urlString: KOtpVerified, tag: OTPVERIFIED, params: ["mobile":"\(userManager.getMobile())","otp":"\(otp)"])
        } else {
            apiHelper.PostData(urlString: KResetOtpVerified, tag: OTPVERIFIED, params: ["mobile":"\(userManager.getMobile())","otp":"\(otp)"])
        }

    }
    
    //MARK: - IBActions
    @IBAction func onBtnBackClicked(_ sender: Any) {
        if passedView == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func onBtnSubmitClicked(_ sender: Any) {
        
//        guard validateData() else { return }
        if otpEntered == false {
            let alert = UIAlertController(title: "Warning", message: "Entered OTP", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (cancel) in
                DispatchQueue.main.async {() }
            }))
            
            present(alert, animated: true, completion: nil)
        } else {
            apiHit()
        
        }
    }
    
    @IBAction func onBtnSignUpClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Helping Methods
    func setupOtpView(){
            self.otpTextFieldView.fieldsCount = 4
            self.otpTextFieldView.fieldBorderWidth = 2
            self.otpTextFieldView.defaultBorderColor = UIColor.black
            self.otpTextFieldView.filledBorderColor = UIColor.green
            self.otpTextFieldView.cursorColor = UIColor.red
            self.otpTextFieldView.displayType = .underlinedBottom
            self.otpTextFieldView.fieldSize = 40
            self.otpTextFieldView.separatorSpace = 8
            self.otpTextFieldView.shouldAllowIntermediateEditing = false
            self.otpTextFieldView.delegate = self
            self.otpTextFieldView.initializeUI()
    }
   

}


extension OtpVerifyVC: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        if hasEntered == true {
            otpEntered = true
        } else {
            otpEntered = false
        }
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        otp = otpString
        print("OTPString: \(otpString)")
    }
}

// MARK: User Define Methods
extension OtpVerifyVC {
    
//    func validateData() -> Bool {
//
//        guard !txtFirstName.text!.isEmptyStr else {
//            txtFirstName.showError(message: firstNameMessage)
//            return false
//        }
//        return true
//    }
}


//MARK: - API Success
extension OtpVerifyVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
            let jsonDecoder = JSONDecoder()
            LoadingIndicatorView.hide()
            switch tag {
            case OTPVERIFIED:
                do{
                    print(responseData)
                    let responce = try jsonDecoder.decode(SuccessModel.self, from: responseData.data!)
                   if responce.status == true/*200*/{
                    // create session here
                    
                    if passedView == 0 {
                        userManager.setlogin(login: true)
                        let objVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        let TabViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                        let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
                        appNavigation.setNavigationBarHidden(true, animated: true)
                        UIApplication.shared.windows[0].rootViewController = TabViewController
                    } else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewPasswordVC") as! CreateNewPasswordVC
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
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
