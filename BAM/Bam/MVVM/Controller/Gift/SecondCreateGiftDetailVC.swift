//
//  SecondCreateGiftDetailVC.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit
import Alamofire


class SecondCreateGiftDetailVC: UIViewController {

    //MARK: - Variables
    var giftId = 0
    var dateStr = ""
    var timeStr = ""
    var apiHelper = ApiHelper()
    var CREATEGIFT = "1"
    var userManager = UserManager.userManager
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var toTF:UITextField!
    @IBOutlet weak var fromTF:UITextField!
    @IBOutlet weak var shareFeelingTF:UITextField!
    @IBOutlet weak var messageTF:UITextView!
    @IBOutlet weak var mobileTF:UITextField!
    @IBOutlet weak var nameTF:UITextField!
    @IBOutlet weak var recipentNameTF:UITextField!
    @IBOutlet weak var recipentMobileTF:UITextField!

    @IBOutlet weak var anonymousSwitch:UISwitch!
    @IBOutlet weak var recipentCallSwitch:UISwitch!
    
    @IBOutlet weak var messageView:UIView!
    @IBOutlet weak var shareFeelingView:UIView!
    @IBOutlet weak var mobileView:UIView!
    @IBOutlet weak var nameView:UIView!
    
    @IBOutlet weak var detailsSV:UIStackView!
    @IBOutlet weak var recipentSV:UIStackView!
    
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var confirmBtn:UIButton!
    @IBOutlet weak var addAddressBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTF.text = "Type your card message here...."
        messageTF.textColor = UIColor.lightGray
        messageTF.delegate = self
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        mobileView.layer.borderWidth = 1
        mobileView.layer.borderColor = UIColor.lightGray.cgColor
        shareFeelingTF.layer.borderWidth = 1
        shareFeelingTF.layer.borderColor = UIColor.lightGray.cgColor
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        addAddressBtn.layer.borderWidth = 1
        addAddressBtn.layer.borderColor = UIColor.lightGray.cgColor
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_Continue(_ sender: UIButton) {
//        if confirmBtn.currentTitle == "Add" {
//            if recipentNameTF.text == "" {
//                SnackBar().showSnackBar(view: self.view, text: "Enter Recipent Name", interval: 4)
//            } else if recipentMobileTF.text == "" {
//                SnackBar().showSnackBar(view: self.view, text: "Enter Recipent Phone Number", interval: 4)
//            } else {
//                apiHelper.PostData(urlString: kAddGift, tag: CREATEGIFT, params: ["gift_id": giftId, "date": dateStr, "time": timeStr, "g_to": toTF.text ?? "", "g_from": fromTF.text ?? "", "message": messageTF.text ?? "", "mobile": recipentMobileTF.text ?? "", "receiver_name": recipentNameTF.text ?? ""])

//            }
//
//        } else {
            if toTF.text == "" {
                SnackBar().showSnackBar(view: self.view, text: "Enter To Email ID", interval: 4)
                
            } else if messageTF.text == "" {
                SnackBar().showSnackBar(view: self.view, text: "Enter message here...", interval: 4)
                
            } else if fromTF.text == "" {
                SnackBar().showSnackBar(view: self.view, text: "Enter From Email ID", interval: 4)
                
            } else {
                apiHelper.PostData(urlString: kAddGift, tag: CREATEGIFT, params: ["gift_id": giftId, "date": dateStr, "time": timeStr, "g_to": toTF.text ?? "", "g_from": fromTF.text ?? "", "message": messageTF.text ?? "", "mobile": recipentMobileTF.text ?? "", "receiver_name": recipentNameTF.text ?? ""])
//                detailsSV.isHidden = true
//                recipentSV.isHidden = false
//                confirmBtn.setTitle("Add", for: .normal)
            }
//        }
    }
    
    @IBAction func btnTap_AddAddress(_ sender: UIButton) {
    }
    
    @IBAction func switchTap_Anonymous(_ sender: UIButton) {
    }
    
    @IBAction func switchTap_RecipentCall(_ sender: UIButton) {
    }
}


extension SecondCreateGiftDetailVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTF.textColor == UIColor.lightGray {
            messageTF.text = ""
            messageTF.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTF.text.isEmpty {
            messageTF.text = "Type your card message here...."
            messageTF.textColor = UIColor.lightGray
        }
    }
}

//MARK: - Custom Delegate
extension SecondCreateGiftDetailVC: View1Delegate {
    func dismissViewController(controller: UIViewController) {

//        let currentIndex : Int? = self.tabBarController?.selectedIndex
//
//        self.tabBarController?.selectedIndex = 1
//
//        if let ramTBC =  self.tabBarController,
//            let current = currentIndex {
//            ramTBC.selectedIndex = 1
////            ramTBC.setSelectIndex(from: current, to: 2)
//        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        mainTabBarController.selectedIndex = 1
        mainTabBarController.modalPresentationStyle = .fullScreen
                
        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
}


//MARK: - UITextField Delegate
extension SecondCreateGiftDetailVC: UITextFieldDelegate {
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


//MARk: - API Success
extension SecondCreateGiftDetailVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case CREATEGIFT:
            do{
                print(responseData)
                let response = try jsonDecoder.decode(LoginModel.self, from: responseData.data!)
                if response.status == true/*200*/{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "GiftPopVC") as! GiftPopVC
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.modalTransitionStyle = .crossDissolve
                    vc.delegate = self
                    self.present(vc, animated: true)
//                    SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
                } else if response.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
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
