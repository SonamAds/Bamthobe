//
//  GiftListViewVC.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit
import Alamofire


class GiftListViewVC: UIViewController {

    //MARK: - Variables
    var giftId = 0
    var giftModel: GiftDescriptionModel?
    var apiHelper = ApiHelper()
    var GETGIFT = "-1"
    var userManager = UserManager.userManager
    
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var GiftIV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var createGiftBtn: UIButton!
    @IBOutlet weak var priceHeadingLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!

    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        apiHelper.responseDelegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
    }
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: "\(kGiftDescription)\(giftId)", tag: GETGIFT)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_CreateGift(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateGiftVC") as! CreateGiftVC
        vc.giftId = giftId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARk: - API Success
extension GiftListViewVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GETGIFT:
            do{
                print(responseData)
                giftModel = try jsonDecoder.decode(GiftDescriptionModel.self, from: responseData.data!)
                if giftModel?.status == true/*200*/{
            // create session here
                    let url = (giftModel?.data?.image ?? "")
                    GiftIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                        self.GiftIV.image = image
                    }
                    GiftIV.contentMode = .scaleAspectFit
                    titleLbl.text = giftModel?.data?.title
                    descriptionLbl.text = giftModel?.data?.description
                    priceLbl.text = "SAR " + "\(giftModel?.data?.price ?? "0")"
                } else if giftModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(giftModel?.message ?? "")", interval: 4)
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
