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
    @IBOutlet weak var loyaltyPointsSlider: UISwitch!
    @IBOutlet weak var discountTF: UITextField!
    @IBOutlet weak var applyBtn: UIButton!
    
    @IBOutlet weak var thodeTotalPriceLbl: UILabel!
    @IBOutlet weak var accessoriesTotalPriceLbl: UILabel!
    @IBOutlet weak var giftCardPriceLbl: UILabel!
    @IBOutlet weak var deliveryChargePriceLbl: UILabel!
    @IBOutlet weak var couponAppliedPriceLbl: UILabel!
    @IBOutlet weak var loyaltyPointsPriceLbl: UILabel!
    @IBOutlet weak var grandTotalPriceLbl: UILabel!
   
    @IBOutlet weak var TotalLoyaltyPointsLbl: UILabel!

    @IBOutlet weak var thodeTotalSV: UIStackView!
    @IBOutlet weak var accessoriesTotalSV: UIStackView!
    @IBOutlet weak var giftCardSV: UIStackView!
    @IBOutlet weak var couponSV: UIStackView!
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
        vc.total = "\(cartModel?.data?.grand_total ?? "")"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_Apply(_ sender: UIButton) {
        if discountTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Coupon Code is Empty", interval: 4)
        } else {
            couponApiHit()
        }
    }
    
    @IBAction func switchChanged_Value(_ sender: UISwitch) {
        if loyaltySwitch.isOn {
            if TotalLoyaltyPointsLbl.text == "" || TotalLoyaltyPointsLbl.text == "SAR 0.00" || TotalLoyaltyPointsLbl.text == "SAR 0"  {
                loyaltySwitch.setOn(false, animated: true)
                SnackBar().showSnackBar(view: self.view, text: "You don't have enough loyality points!", interval: 4)
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
                        itemsLbl.text = "Items (\(cartModel?.data?.total_quantity ?? 0))"
                        thodeTotalPriceLbl.text = "SAR \(cartModel?.data?.thobe_total ?? 0)"
                        accessoriesTotalPriceLbl.text = "SAR \(cartModel?.data?.accessories_total ?? 0)"
                        giftCardPriceLbl.text = "SAR \(cartModel?.data?.gift_card_amount ?? 0)"
                        deliveryChargePriceLbl.text = "SAR  \(cartModel?.data?.delivery_charge ?? 0)"
                        couponAppliedPriceLbl.text = "-SAR " + "\(cartModel?.data?.coupon_applied ?? 0)"
                        grandTotalPriceLbl.text = "SAR  \(cartModel?.data?.grand_total ?? "")"
                        priceLbl.text = "SAR \(cartModel?.data?.grand_total ?? "")"
                        loyaltyPointsPriceLbl.text = "SAR \(cartModel?.data?.loyality_point ?? 0)"
//                        if cartModel?.data?.thobe_total != 0 {//} || cartModel?.data?.thobe_total != "0" {
//                            thodeTotalSV.isHidden = false
//                        } else {
//                            thodeTotalSV.isHidden = true
//                        }
//                        if cartModel?.data?.accessories_total != 0 {//} || cartModel?.data?.accessories_total != "0" {
//                            accessoriesTotalSV.isHidden = false
//                        } else {
//                            accessoriesTotalSV.isHidden = true
//                        }
//                        if cartModel?.data?.gift_card_amount != 0 {//} || cartModel?.data?.gift_card_amount != "0" {
//                            giftCardSV.isHidden = false
//                        } else {
//                            giftCardSV.isHidden = true
//                        }
//                        if cartModel?.data?.delivery_charge != 0 {//} || cartModel?.data?.delivery_charge != "0" {
//                            deliveryChargeSV.isHidden = false
//                        } else {
//                            deliveryChargeSV.isHidden = true
//                        }
//                        if cartModel?.data?.coupon_applied != 0{//} || cartModel?.data?.coupon_applied != "0" {
//                            couponSV.isHidden = false
//                        } else {
//                            couponSV.isHidden = true
//                        }
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
                        TotalLoyaltyPointsLbl.text = "\(response.data?.total_points ?? 0)"
                    
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




//MARK: - UITableView Delegate and DataSource
//extension CheckoutVC: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return cartModel?.data?.normal?.count ?? 0
//        } else if section == 2 {
//            return cartModel?.data?.gift_cart?.count ?? 0
//        } else {
//            return cartModel?.data?.customize?.count ?? 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVCell", for: indexPath) as! CartTVCell
//        cell.giftDeleteBtn.tag = indexPath.row + 1
//        cell.thodeDeleteBtn.tag = indexPath.row + 1
//        cell.giftPriceLbl.tag = indexPath.section
//        cell.thodeLbl.tag = indexPath.section
////        cell.deleteDelegate = self
//        if indexPath.section == 0 {
//            let data = cartModel?.data?.normal?[indexPath.row]
//            cell.thodeLbl.text = data?.title
//            cell.thodeDescriptionLbl.text = data?.description
//            cell.thodeQtyLbl.text = data?.quantity
//            let cost = String(data!.total_cost!)
//            cell.thodePriceLbl.text = "SAR \(cost)"
//            let url = (data?.image ?? "")
//            cell.thodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
//                cell.thodeIV.image = image
//            }
//            cell.giftView.isHidden = true
//            cell.priceView.isHidden = true
//            cell.thodeView.isHidden = false
//            cell.lessDetailHeightConstraint.constant = 0
//        } else if indexPath.section == 2 {
//            let data = cartModel?.data?.gift_cart?[indexPath.row]
////            cell.giftLbl.text = data?.title
////            cell.giftQtyLbl.text = "1"//data?.
//            cell.giftDescriptionLbl.text = data?.description
//            cell.giftPriceLbl.text = "SAR " + "\(data?.price ?? 0)"
//            let url = (data?.image ?? "")
//            cell.giftIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
//                cell.giftIV.image = image
//            }
//            cell.giftView.isHidden = false
//            cell.priceView.isHidden = true
//            cell.thodeView.isHidden = true
//            cell.lessDetailHeightConstraint.constant = 0
//        } else {
//            let data = cartModel?.data?.customize?[indexPath.row]
//            let url = (data?.image ?? "")
//            cell.thodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
//                cell.thodeIV.image = image?.withRenderingMode(.alwaysTemplate)
//                cell.thodeIV.tintColor = hexStringToUIColor(hex: data?.view_more?.color_code ?? "")
//
//            }
//
//            cell.thodeLbl.text = data?.title
//            cell.thodeDescriptionLbl.text = data?.description
//            cell.thodeQtyLbl.text = "\(data?.quantity ?? 0)"
//            let cost = String((data?.quantity ?? 0) * (data?.price ?? 0))
//            cell.thodePriceLbl.text = "SAR \(cost)"
//            cell.customizedPriceLbl.text = "SAR \(data?.view_more?.Customization_charge ?? 0)"
//            cell.visitingChargePriceLbl.text = "SAR \(data?.view_more?.visiting_charge ?? 0)"
//            cell.advancePriceLbl.text = "SAR \(data?.view_more?.advanced_payment ?? 0)"
//            cell.remPriceLbl.text = "SAR \(data?.view_more?.remaining ?? 0)"
//            cell.subTotalPriceLbl.text = "SAR \(cost)"//"\(data?.view_more?.thodePriceLbl ?? 0)"
//
//            cell.giftView.isHidden = true
//            cell.thodeView.isHidden = false
//            cell.lessDetailHeightConstraint.constant = 25
//        }
//        return cell
//    }
//
//}
