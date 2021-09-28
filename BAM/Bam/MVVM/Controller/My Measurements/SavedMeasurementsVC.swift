//
//  SavedMeasurementsVC.swift
//  Bam
//
//  Created by ADS N URL on 08/04/21.
//

import UIKit
import Alamofire


class SavedMeasurementsVC: UIViewController {
    
    
    //MARK: - Variables
    var thobeDict = [String: String]()
    var thobeArr = [[String: String]]()
    var saved = ["Branch Appointment", "Home Visit"]
    var measurementModel: MeasurementModel?
    var apiHelper = ApiHelper()
    var GETMEASUREMENT = "0"
    var userManager = UserManager.userManager
    
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var backCustomizeBtn: UIButton!
    @IBOutlet weak var nextCustomizeSV: UIStackView!
    @IBOutlet weak var nextCustomizeLbl: UIButton!
    @IBOutlet weak var backCustomizeSV: UIStackView!
    @IBOutlet weak var backCustomizeLbl: UIButton!
    @IBOutlet weak var nextCustomizeBtn: UIButton!
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Measurement", comment: "")
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        if thobeDict["product_id"] != "1" {
            backCustomizeSV.isHidden = true
        } else {
            backCustomizeSV.isHidden = false
            backCustomizeLbl.setTitle("My Thobe", for: .normal)
        }

        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        apiHit()
    }
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.GetData(urlString: kGetMeasurements, tag: GETMEASUREMENT)
    }
    
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnTap_NextCustomize(_ sender: UIButton) {
        if nextCustomizeLbl.currentTitle == LocalizationSystem.sharedInstance.localizedStringForKey(key: "Continue", comment: "") {
//            addCartApi()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AlertWithTwoButtonVC") as! AlertWithTwoButtonVC
            if thobeDict["product_id"] != "" {
                vc.thobeDict = thobeDict
                vc.selectedPop = "1"
            } else {
                vc.thobeDict = thobeDict
                vc.thobeArr = thobeArr
            }
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        } else {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAppointmentsVC") as! CreateAppointmentsVC
            if thobeDict["product_id"] != "" {
                vc.thobeDict = thobeDict
            } else {
                vc.thobeDict = thobeDict
                vc.thobeArr = thobeArr
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnTap_BackCustomize(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
}


extension SavedMeasurementsVC: View1Delegate {
    func dismissViewController(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated:true)
    }
    
}

//MARK: - UITableView Delegate and DataSource
extension SavedMeasurementsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        }
        return measurementModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedMeasurementTVCell", for: indexPath) as! SavedMeasurementTVCell

        if indexPath.section == 1 {
            cell.nameLbl.text =        LocalizationSystem.sharedInstance.localizedStringForKey(key:  saved[indexPath.row], comment: "")

            cell.nameLbl.textColor = UIColor.white
            if  thobeDict["measurement_type"] == "\(indexPath.row)" {
                cell.tickIV.isHidden = false
            } else {
                cell.tickIV.isHidden = true
            }
            if indexPath.row == 0 {
                cell.usrIV.image = #imageLiteral(resourceName: "calendar")
                cell.backgView.backgroundColor = UIColor.black
            } else {
                cell.usrIV.image = #imageLiteral(resourceName: "home2")
                cell.backgView.backgroundColor = AppUsedColors.appColor
            }
            
//            if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
//                cell.nameLbl.textAlignment = .right
//            } else {
//                cell.nameLbl.textAlignment = .left
//            }
            
            getLang(label: [cell.nameLbl], btn: nil)
        } else {
            cell.nameLbl.text = measurementModel?.data?[indexPath.row].name
            cell.nameLbl.textColor = UIColor.black
            cell.backgView.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
            cell.usrIV.image = #imageLiteral(resourceName: "measuring")
            if thobeDict["measurement"] == "\(measurementModel?.data?[indexPath.row].id ?? 0)" {
                cell.tickIV.isHidden = false
            } else {
                cell.tickIV.isHidden = true
            }
        }
        getLang(label: [cell.nameLbl], btn: nil)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! SavedMeasurementTVCell
        
        if indexPath.section == 1 {
            if  thobeDict["measurement_type"] == "\(indexPath.row)" {
                thobeDict["measurement_type"] = ""
                thobeDict["measurement"] = ""
                nextCustomizeSV.isHidden = true
            } else {
                nextCustomizeSV.isHidden = false
                thobeDict["measurement_type"] = "\(indexPath.row)"
                thobeDict["measurement"] = ""
//                if indexPath.section == 1 {
                nextCustomizeLbl.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Appointment", comment: ""), for: .normal)
            }
        } else {
            if thobeDict["measurement"] == "\(measurementModel?.data?[indexPath.row].id ?? 0)" {
                thobeDict["measurement"] = ""
                thobeDict["measurement_type"] = ""
                nextCustomizeSV.isHidden = true
            } else {
                nextCustomizeSV.isHidden = false
                thobeDict["measurement_type"] = ""
                thobeDict["measurement"] = "\(measurementModel?.data?[indexPath.row].id ?? 0)"
                nextCustomizeLbl.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Continue", comment: ""), for: .normal)
            }
        }
        tableView.reloadData()

    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
        let returnedView = UIView(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 40)) //set these values as necessary
        returnedView.backgroundColor = .white

        let label = UILabel(frame: CGRect(x: 10, y: 5, width: UIScreen.main.bounds.width - 20, height: 30))
        if section == 1 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "New Measurement", comment: "")

        } else {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Saved Measurement", comment: "")

        }
        label.font = UIFont.boldSystemFont(ofSize: 15)//UIFont(name: "", size: 16)
        returnedView.addSubview(label)

        return returnedView
    }
}


//MARk: - API Success
extension SavedMeasurementsVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GETMEASUREMENT:
            do{
                print(responseData)
                measurementModel = try jsonDecoder.decode(MeasurementModel.self, from: responseData.data!)
                if measurementModel?.status == true/*200*/{
            // create session here
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                } else if measurementModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(measurementModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
    
//        case ADDCART:
//            do{
//                print(responseData)
//                let resultJson = try JSONSerialization.jsonObject(with: responseData.data!, options: []) as? [String:AnyObject]
//            print("resultJson", resultJson)
//            if let dictionary = resultJson as? [String: Any] {
//             print("dictionary", dictionary)
//                if let status = dictionary["status"] as? Bool {
//                 print("status", status)
//                    if status == true {
//                        if let nestedDictionary = dictionary["message"] as? String {
//                         SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let vc = storyboard.instantiateViewController(withIdentifier: "AlertWithTwoButtonVC") as! AlertWithTwoButtonVC
//                            vc.modalPresentationStyle = .overCurrentContext
//                            vc.modalTransitionStyle = .crossDissolve
//                            self.present(vc, animated: true)
//                        }
//                    }else {
//                     print("status 400")
//                      if let nestedDictionary = dictionary["message"] as? String {
//                         SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
//                      }
//                }
//              }
//            }
//         }catch let error as NSError{
//            LoadingIndicatorView.hide()
//            print(error.localizedDescription)
//            SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
//        }
//        break

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
