//
//  CreateAppointmentsVC.swift
//  Bam
//
//  Created by ADS N URL on 09/04/21.
//

import UIKit
import Alamofire


class CreateAppointmentsVC: UIViewController {
    
    //MARK: - Variables
    var productId = ""
//    var measrmntId = 0
    let datePicker = DatePickerDialog()
    var thobeDict = [String: String]()
    var thobeArr = [[String: String]]()
    var branchId = 0
    var apiHelper = ApiHelper()
    var ADDCART = "1"
    var ADDTOCART = "2"
    var userManager = UserManager.userManager
//    var apiHelper = ApiHelper()
//    var GETADDRESS = "1"
//    var userManager = UserManager.userManager
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var branchTF:UITextField!
    @IBOutlet weak var timeTF:UITextField!
    @IBOutlet weak var dateTF:UITextField!
    @IBOutlet weak var mobileTF:UITextField!
    @IBOutlet weak var nameTF:UITextField!
    
    @IBOutlet weak var branchView:UIView!
    @IBOutlet weak var timeView:UIView!
    @IBOutlet weak var dateView:UIView!
    @IBOutlet weak var mobileView:UIView!
    @IBOutlet weak var nameView:UIView!
    
    @IBOutlet weak var timeSV:UIStackView!
    @IBOutlet weak var branchSV:UIStackView!
    
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var continueBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if thobeDict["measurement_type"] == "0" {//== "Branch Appointment" {
            branchSV.isHidden = false
            branchTF.delegate = self
            timeSV.isHidden = true
        } else {
            branchSV.isHidden = true
            timeSV.isHidden = false
        }
        mobileTF.delegate = self
        dateTF.delegate = self
        timeTF.delegate = self
        branchTF.delegate = self
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        mobileView.layer.borderWidth = 1
        mobileView.layer.borderColor = UIColor.lightGray.cgColor
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.lightGray.cgColor
        timeView.layer.borderWidth = 1
        timeView.layer.borderColor = UIColor.lightGray.cgColor
        branchView.layer.borderWidth = 1
        branchView.layer.borderColor = UIColor.lightGray.cgColor
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.PostData(urlString: kAddDesignThobeCart, tag: ADDCART, params: ["fabric": "\(thobeDict["fabric"] ?? "")", "collar": "\(thobeDict["collar"] ?? "")", "cuffs": "\(thobeDict["cuffs"] ?? "")", "pocket": "\(thobeDict["pocket"] ?? "")", "placket": "\(thobeDict["placket"] ?? "")", "button": "\(thobeDict["button"] ?? "")", "side_pocket": "\(thobeDict["side_pocket"] ?? "")", "side_pocket_2": "\(thobeDict["side_pocket_2"] ?? "")", "measurement": "\(thobeDict["measurement"] ?? "")", "measurement_type": "\(thobeDict["measurement_type"] ?? "")", "name": "\(thobeDict["name"] ?? "")", "mobile": "\(thobeDict["mobile"] ?? "")", "date": "\(thobeDict["date"] ?? "")", "branch": "\(thobeDict["branch"] ?? "")", "address": "\(thobeDict["address_id"] ?? "")"])
    }
    
    func addToCartApiHit() {
        apiHelper.PostData(urlString: kAddCart, tag: ADDTOCART, params: ["product_id":"\(thobeDict["product_id"] ?? "")", "quantity":"1", "type": "normal", "measurement": "", "measurement_type": "\(thobeDict["measurement_type"] ?? "")", "name": "\(thobeDict["name"] ?? "")", "mobile": "\(thobeDict["mobile"] ?? "")", "date": "\(thobeDict["date"] ?? "")", "branch": "\(thobeDict["branch"] ?? "")", "address": "\(thobeDict["address_id"] ?? "")", "time": "\(thobeDict["time"] ?? "")"])
    }
    
    
    //MARK: - Helping Methods
    func datePickerTapped() {
        let currentDate = Date.tomorrow
        var dateComponents = DateComponents()
        dateComponents.year = 3
        let threeYearLater = Calendar.current.date(byAdding: dateComponents, to: currentDate)

        datePicker.show(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Select Date", comment: ""),
        doneButtonTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Save", comment: ""),
        cancelButtonTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Cancel", comment: ""),
        minimumDate: currentDate,
        maximumDate: threeYearLater,
        datePickerMode: .date) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.dateTF.text = formatter.string(from: dt)
            }
        }
    }
    
    //MARK: - Helping Methods
    func timePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = 3
        let threeYearLater = Calendar.current.date(byAdding: dateComponents, to: currentDate)

        datePicker.show(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Select Time", comment: ""),
        doneButtonTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Save", comment: ""),
        cancelButtonTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Cancel", comment: ""),
        minimumDate: currentDate,
        maximumDate: threeYearLater,
        datePickerMode: .time) { (date) in
            if let dt = date {
//                self.timeTF.text = formatter.string(from: dt)
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                //for weekday name "EEEE HH:mm"
                //for 24 hour "HH:mm"
                self.timeTF.text = formatter.string(from: dt)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // fixes nil if device time in 24 hour format
                let date = dt
                dateFormatter.dateFormat = "HH:mm"
                let date24 = dateFormatter.string(from: date)
                self.thobeDict["time"] = date24

            }
        }
    }
    

    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_Continue(_ sender: UIButton) {
        if nameTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Enter Name", comment: ""), interval: 4)

        } else if mobileTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Enter Mobile Number", comment: ""), interval: 4)

        } else if dateTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Select Date", comment: ""), interval: 4)

        } else if branchTF.text == "" && thobeDict["measurement_type"] == "0" {//== "Branch Appointment" {
            SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Select Branch", comment: ""), interval: 4)
       
        } else if timeTF.text == "" && thobeDict["measurement_type"] == "1" {
            SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Select Time", comment: ""), interval: 4)
        
        } else {
            thobeDict["name"] = nameTF.text
            thobeDict["mobile"] = mobileTF.text
            thobeDict["date"] = dateTF.text
            
            if thobeDict["measurement_type"] == "0" {//appointmentType == "Branch Appointment" {
                thobeDict["branch"] = "\(branchId)"

                if thobeDict["product_id"] != "" {
                    addToCartApiHit()
                } else {
                    apiHit()
                }
                
            } else {
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "SelectAddressVC") as! SelectAddressVC
                if thobeDict["product_id"] != "" {
                    vc.thobeDict = thobeDict

                } else {
                vc.thobeDict = thobeDict
                vc.thobeArr = thobeArr
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
  
}


//MARK: - UITextField Delegate
extension CreateAppointmentsVC: UITextFieldDelegate {
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTF {
            datePickerTapped()
            return false
        } else if textField == timeTF {
            timePickerTapped()
            return false
        } else if textField == branchTF {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SelectBranchVC") as! SelectBranchVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
            self.present(vc, animated: true)
            return false
        }
//        else if textField ==
        return true
    }
}


