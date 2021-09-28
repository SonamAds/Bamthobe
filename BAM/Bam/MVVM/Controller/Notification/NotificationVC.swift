//
//  NotificationVC.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit
import Alamofire


class NotificationVC: UIViewController {

    //MARK: - Variables
    var notificationModel: NotificationModel?
    var apiHelper = ApiHelper()
    var GETNOTIFICATION = "0"
    var userManager = UserManager.userManager
    
   
    //MARK:- IBOutlet Properties
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var notificationTable: UITableView!
  
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        headingLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Notification", comment: "")
        notificationTable.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationTable.tableFooterView = UIView()
        apiHit()
    }
    
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: "\(kGetNotification)\(userManager.getApiToken())", tag: GETNOTIFICATION)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.notificationTable.bounds.size.width, height: self.notificationTable.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.notificationTable.backgroundView = messageLabel;
        if notificationModel?.data?.count == 0 {
            messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
        } else {
            messageLabel.text = ""
        }
        return notificationModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTVCell
//        cell.dateLbl.text = notificationModel?.data?[indexPath.row]
//        cell.dateLbl.text = notificationModel?.data?[indexPath.row].title
        cell.descriptionLbl.text = notificationModel?.data?[indexPath.row].notification
        cell.usrIV.image = #imageLiteral(resourceName: "Mask")
        if /*Bundle.getLanguage()*/UserDefaults.standard.string(forKey: "lang") == "ar" {
            cell.dateLbl.textAlignment = .left
        } else {
            cell.dateLbl.textAlignment = .right
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}



//MARk: - API Success
extension NotificationVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GETNOTIFICATION:
            do{
                print(responseData)
                notificationModel = try jsonDecoder.decode(NotificationModel.self, from: responseData.data!)
                if ((notificationModel?.status) != nil) == true/*200*/{
            // create session here
                    notificationTable.delegate = self
                    notificationTable.dataSource = self
                    notificationTable.reloadData()
                } else if ((notificationModel?.status) != nil) == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(notificationModel?.msg ?? "")", interval: 4)
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
