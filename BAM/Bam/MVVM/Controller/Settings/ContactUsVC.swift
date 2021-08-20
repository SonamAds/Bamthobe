//
//  ContactUsVC.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit
import Alamofire


class ContactUsVC: UIViewController {

    //MARK: - Variables
    var apiHelper = ApiHelper()
    var CONTACT = "1"
    var userManager = UserManager.userManager
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var message: UILabel!

    @IBOutlet weak var messageTF:UITextView!
    @IBOutlet weak var emailTF:UITextField!
    @IBOutlet weak var mobileTF:UITextField!
    @IBOutlet weak var nameTF:UITextField!
    @IBOutlet weak var messageView:UIView!
    @IBOutlet weak var emailView:UIView!
    @IBOutlet weak var mobileView:UIView!
    @IBOutlet weak var nameView:UIView!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var submitBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        messageTF.text = "Type your message here...."
        messageTF.textColor = UIColor.lightGray
        messageTF.delegate = self
        mobileTF.delegate = self
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        mobileView.layer.borderWidth = 1
        mobileView.layer.borderColor = UIColor.lightGray.cgColor
        emailView.layer.borderWidth = 1
        emailView.layer.borderColor = UIColor.lightGray.cgColor
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.lightGray.cgColor
//        submitBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Submit", comment: ""), for: .normal)
//       // headingLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Contact Us", comment: "")
//
//        name.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Name", comment: "")
//        mobileNumber.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Mobile Number", comment: "")
//        email.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Email ID", comment: "")
//        message.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Message", comment: "")
//        messageTF.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Type your message here…", comment: "")
//         
//        mobileTF.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "eg: +919233778273", comment: "")
//        nameTF.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "eg: James Bond", comment: "")
//        emailTF.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "eg: jamesbond@gmail.com", comment: "")

        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.PostData(urlString: kContactUs, tag: CONTACT, params: ["name": nameTF.text ?? "", "email":emailTF.text ?? "", "mobile": mobileTF.text ?? "", "message": messageTF.text ?? ""])
    }
    
    
    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_submit(_ sender: UIButton) {
        if nameTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Name", interval: 4)
            return
            
        } else if mobileTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Mobile", interval: 4)
            return
            
        } else if emailTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Email ID", interval: 4)
            return
            
        } else if emailTF.text != "" && isValidEmail(testStr: emailTF.text!) != true {
            SnackBar().showSnackBar(view: self.view, text: "Enter Valid Email ID", interval: 4)
            return
        
        } else if messageTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Message", interval: 4)
            return
            
        } else {
            apiHit()
        }
        
    }
}


extension ContactUsVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTF.textColor == UIColor.lightGray {
            messageTF.text = ""
            messageTF.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTF.text.isEmpty {
            messageTF.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Type your message here…", comment: "")//"Type your message here...."
            messageTF.textColor = UIColor.lightGray
        }
    }
}


//MARK: - UITextField Delegate
extension ContactUsVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileTF {
        let cs = NSCharacterSet(charactersIn: "0123456789").inverted
        let filtered: String = string.components(separatedBy: cs).joined(separator: "")
        let stringLength: String? = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if (stringLength?.count ?? 0) > 10 {
            return false
        } else {
            return string == filtered
        }
        }
        return false
    }
}

extension ContactUsVC: View1Delegate {
    func dismissViewController(controller: UIViewController) {
//        let currentIndex : Int? = self.tabBarController?.selectedIndex
//
//        self.tabBarController?.selectedIndex = 0
//
//        if let ramTBC =  self.tabBarController,
//            let current = currentIndex {
//            ramTBC.selectedIndex = 0
////            ramTBC.setSelectIndex(from: current, to: 2)
//        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        mainTabBarController.selectedIndex = 0
        mainTabBarController.modalPresentationStyle = .fullScreen

        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
}


//MARk: - API Success
extension ContactUsVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        
        case CONTACT:
            do{
                let resultJson = try? JSONSerialization.jsonObject(with: responseData.data!, options: []) as? [String:AnyObject]
                print("resultJson", resultJson)
                if let dictionary = resultJson as? [String: Any] {
                    print("dictionary", dictionary)
                    if let status = dictionary["status"] as? Bool {
                        print("status", status)
                        if status == true {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "GiftPopVC") as! GiftPopVC
                            vc.selectedPop = "Contact"
                            vc.delegate = self
                            vc.modalPresentationStyle = .overCurrentContext
                            vc.modalTransitionStyle = .crossDissolve
                            self.present(vc, animated: true)
                        } else {
                            print("status 400")
                            if let nestedDictionary = dictionary["message"] as? String {
                                SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
                            }
                        }
                    }
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
