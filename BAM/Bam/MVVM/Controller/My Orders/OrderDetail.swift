//
//  OngoingOrderDetailVC.swift
//  Bam
//
//  Created by ADS N URL on 05/04/21.
//

import UIKit
import Alamofire


class OngoingOrderDetailVC: UIViewController {
    
    //MARK: - Variables
    var subOrderId = ""
    var type = ""
    var orderModel: TrackOrderModel?
    var apiHelper = ApiHelper()
    var TRACKORDER = "1"
    var userManager = UserManager.userManager
    
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var detailBtn2: UIButton!
    @IBOutlet weak var trackBtn: UIButton!

    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var placedOnLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var qtyHeading: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var itemNameLbl2: UILabel!
    @IBOutlet weak var qtyLbl2: UILabel!
    @IBOutlet weak var qtyHeading2: UILabel!
    @IBOutlet weak var descriptionLbl2: UILabel!
    @IBOutlet weak var priceLbl2: UILabel!
    
    @IBOutlet weak var priceDetailLbl: UILabel!
    @IBOutlet weak var accessoryPriceLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    @IBOutlet weak var couponPriceLbl: UILabel!
    @IBOutlet weak var customizedThodePriceLbl: UILabel!
    @IBOutlet weak var giftCardPriceLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var userIV2: UIImageView!
    @IBOutlet weak var productView1: UIView!
    @IBOutlet weak var productView2: UIView!
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var giftPriceLbl: UILabel!
    @IBOutlet weak var giftDescriptionLbl: UILabel!
    @IBOutlet weak var giftIV: UIImageView!


    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let productTap1 = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_ProductDetailing))
        productView1.addGestureRecognizer(productTap1)
        let productTap2 = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_ProductDetailing))
        productView2.addGestureRecognizer(productTap2)
        let giftTap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_Gift))
        giftView.addGestureRecognizer(giftTap)
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
    }
    
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.GetData(urlString: "\(kTrackOrder)\(subOrderId)", tag: TRACKORDER)
    }
    
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_viewDetail(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OngoingOrderDetailPage2VC") as! OngoingOrderDetailPage2VC
        self.navigationController?.pushViewController(vc, animated: true)

    }
   
    @IBAction func btnTap_TrackOrder(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TrackOrderVC") as! TrackOrderVC
        vc.orderModel = orderModel
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func gestureTap_Gift() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SenderGiftDetailVC") as! SenderGiftDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func gestureTap_ProductDetailing() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OngoingOrderDetailPage2VC") as! OngoingOrderDetailPage2VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARk: - API Success
extension OngoingOrderDetailVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case TRACKORDER:
            do{
                print(responseData)
                orderModel = try jsonDecoder.decode(TrackOrderModel.self, from: responseData.data!)
                if orderModel?.status == true/*200*/{
                    // create session here
                    orderIdLbl.text = "Order ID: \(orderModel?.data?.id ?? 0)"
                    placedOnLbl.text = "Placed On: \(orderModel?.data?.placed_on ?? "")"
                    deliveryLbl.text = orderModel?.data?.delivery_time
                    qtyHeading.text = orderModel?.data?.title
                    userIV.sd_setImage(with: URL(string: orderModel?.data?.image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                        self.userIV.image = image
                    }
                    priceLbl.text = "SAR \(orderModel?.data?.price ?? "0")"
                    descriptionLbl.text = orderModel?.data?.description
                    qtyLbl.text = "Qty: \(orderModel?.data?.quantity ?? 0)"
                    customizedThodePriceLbl.text = "SAR \(orderModel?.data?.price ?? "0")"
                    deliveryPriceLbl.text = "SAR \(orderModel?.data?.delivery_charge ?? 0)"
                    couponPriceLbl.text = "SAR \(orderModel?.data?.coupon_applied ?? 0)"
//                    remPriceLbl.text = "SAR \(orderModel?.data?.price ?? "")"
//                    advance.text = "SAR \(orderModel?.data?.price ?? "")"
                    priceLbl.text = "SAR \(orderModel?.data?.price ?? "0")"

                    
                    productView2.isHidden = true
                } else if orderModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(orderModel?.message ?? "")", interval: 4)
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