extension CreateAppointmentsVC: backDelegate {
    func branchSelected(id: Int, name: String) {
        branchId = id
        branchTF.text = name
    }
    
}



//MARk: - API Success
extension CreateAppointmentsVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case ADDCART:
                do{
                    print(responseData)
                    let resultJson = try JSONSerialization.jsonObject(with: responseData.data!, options: []) as? [String:AnyObject]
                    print("resultJson", resultJson)
                    if let dictionary = resultJson as? [String: Any] {
                     print("dictionary", dictionary)
                        if let status = dictionary["status"] as? Bool {
                         print("status", status)
                            if status == true {
                                if let nestedDictionary = dictionary["message"] as? String {
                                 SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                                    mainTabBarController.selectedIndex = 1
                                    mainTabBarController.modalPresentationStyle = .fullScreen

                                    self.present(mainTabBarController, animated: true, completion: nil)
                                }
                            }else {
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
        case ADDTOCART:
            do{
                print(responseData)
                let response = try jsonDecoder.decode(AddtoCartModel.self, from: responseData.data!)
                if response.status == true/*200*/{
                    // create session here
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    mainTabBarController.selectedIndex = 1
                    mainTabBarController.modalPresentationStyle = .fullScreen

                    self.present(mainTabBarController, animated: true, completion: nil)
                
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



extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
