//
//  LoyaltyPointsVC.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit
import Alamofire


class LoyaltyPointsVC: UIViewController {

    //MARK: - Variables
    var loyaltyModel: LoyaltyModel?
    var apiHelper = ApiHelper()
    var GETLOYALTY = "0"
    var userManager = UserManager.userManager
    
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLbl: UILabel!
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
        apiHelper.GetData(urlString: kGetLoyaltyPoints, tag: GETLOYALTY)
    }
      
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UITableView Delegate and DataSource
extension LoyaltyPointsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        if loyaltyModel?.data?.list?.count == 0 {
            messageLabel.text = "NO DATA FOUND"
        } else {
            messageLabel.text = ""
        }
        return loyaltyModel?.data?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoyaltyPointsTVCell", for: indexPath) as! LoyaltyPointsTVCell
        let data = loyaltyModel?.data?.list?[indexPath.row]
        cell.bookingIdLbl.text = data?.orderid
        cell.pontsEarnedlbl.text = data?.points
        cell.dateLbl.text = data?.created_at
        return cell
    }
    
}


//MARk: - API Success
extension LoyaltyPointsVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GETLOYALTY:
            do{
                print(responseData)
                loyaltyModel = try jsonDecoder.decode(LoyaltyModel.self, from: responseData.data!)
                if loyaltyModel?.status == true/*200*/{
                    totalLbl.text = "\(loyaltyModel?.data?.total_points ?? 0)"
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                } else if loyaltyModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(loyaltyModel?.message ?? "")", interval: 4)
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
