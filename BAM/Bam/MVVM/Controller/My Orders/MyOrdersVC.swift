//
//  MyOrdersVC.swift
//  Bam
//
//  Created by ADS N URL on 23/03/21.
//

import UIKit
import Alamofire


class MyOrdersVC: UIViewController {
    
    //MARK: - Variables
    var selected = 0
    var orderModel: OrderModel?
    var previousModel: OrderModel?
    var apiHelper = ApiHelper()
    var GETORDER = "0"
    var PREVIOUSORDER = "1"
    var userManager = UserManager.userManager
    
   
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var ongoingLbl: UILabel!
    @IBOutlet weak var ongoingLine: UILabel!
    @IBOutlet weak var previousLbl: UILabel!
    @IBOutlet weak var previousLine: UILabel!
    

    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selected = 0
        let ongoingTap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_OngoingOrder))
        ongoingLbl.addGestureRecognizer(ongoingTap)
        
        let previousTap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_PreviousOrder))
        previousLbl.addGestureRecognizer(previousTap)
        apiHelper.responseDelegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        apiHit()
    }

    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: kGetOrder, tag: GETORDER)
    }
    
    func previousApi() {
        apiHelper.GetData(urlString: kGetPreviousOrder , tag: PREVIOUSORDER)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func gestureTap_OngoingOrder(_ sender: UITapGestureRecognizer) {
        ongoingLbl.textColor = AppUsedColors.appColor
        ongoingLbl.backgroundColor = UIColor.clear
        ongoingLine.isHidden = false
        selected = 0
        previousLbl.textColor = UIColor.black
        previousLbl.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        previousLine.isHidden = true
        apiHit()
    }
    
    @objc func gestureTap_PreviousOrder(_ sender: UITapGestureRecognizer) {
        previousLbl.textColor = AppUsedColors.appColor
        previousLbl.backgroundColor = UIColor.clear
        previousLine.isHidden = false
        selected = 1
        ongoingLbl.textColor = UIColor.black
        ongoingLbl.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        ongoingLine.isHidden = true
        previousApi()
    }
    
}


//MARK: - UITableView Delegate and DataSource
extension MyOrdersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        
        if selected == 0 {
            if orderModel?.data?.count == 0 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")            } else {
                messageLabel.text = ""
            }
            return orderModel?.data?.count ?? 0
        } else {
            if previousModel?.data?.count == 0 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
                
            } else {
                messageLabel.text = ""
            }
            return previousModel?.data?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTVCell", for: indexPath) as! MyOrderTVCell
        customShadowView(vew: cell.View_Cell, shadowSize: 0.0, shadowOpacity: 0.0)

        if selected == 0 {
            let data = orderModel?.data?[indexPath.row]
            cell.userIV.sd_setImage(with: URL(string: data?.image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.userIV.image = image
            }
            cell.descriptionLbl.text = data?.description
            cell.orderIdLbl.setTitle("\(data?.order_id ?? 0)", for: .normal)
            cell.priceLbl.text = "SAR \(data?.price ?? "0")"
            cell.totalItemLbl.text = "\(data?.quantity ?? 0)"
        } else {
            let data = previousModel?.data?[indexPath.row]
            cell.userIV.sd_setImage(with: URL(string: data?.image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.userIV.image = image
            }
            cell.descriptionLbl.text = data?.description
            cell.orderIdLbl.setTitle("\(data?.order_id ?? 0)", for: .normal)
            cell.priceLbl.text = "SAR \(data?.price ?? "0")"
            cell.totalItemLbl.text = "\(data?.quantity ?? 0)"
        }
        getLang(label: [cell.descriptionLbl, cell.priceLbl], btn: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selected == 0 {
            if orderModel?.data?[indexPath.row].type == "gift_cart" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "SenderGiftDetailVC") as! SenderGiftDetailVC
//                vc.subOrderId = orderModel?.data?[indexPath.row].sub_order_id ?? ""
                vc.pushDict = orderModel?.data?[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "OngoingOrderDetailPage2VC") as! OngoingOrderDetailPage2VC
            vc.subOrderId = orderModel?.data?[indexPath.row].sub_order_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if previousModel?.data?[indexPath.row].type == "gift_cart" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "SenderGiftDetailVC") as! SenderGiftDetailVC
//                vc.subOrderId = previousModel?.data?[indexPath.row].sub_order_id ?? ""
                vc.pushDict = previousModel?.data?[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PreviousOrderDetailVC") as! PreviousOrderDetailVC
            vc.subOrderId = previousModel?.data?[indexPath.row].sub_order_id ?? ""
            vc.orderId = "\(previousModel?.data?[indexPath.row].order_id ?? 0)"

            self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}


//MARk: - API Success
extension MyOrdersVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GETORDER:
            do{
                
                orderModel = try jsonDecoder.decode(OrderModel.self, from: responseData.data!)
                print(orderModel)
                if orderModel?.status == true/*200*/{
                    // create session here
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
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
        case PREVIOUSORDER:
            do{
                print(responseData)
                previousModel = try jsonDecoder.decode(OrderModel.self, from: responseData.data!)
                if previousModel?.status == true/*200*/{
                // create session here
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                } else if previousModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(previousModel?.message ?? "")", interval: 4)
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
