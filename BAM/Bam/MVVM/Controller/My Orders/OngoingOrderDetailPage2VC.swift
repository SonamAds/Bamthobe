//
//  OngoingOrderDetailPage2VC.swift
//  Bam
//
//  Created by ADS N URL on 05/04/21.
//

import UIKit
import Alamofire


class OngoingOrderDetailPage2VC: UIViewController {
    
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
    @IBOutlet weak var trackOrderBtn: UIButton!

    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var placedOnLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var qtyHeading: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var deliveredAddressLbl: UILabel!
   
    @IBOutlet weak var addressTagLbl: UILabel!
    @IBOutlet weak var addressDetailLbl: UILabel!
    @IBOutlet weak var customizedThodePriceLbl: UILabel!
    @IBOutlet weak var vistingPriceLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    @IBOutlet weak var couponPriceLbl: UILabel!
    @IBOutlet weak var advancePriceLbl: UILabel!
    @IBOutlet weak var remainingPriceLbl: UILabel!

    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var userIV: UIImageView!
    

    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        let productTap1 = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_ProductDetailing))
//        productView1.addGestureRecognizer(productTap1)
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
    
    
}


//MARk: - API Success
extension OngoingOrderDetailPage2VC: ApiResponseDelegate {
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
                    orderIdLbl.text = "Order ID: \(subOrderId)"//\(orderModel?.data?.id ?? 0)"
                    placedOnLbl.text = "Placed On: \(orderModel?.data?.placed_on ?? "")"
//                    deliveryLbl.text = orderModel?.data?.delivery_time
                    itemNameLbl.text = orderModel?.data?.title
                    userIV.sd_setImage(with: URL(string: orderModel?.data?.image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                        self.userIV.image = image
                    }
                    priceLbl.text = "SAR \(orderModel?.data?.price ?? "0")"
                    descriptionLbl.text = orderModel?.data?.description
                    qtyLbl.text = "\(orderModel?.data?.quantity ?? 0)"
                    customizedThodePriceLbl.text = "SAR \(orderModel?.data?.price ?? "0")"
                    deliveryLbl.text = orderModel?.data?.delivery_time ?? ""
                    deliveryPriceLbl.text = "SAR \(orderModel?.data?.delivery_charge ?? 0)"
                    couponPriceLbl.text = "-SAR \(orderModel?.data?.coupon_applied ?? 0)"
                    remainingPriceLbl.text = "SAR \(orderModel?.data?.remaining ?? "0")"
                    vistingPriceLbl.text = "SAR \(orderModel?.data?.visiting_charge ?? "0")"
                    advancePriceLbl.text = "SAR \(orderModel?.data?.advanced_payment ?? "0")"

                    
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
