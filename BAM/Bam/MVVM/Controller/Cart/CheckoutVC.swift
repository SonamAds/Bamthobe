//
//  CheckoutVC.swift
//  Bam
//
//  Created by ADS N URL on 12/04/21.
//

import UIKit
import Alamofire


class CheckoutVC: UIViewController {
    
    //MARK: - Variables
//    var loyaltyPoints = ""
    var cartModel: CartModel?
    var apiHelper = ApiHelper()
    var GETCART = "0"
    var APPLYCOUPON = "1"
    var APPLYLOYALTY = "2"
    var GETLOYALTY = "3"
    var userManager = UserManager.userManager
//    var loyaltyModel: LoyaltyModel?

    
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var itemsLbl: UILabel!
    @IBOutlet weak var loyaltyPointsLbl: UILabel!
    @IBOutlet weak var loyaltyPointsUseLbl: UILabel!
    @IBOutlet weak var TotalLoyaltyPointsLbl: UILabel!
    @IBOutlet weak var TotalLoyaltyPointsPriceLbl: UILabel!
    @IBOutlet weak var discountTF: UITextField!
    @IBOutlet weak var applyBtn: UIButton!
    
    @IBOutlet weak var thodeTotalPriceLbl: UILabel!
    @IBOutlet weak var accessoriesTotalPriceLbl: UILabel!
    @IBOutlet weak var giftCardPriceLbl: UILabel!
    @IBOutlet weak var deliveryChargePriceLbl: UILabel!
    @IBOutlet weak var couponAppliedPriceLbl: UILabel!
    @IBOutlet weak var loyaltyPointsPriceLbl: UILabel!
    @IBOutlet weak var remainingPriceLbl: UILabel!
    @IBOutlet weak var advancePriceLbl: UILabel!
    @IBOutlet weak var payablePriceLbl: UILabel!
    @IBOutlet weak var grandTotalPriceLbl: UILabel!

    @IBOutlet weak var thodeTotalSV: UIStackView!
    @IBOutlet weak var accessoriesTotalSV: UIStackView!
    @IBOutlet weak var giftCardSV: UIStackView!
    @IBOutlet weak var couponSV: UIStackView!
    @IBOutlet weak var remainingSV: UIStackView!
    @IBOutlet weak var advanceSV: UIStackView!
    @IBOutlet weak var deliveryChargeSV: UIStackView!
    
    @IBOutlet weak var loyaltySwitch: UISwitch!

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nextCustomizeSV: UIStackView!
    @IBOutlet weak var nextCustomizeLbl: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nextCustomizeBtn: UIButton!
    
    @IBOutlet weak var btn_Checkout: UIButton!

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        apiHelper.responseDelegate = self
        nextCustomizeLbl.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Place Order", comment: ""), for: .normal)
        loyaltyPointsUseLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Loyalty Points (100 Points = SAR 10)", comment: "")
        loyaltyPointsLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Loyalty Points", comment: "")
        TotalLoyaltyPointsLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Total Points", comment: "") + " : "

        priceLbl.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loyaltyPointsApiHit()
        apiHit()
    }
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.GetData(urlString: kGetCart, tag: GETCART)
    }
    
    func couponApiHit() {
        apiHelper.PostData(urlString: kApplyCoupon, tag: APPLYCOUPON, params: ["coupon_id": discountTF.text ?? ""])
    }
    
    func loyaltyApiHit() {
        apiHelper.GetData(urlString: kLoyaltyApply, tag: APPLYLOYALTY)//, params: ["": loyaltySwitch.isOn == true ? 1 : 0])
    }
    
    func loyaltyPointsApiHit() {
        apiHelper.GetData(urlString: kGetLoyaltyPoints, tag: GETLOYALTY)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnTap_NextCustomize(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlaceOrderVC") as! PlaceOrderVC
        vc.total = "\(cartModel?.data?.payable_amount ?? "0")"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_Apply(_ sender: UIButton) {
        if discountTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "You don't have enough loyality points!", comment: ""), interval: 4)
        } else {
            couponApiHit()
        }
    }
    
    @IBAction func switchChanged_Value(_ sender: UISwitch) {
        if loyaltySwitch.isOn {
            if TotalLoyaltyPointsLbl.text == "" || TotalLoyaltyPointsLbl.text == "SAR 0.00" || TotalLoyaltyPointsLbl.text == "SAR 0"  {
                loyaltySwitch.setOn(false, animated: true)
                SnackBar().showSnackBar(view: self.view, text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "You don't have enough loyality points!", comment: ""), interval: 4)
            } else {
                loyaltySwitch.setOn(true, animated: true)
                loyaltyApiHit()
            }
        } else {
            apiHit()
        }
    }
    
}



