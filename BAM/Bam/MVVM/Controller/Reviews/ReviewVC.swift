//
//  ReviewVC.swift
//  Bam
//
//  Created by ADS N URL on 22/03/21.
//

import UIKit
import Alamofire


class ReviewVC: UIViewController {
    
    //MARK: - Variables
    var productId = 0
    var productDetailModel: ProductDetailModelData?
    var apiHelper = ApiHelper()
    var GETPRODUCTDETAIL = "-1"
    var userManager = UserManager.userManager
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeReviewBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        apiHit()
    }
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: "\(kProductDetails)\(productId)", tag: GETPRODUCTDETAIL)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reviewBtnPressed(_ sender: Any) {
        
        if userManager.getApiToken() != "" {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteReviewPopupVC") as! WriteReviewPopupVC
        vc.productId = "\(productId)"
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        self.present(vc, animated: true)
        } else {
            navigateToLogin()
        }
    }
    
}

//MARK: - UITableView Delegate and DataSource
extension ReviewVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        if productDetailModel?.review?.count == 0 {
            messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
        } else {
            messageLabel.text = ""
        }
        return productDetailModel?.review?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTVCell", for: indexPath) as! ReviewTVCell
        let data = productDetailModel?.review?[indexPath.row]
//            let imgUrl = image_base_url + data["product_image"]! //["product_image"]!
        let url = "\(data?.image ?? "")"
        cell.userIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.userIV.image = image
        }
        cell.nameLbl.text = data?.name
        cell.dateLbl.text = data?.updated_at
        if Int(data?.star ?? "") == 5 {
            cell.ratingIV5.setTitleColor(UIColor.gray, for: .normal) //= UIColor.gray
            cell.ratingIV4.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else if Int(data?.star ?? "") == 4 {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else if Int(data?.star ?? "") == 3 {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else if Int(data?.star ?? "") == 2 {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else if Int(data?.star ?? "") == 1 {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.lightGray, for: .normal)
        }
        return cell
    }
    
}


//MARK: - CUSTOM DELEGATE
extension ReviewVC: PassValueDelegate {
    func passValue(str: String) {
        apiHit()
    }
    
}



//MARk: - API Success
extension ReviewVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case GETPRODUCTDETAIL:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(ProductDetailModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                    // create session here
                        productDetailModel = response.data
                        tableView.delegate = self
                        tableView.dataSource = self
                        tableView.reloadData()
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
