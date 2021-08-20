//
//  SenderGiftDetailV.swift
//  Bam
//
//  Created by ADS N URL on 09/05/21.
//

import UIKit
import  Alamofire
import SwiftyJSON


class SenderGiftDetailVC: UIViewController {

    //MARK: - Variables
    var pushDict: OrderModelData?
    var apiHelper = ApiHelper()
    var GIFTDETAIL = "0"
    var INVOICEREQUEST = "1"
    var userManager = UserManager.userManager
    let localDateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.dateStyle = .medium
        result.timeStyle = .none
        return result
    }()
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var GiftIV:UIImageView!
    @IBOutlet weak var giftDescriptionLbl:UILabel!
    @IBOutlet weak var OrderIdLbl:UILabel!
    @IBOutlet weak var placedOnLbl:UILabel!
    @IBOutlet weak var toLbl:UILabel!
    @IBOutlet weak var fromLbl:UILabel!
    @IBOutlet weak var messagelbl:UILabel!
    @IBOutlet weak var linkLbl:UILabel!
    @IBOutlet weak var recipentNameLbl:UILabel!
    @IBOutlet weak var recipentPhoneLbl:UILabel!
    @IBOutlet weak var dateAndTimeLbl:UILabel!
    @IBOutlet weak var priceDetailsLbl:UILabel!
    @IBOutlet weak var giftCardPriceLbl:UILabel!
    @IBOutlet weak var grandTotalLbl:UILabel!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var requestInvoiceBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        nameView.layer.borderWidth = 1
//        nameView.layer.borderColor = UIColor.lightGray.cgColor
//        mobileView.layer.borderWidth = 1
//        mobileView.layer.borderColor = UIColor.lightGray.cgColor
//        shareFeelingTF.layer.borderWidth = 1
//        shareFeelingTF.layer.borderColor = UIColor.lightGray.cgColor
//        messageView.layer.borderWidth = 1
//        messageView.layer.borderColor = UIColor.lightGray.cgColor
//        addAddressBtn.layer.borderWidth = 1
//        addAddressBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        OrderIdLbl.text = "Order ID: \(pushDict?.sub_order_id ?? "")"//\(orderModel?.data?.id ?? 0)"
//        placedOnLbl.text = "Placed On: \(pushDict?.up ?? "")"
        
        GiftIV.sd_setImage(with: URL(string: pushDict?.image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            self.GiftIV.image = image
        }
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
    }

    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: "\(kGiftOrderDetail)\(pushDict?.sub_order_id ?? "")", tag: GIFTDETAIL)
    }
    
    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_RequestInvoice(_ sender: UIButton) {
        apiHelper.PostData(urlString: kInvoiceRequest, tag: INVOICEREQUEST, params: ["order_no": pushDict?.order_id ?? ""])
    }
    
}


//MARk: - API Success
extension SenderGiftDetailVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
//    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GIFTDETAIL:
//            do{
                let resultJson = try? JSONSerialization.jsonObject(with: responseData.data!, options: []) as? [String:AnyObject]
                print("resultJson", resultJson)
//            let json_value = resultJson as? JSON
//                if let dictionary = resultJson as? [String: String] {
//                 print("dictionary", dictionary)
                    if let status = resultJson?["status"] as? Bool {
                     print("status", status)
                        if status == true {
                            let data = resultJson?["data"]
                            placedOnLbl.text = "Placed On: \(data?["updated_at"] as? String ?? "")"
                            toLbl.text = data?["g_to"] as? String
                            fromLbl.text = data?["g_from"] as? String
                            messagelbl.text = data?["message"] as? String
                            linkLbl.text = "www.test.com"//dictionary["image"]
                            recipentNameLbl.text = data?["receiver_name"] as? String
                            recipentPhoneLbl.text = data?["mobile"] as? String
                            dateAndTimeLbl.text = "\(data?["date"] as? String ?? "") \(data?["time"] as? String ?? "")"
                            priceDetailsLbl.text = "Price Details (1 Item)"
                            giftCardPriceLbl.text = "SAR \(data?["gift_cart_amount"] as? String ?? "")"
                            grandTotalLbl.text = "SAR \(data?["gift_cart_amount"] as? String ?? "")"
//                            OrderIdLbl.text = "SAR \(dictionary["gift_cart_amount"])"
                        }else {
                         print("status 400")
                            if let nestedDictionary = resultJson?["message"] as? String {
                             SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
                          }
                        }
                    }
//                }
            break
            
        case INVOICEREQUEST:
            do{
                let resultJson = try? JSONSerialization.jsonObject(with: responseData.data!, options: []) as? [String:AnyObject]
                print("resultJson", resultJson)
                if let dictionary = resultJson as? [String: Any] {
                    print("dictionary", dictionary)
                    if let status = dictionary["status"] as? Bool {
                        print("status", status)
                        if status == true {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "AlertWithoutClickVC") as! AlertWithoutClickVC
                            vc.selectedPop = "Invoice"
                            vc.modalPresentationStyle = .overCurrentContext
                            vc.modalTransitionStyle = .crossDissolve
                            self.present(vc, animated: true)
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

