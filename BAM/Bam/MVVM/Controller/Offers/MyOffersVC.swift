//
//  MyOffersVC.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit
import Alamofire


class MyOffersVC: UIViewController {

    //MARK: - Variables
    var offerModel: OfferModel?
    var apiHelper = ApiHelper()
    var GETOFFER = "-1"
    var userManager = UserManager.userManager
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headingLbl: UILabel!
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        tableView.tableFooterView = UIView()
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
    }
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: kGetOffer, tag: GETOFFER)
    }
      
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension MyOffersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        if offerModel?.data?.count == 0 {
            messageLabel.text = "NO DATA FOUND"
        } else {
            messageLabel.text = ""
        }
        return offerModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTVCell
        let data = offerModel?.data?[indexPath.row]
        cell.dateLbl.text = "Expiry: \(data?.expiry_date ?? "")"
        cell.descriptionLbl.text = data?.description
        cell.unreadBtn.setTitle("CODE: \(data?.code ?? "")", for: .normal)
//        cell.titleLbl.text = data?.title
        let url = (data?.image ?? "")
        cell.usrIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.usrIV.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}


//MARk: - API Success
extension MyOffersVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GETOFFER:
            do{
                print(responseData)
                offerModel = try jsonDecoder.decode(OfferModel.self, from: responseData.data!)
                if offerModel?.status == true/*200*/{
            // create session here
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                } else if offerModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(offerModel?.message ?? "")", interval: 4)
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
