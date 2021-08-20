//
//  PreviousOrderDetailVC.swift
//  Bam
//
//  Created by ADS N URL on 05/04/21.
//

import UIKit
import Alamofire


class PreviousOrderDetailVC: UIViewController {
    
    //MARK: - Variables
    var subOrderId = ""
    var orderId = ""
    var orderModel: TrackOrderModel?
    var apiHelper = ApiHelper()
    var TRACKORDER = "1"
    var INVOICEREQUEST = "2"
    var userManager = UserManager.userManager
    
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var invoiceBtn: UIButton!
    @IBOutlet weak var writeReviewBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    
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
    @IBOutlet weak var priceDetailLbl: UILabel!
    @IBOutlet weak var accessoryPriceLbl: UILabel!
    @IBOutlet weak var deliveryPriceLbl: UILabel!
    @IBOutlet weak var couponPriceLbl: UILabel!

    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var userIV: UIImageView!
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        writeReviewBtn.layer.borderWidth = 1
        writeReviewBtn.layer.borderColor = AppUsedColors.appColor.cgColor
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
    
    @IBAction func btnTap_RequestInvoice(_ sender: Any) {
        apiHelper.PostData(urlString: kInvoiceRequest, tag: INVOICEREQUEST, params: ["order_no": orderId])
    }
    
    @IBAction func btnTap_WriteReview(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteReviewPopupVC") as! WriteReviewPopupVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
}


//MARk: - API Success
extension PreviousOrderDetailVC: ApiResponseDelegate {
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
                    placedOnLbl.text = "Placed On: \(orderModel?.data?.placed_on ?? "")"
                    itemNameLbl.text = orderModel?.data?.title
                    deliveryLbl.text = orderModel?.data?.delivery_time
                    userIV.sd_setImage(with: URL(string: orderModel?.data?.image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                        self.userIV.image = image
                    }
                    priceLbl.text = "SAR \(orderModel?.data?.price ?? "0")"
                    descriptionLbl.text = orderModel?.data?.description
                    qtyLbl.text = " \(orderModel?.data?.quantity ?? 0)"
                    accessoryPriceLbl.text = "SAR \(orderModel?.data?.coupon_applied ?? 0)"
                    deliveryLbl.text = "SAR \(orderModel?.data?.delivery_charge ?? 0)"
                    couponPriceLbl.text = "-SAR \(orderModel?.data?.coupon_applied ?? 0)"
                    totalLbl.text = "SAR \(orderModel?.data?.price ?? "0")"
                    priceDetailLbl.text = "Price Details (\(orderModel?.data?.quantity ?? 0) Item)"

                    
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
