//
//  GiftListVC.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit
import Alamofire


class GiftListVC: UIViewController {
    
    //MARK: - Variables
    var giftModel: GiftModel?
    var apiHelper = ApiHelper()
    var GETGIFT = "-1"
    var userManager = UserManager.userManager
   
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    
  
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        apiHit()
    }
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: kGetGift, tag: GETGIFT)
    }
      
        
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UITableView Delegate and DataSource
extension GiftListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        if giftModel?.data?.count == 0 {
            messageLabel.text = "NO DATA FOUND"
        } else {
            messageLabel.text = ""
        }
        return giftModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GiftTVCell", for: indexPath) as! GiftTVCell
        let data = giftModel?.data?[indexPath.row]
        cell.priceLbl.text = "SAR \(data?.price ?? "0")"
        cell.descriptionLbl.text = data?.description
        let url = (data?.image ?? "")
        cell.giftIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.giftIV.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GiftListViewVC") as! GiftListViewVC
        vc.giftId = giftModel?.data?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARk: - API Success
extension GiftListVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GETGIFT:
            do{
                print(responseData)
                giftModel = try jsonDecoder.decode(GiftModel.self, from: responseData.data!)
                if giftModel?.status == true/*200*/{
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
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