//MARk: - API Success
extension CheckoutVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        
        switch tag {
            case GETCART:
                do{
                    print(responseData)
                    cartModel = try jsonDecoder.decode(CartModel.self, from: responseData.data!)
                    if cartModel?.status == true/*200*/{
                    // create session here
                        itemsLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Items", comment: "") + " (\(cartModel?.data?.total_quantity ?? 0))"
//                        loyaltyPointsLbl.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "Loyalty Points", comment: "") //+ "(www)"
                        loyaltyPointsPriceLbl.text = "SAR \(cartModel?.data?.loyality_point ?? 0)"
                        thodeTotalPriceLbl.text = "SAR \(cartModel?.data?.thobe_total ?? 0)"
                        accessoriesTotalPriceLbl.text = "SAR \(cartModel?.data?.accessories_total ?? 0)"
                        giftCardPriceLbl.text = "SAR \(cartModel?.data?.gift_card_amount ?? 0)"
                        deliveryChargePriceLbl.text = "SAR  \(cartModel?.data?.delivery_charge ?? 0)"
                        couponAppliedPriceLbl.text = "-SAR " + "\(cartModel?.data?.coupon_applied ?? 0)"
                        grandTotalPriceLbl.text = "SAR  \(cartModel?.data?.grand_total ?? "")"
                        priceLbl.text = "SAR \(cartModel?.data?.grand_total ?? "")"
                        loyaltyPointsPriceLbl.text = "SAR \(cartModel?.data?.loyality_point ?? 0)"
                        remainingPriceLbl.text = "SAR \(cartModel?.data?.remaining ?? "0")"
                        advancePriceLbl.text = "SAR \(cartModel?.data?.advance_payment ?? "0")"
                        payablePriceLbl.text = "SAR \(cartModel?.data?.payable_amount ?? "0")"
                        
                        if UserDefaults.standard.string(forKey: "lang") == "ar" {
//                            priceLbl.textAlignment = .left
                            nextCustomizeLbl.titleLabel?.textAlignment = .left
                            loyaltyPointsLbl.textAlignment = .right
//                            thodeTotalPriceLbl.textAlignment = .left
//                            accessoriesTotalPriceLbl.textAlignment = .left
//                            giftCardPriceLbl.textAlignment = .left
//                            deliveryChargePriceLbl.textAlignment = .left
//                            couponAppliedPriceLbl.textAlignment = .left
//                            grandTotalPriceLbl.textAlignment = .left
//                            loyaltyPointsPriceLbl.textAlignment = .left
                        } else {
//                            priceLbl.textAlignment = .right
                            nextCustomizeLbl.contentHorizontalAlignment = .right
                            loyaltyPointsLbl.textAlignment = .left
//                            thodeTotalPriceLbl.textAlignment = .right
//                            accessoriesTotalPriceLbl.textAlignment = .right
//                            giftCardPriceLbl.textAlignment = .right
//                            deliveryChargePriceLbl.textAlignment = .right
//                            couponAppliedPriceLbl.textAlignment = .right
//                            grandTotalPriceLbl.textAlignment = .right
//                            loyaltyPointsPriceLbl.textAlignment = .right
                        }

                        LoadingIndicatorView.hide()
                    } else if cartModel?.status == false {
                        LoadingIndicatorView.hide()
                        SnackBar().showSnackBar(view: self.view, text: "\(cartModel?.message ?? "")", interval: 4)
                    }
                }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
            
            case APPLYCOUPON:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(LoginModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                    // create session here
                        apiHit()
                        SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
                    } else if response.status == false {
                        LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
                    }
//                    LoadingIndicatorView.hide()
                }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
            case APPLYLOYALTY:
                do{
                    print(responseData)
                    let resultJson = try JSONSerialization.jsonObject(with: responseData.data!, options: []) as? [String:AnyObject]
                    print("resultJson", resultJson)
                    if let dictionary = resultJson as? [String: Any] {
                     print("dictionary", dictionary)
                        if let status = dictionary["status"] as? Bool {
                         print("status", status)
                            if status == true {
                                apiHit()
                                if let nestedDictionary = dictionary["message"] as? String {
                                 SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
                                }
                            }else {
                             print("status 400")
                              if let nestedDictionary = dictionary["message"] as? String {
                                 SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
                              }
                            }
                        }
                    }
//                    LoadingIndicatorView.hide()
                }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
                
            case GETLOYALTY:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(LoyaltyModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                        TotalLoyaltyPointsPriceLbl.text = "SAR \(response.data?.total_points ?? 0)"
                        
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

