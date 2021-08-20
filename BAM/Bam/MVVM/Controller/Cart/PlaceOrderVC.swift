//
//  PlaceOrderVC.swift
//  Bam
//
//  Created by ADS N URL on 12/04/21.
//

import UIKit
import Alamofire


class PlaceOrderVC: UIViewController {
    
    //MARK: - Variables
    var apiHelper = ApiHelper()
    var addressModel: AddressModel?
    var ORDER = "0"
    var GETADDRESS = "1"
    var userManager = UserManager.userManager

    var addressId = 0
    var total = ""
    var deliverySelected = ""
    var paymentSelected = ""
    var deliveryType = ""
    var paymentType = false
    
    var attrs = [
        NSAttributedString.Key.font : UIFont(name: "Helvetica-Medium", size: 15.0),/*UIFont.systemFont(ofSize: 17.0)*/
        NSAttributedString.Key.foregroundColor : UIColor.darkGray,
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
    var attributedString = NSMutableAttributedString(string:"")
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeTickIV: UIImageView!
    @IBOutlet weak var homeTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var homeLbl: UILabel!
    
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var storeTickIV: UIImageView!
    @IBOutlet weak var storeTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var storeLbl: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nextCustomizeSV: UIStackView!
    @IBOutlet weak var nextCustomizeLbl: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nextCustomizeBtn: UIButton!
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLbl.text = "SAR \(total)"
        homeTickIV.isHidden = true
        apiHelper.responseDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        addressApiHit()
    }
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.PostData(urlString: kPaymentConfirmatn, tag: ORDER, params: ["address_id": "\(addressId)", "grand_total": total])
    }
    
    func addressApiHit() {
        apiHelper.GetData(urlString: KGetAddress, tag: GETADDRESS)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnTap_NextCustomize(_ sender: UIButton) {
        if deliveryType == "Store Pickup" && paymentSelected == "Credit Card/ Debit Card" {
            apiHit()
        } else if deliveryType == "Home Delivery" && deliverySelected != "" && paymentSelected == "Credit Card/ Debit Card" {
            apiHit()
        } else {
            SnackBar().showSnackBar(view: self.view, text: "Select Delivery type", interval: 4)
        }
    }
    
    @IBAction func gestureTap_HomeDelivery(_ sender: UITapGestureRecognizer) {
        if deliveryType == "Store Pickup" || deliveryType == "" {//"Home Delivery" {
            deliveryType = "Home Delivery"
            homeTickIV.isHidden = false
            storeTickIV.isHidden = true
        } else {
            deliveryType = ""
            homeTickIV.isHidden = true
            storeTickIV.isHidden = true
        }
        deliverySelected = ""
        paymentSelected = ""
        tableView.reloadData()
    }
    
    @IBAction func gestureTap_StorePickup(_ sender: UITapGestureRecognizer) {
        if deliveryType == "Home Delivery" || deliveryType == "" {//"Home Delivery" {
            deliveryType = "Store Pickup"
            homeTickIV.isHidden = true
            storeTickIV.isHidden = false
        } else {
            deliveryType = ""
            homeTickIV.isHidden = true
            storeTickIV.isHidden = true
        }
        deliverySelected = ""
        paymentSelected = ""
        tableView.reloadData()
    }
    
}

