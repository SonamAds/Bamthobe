//
//  ForgotPasswordVC.swift
//  Bam
//
//  Created by ADS N URL on 16/03/21.
//

import UIKit
import Alamofire


class ForgotPasswordVC: UIViewController {
    
    //MARK: - Variables
    var apiHelper = ApiHelper()
    var FORGOTPASSWORD = "-1"
    var userManager = UserManager.userManager
    
    
    //MARK: - IBOutlet Propreties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtMobileNumber: UITextFieldX!
    @IBOutlet weak var btn_Send: UIButton!
    @IBOutlet weak var forgot: UILabel!
    @IBOutlet weak var dontAccountLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    
    //For Localizable files
    let MobileNumberMessage         = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Mobile number is required", comment: "")
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        let quote = "Don't have an Account? Sign Up"
        let attributedQuote = NSMutableAttributedString(string: quote)
        attributedQuote.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 23, length: 7))
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
        apiHelper.PostData(urlString: KForgotPassword, tag: FORGOTPASSWORD, params: ["mobile":"\(txtMobileNumber.text ?? "")"])

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
    
    
    @IBAction func onBtnForgotPasswordClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onBtnSignUpClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Helping Methods
    func clearForm() {
        self.txtMobileNumber.text    = ""
    }
   

}


// MARK: User Define Methods
extension ForgotPasswordVC {

    @objc func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight.height, right: 0)
    }

    @objc func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }

    func validateData() -> Bool {

        guard !txtMobileNumber.text!.isEmptyStr else {
            txtMobileNumber.showError(message: MobileNumberMessage)
            return false
        }
        apiHit()
        return true
    }
}


//MARK: - API Success
extension ForgotPasswordVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
            let jsonDecoder = JSONDecoder()
            LoadingIndicatorView.hide()
            switch tag {
            case FORGOTPASSWORD:
                do{
                    print(responseData)
                    let responce = try jsonDecoder.decode(SuccessModel.self, from: responseData.data!)
                   if responce.status == true/*200*/{
                    // create session here
                    userManager.setMobile(mobile: txtMobileNumber.text ?? "")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerifyVC") as! OtpVerifyVC
                    vc.passedView = 1
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                   }else if responce.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(responce.message ?? "")", interval: 4)
//                    AppSnackBar.make(in: self.view, message: "\(responce.message ?? "")", duration: .lengthLong).show()
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
