//
//  MyMeasurmentsVC.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit
import Alamofire


class MyMeasurmentsVC: UIViewController {

    //MARK: - Variables
    var measurementModel: MeasurementModel?
    var apiHelper = ApiHelper()
    var GETMEASUREMENT = "0"
    var userManager = UserManager.userManager
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headingLbl: UILabel!
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        headingLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "My Measurements", comment: "")
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
    }
    
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: kGetMeasurements, tag: GETMEASUREMENT)
    }
      
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UITableView Delegate and DataSource
extension MyMeasurmentsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        if measurementModel?.data?.count == 0 {
            messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")

        } else {
            messageLabel.text = ""
        }
        return measurementModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTVCell
        let data = measurementModel?.data?[indexPath.row]
        cell.descriptionLbl.text = data?.name
        cell.dateLbl.text = data?.updated_at
        getLang(label: [cell.descriptionLbl], btn: nil)
//        cell.usrIV.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}


//MARk: - API Success
extension MyMeasurmentsVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case GETMEASUREMENT:
            do{
                print(responseData)
                measurementModel = try jsonDecoder.decode(MeasurementModel.self, from: responseData.data!)
                if measurementModel?.status == true/*200*/{
                    // create session here
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                } else if measurementModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(measurementModel?.message ?? "")", interval: 4)
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
