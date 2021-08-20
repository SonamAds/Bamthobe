//
//  LoginVC.swift
//  Bam
//
//  Created by ADS N URL on 16/03/21.
//

import UIKit
import Alamofire


class LoginVC: UIViewController {

    //MARK: - Variables
    var apiHelper = ApiHelper()
    var LOGNIN = "-1"
    var userManager = UserManager.userManager
    //For Localizable files
    let MobileNoMessage         = NSLocalizedString("Mobile Number is required.", comment: "")
    let passwordMessage         = NSLocalizedString("Password is required.", comment: "")
    
    //MARK: - IBOutlet Propreties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtMobileNumber: UITextFieldX!
    @IBOutlet weak var txtPassword: UITextFieldX!
    @IBOutlet weak var btn_Google: UIButton!
    @IBOutlet weak var btn_Twitter: UIButton!
    @IBOutlet weak var btn_Instagram: UIButton!
    @IBOutlet weak var btn_ForgotPass: UIButton!
    @IBOutlet weak var btn_Login: UIButton!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var dontAccountLbl: UILabel!

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            txtMobileNumber.overrideUserInterfaceStyle = .light
            txtPassword.overrideUserInterfaceStyle = .light

        } else {
            // Fallback on earlier versions
        }

        apiHelper.responseDelegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .lightContent
        }
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
//        var devicetoken = userManager.getDeviceToken() ?? ""
//        if devicetoken == ""{
//            devicetoken = "hello"
//        }
        apiHelper.PostData(urlString: KLogin, tag: LOGNIN, params: ["mobile":"\(txtMobileNumber.text ?? "")","password":"\(txtPassword.text ?? "")","device_token":userManager.getDeviceToken()])
                
    }
    
    //MARK: - IBActions
    @IBAction func onBtnSubmitClicked(_ sender: Any) {
        guard validateData() else { return }
                
//        let vc = storyboard?.instantiateViewController(withIdentifier: "CustomTabBarViewController") as! UITabBarController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            appDelegate.makeRootViewController()
//        }
//        guard validateData() else { return }
//
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
//        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func onBtnSignUpClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    @IBAction func onBtnGoogleClicked(_ sender: Any) {
        SnackBar().showSnackBar(view: self.view, text: "Coming Soon", interval: 4)

    }
    
    @IBAction func onBtnTwitterClicked(_ sender: Any) {
        SnackBar().showSnackBar(view: self.view, text: "Coming Soon", interval: 4)

    }
    
    @IBAction func onBtnInstagramClicked(_ sender: Any) {
        SnackBar().showSnackBar(view: self.view, text: "Coming Soon", interval: 4)

    }
    
    
    //MARK: - Helping Methods
    func clearForm() {
        self.txtMobileNumber.text    = ""
        self.txtPassword.text        = ""
    }
   

}


// MARK: User Define Methods
extension LoginVC {

    @objc func keyboardWillShow(notification:Notification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight.height, right: 0)
    }

    @objc func keyboardWillHide(notification:Notification) {
        scrollView.contentInset = .zero
    }

    func validateData() -> Bool {

        guard !txtMobileNumber.text!.isEmptyStr else {
            txtMobileNumber.showError(message: MobileNoMessage)
            return false
        }

        guard !txtPassword.text!.isEmptyStr else {
            txtPassword.showError(message: passwordMessage)
            return false
        }

        apiHit()
        return true
    }
}

//MARK: - API Success
extension LoginVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
            let jsonDecoder = JSONDecoder()
            LoadingIndicatorView.hide()
            switch tag {
            case LOGNIN:
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

                    let objVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    let TabViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
                    appNavigation.setNavigationBarHidden(true, animated: true)
                    UIApplication.shared.windows[0].rootViewController = TabViewController
                    
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