//MARK: - UITableView Delegate and DataSource
extension PlaceOrderVC: UITableViewDelegate, UITableViewDataSource {
//    "Home Delivery" || deliveryType == "" {//"Home Delivery" {
//        deliveryType = "Store Pickup"
    func numberOfSections(in tableView: UITableView) -> Int {
        if deliveryType == "Home Delivery" {
            if deliverySelected != "" {
                return 2
            }
            return 1
        } else if deliveryType == "Store Pickup" {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if deliveryType == "Home Delivery" {
            if deliverySelected != "" {
                if section == 1 {
                    return 1
                }
                return addressModel?.data?.count ?? 0
            } else {
                return addressModel?.data?.count ?? 0
            }
            
        } else if deliveryType == "Store Pickup" {
            return 1
        }
        
        return 0//notificationDict["data"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if deliveryType == "Home Delivery" {
            if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SavedMeasurementTVCell", for: indexPath) as! SavedMeasurementTVCell
                cell.nameLbl.text = "Credit Card/ Debit Card"
                if paymentSelected == cell.nameLbl.text {
                    cell.tickIV.isHidden = false
                } else {
                    cell.tickIV.isHidden = true
                }
                return cell
            } else {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookTVCell", for: indexPath) as! AddressBookTVCell
                cell.headingLbl.text = addressModel?.data?[indexPath.row].home_type
                cell.descriptionLbl.text = addressModel?.data?[indexPath.row].address
                if deliverySelected == "\(addressModel?.data?[indexPath.row].id ?? 0)" {
                    cell.tickIV.isHidden = false
                    addressId = addressModel?.data?[indexPath.row].id ?? 0
                } else {
                    cell.tickIV.isHidden = true
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SavedMeasurementTVCell", for: indexPath) as! SavedMeasurementTVCell
            cell.nameLbl.text = "Credit Card/ Debit Card"
            if paymentSelected == cell.nameLbl.text {
                cell.tickIV.isHidden = false
            } else {
                cell.tickIV.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! SavedMeasurementTVCell
        if deliveryType == "Home Delivery" {
            if indexPath.section == 0 {
                if deliverySelected == "\(addressModel?.data?[indexPath.row].id ?? 0)" {
                    deliverySelected = ""
                    paymentSelected = ""
                    priceLbl.textAlignment = .center
                    nextCustomizeSV.isHidden = true
                } else {
                    priceLbl.textAlignment = .center
                    nextCustomizeSV.isHidden = true
                    deliverySelected = "\(addressModel?.data?[indexPath.row].id ?? 0)"
                }
            } else {
                if paymentSelected == "Credit Card/ Debit Card" {
                    paymentSelected = ""
                    priceLbl.textAlignment = .center
                    nextCustomizeSV.isHidden = true
                } else {
                    paymentSelected = "Credit Card/ Debit Card"
                    priceLbl.textAlignment = .left
                    nextCustomizeSV.isHidden = false
                }
            }
            
        } else {
            if paymentSelected == "Credit Card/ Debit Card" {
                paymentSelected = ""
                priceLbl.textAlignment = .center
                nextCustomizeSV.isHidden = true
            } else {
                paymentSelected = "Credit Card/ Debit Card"
                priceLbl.textAlignment = .left
                nextCustomizeSV.isHidden = false
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deliveryType == "Home Delivery" {
        if indexPath.section == 1 {
            return 85
        }
        } else if deliveryType == "Store Pickup" {
            return 85
        }
        return UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
        let returnedView = UIView(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 40)) //set these values as necessary
        returnedView.backgroundColor = .white

        let label = UILabel(frame: CGRect(x: 10, y: 5, width: UIScreen.main.bounds.width - 85, height: 30))
        let addButton = UIButton(frame: CGRect(x: label.frame.origin.x + label.frame.size.width + 5, y: 5, width: 65, height: 30))
        let buttonTitleStr = NSMutableAttributedString(string:"+ Add New", attributes:attrs)
        attributedString.append(buttonTitleStr)
        addButton.setAttributedTitle(attributedString, for: .normal)
        if deliveryType == "Store Pickup" {
            label.text = "Payment"
        } else {
        if section == 1 {
            label.text = "Payment"
        } else {
            label.text = "Saved Address"
        }
        }
        label.font = UIFont.boldSystemFont(ofSize: 15)//UIFont(name: "", size: 16)
//        label.text = self.sectionArray[section]//sectionHeaderTitleArray[section]
        returnedView.addSubview(label)

        return returnedView
    }
}


//MARk: - API Success
extension PlaceOrderVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case GETADDRESS:
                do{
                    print(responseData)
                    addressModel = try jsonDecoder.decode(AddressModel.self, from: responseData.data!)
                    if addressModel?.status == true/*200*/{
                        // create session here
                        tableView.reloadData()
                    } else if addressModel?.status == false {
                        LoadingIndicatorView.hide()
                        SnackBar().showSnackBar(view: self.view, text: "\(addressModel?.message ?? "")", interval: 4)
                    }
                }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
            case ORDER:
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
                                    let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentConfirmationVC") as! PaymentConfirmationVC
                                    vc.selectedView = 0
                                    self.navigationController?.pushViewController(vc, animated: true)
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
