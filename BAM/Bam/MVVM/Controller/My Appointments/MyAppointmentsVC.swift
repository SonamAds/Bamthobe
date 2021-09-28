//
//  MyAppointments.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit
import Alamofire


class MyAppointmentsVC: UIViewController {

    //MARK: - Variables
    var sectionArray = ["Ongoing Appointment", "Older Appointment"]
    var ongoingAppointmentModel: OngoingAppointmentModel?
    var olderAppointmentModel: OlderAppointmentModel?
    var apiHelper = ApiHelper()
    var ONGOINGAPPOINTMENTS = "1"
    var OLDERAPPOINTMENTS = "0"
    var userManager = UserManager.userManager
  
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headingLbl: UILabel!
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        deleteAddressBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Delete Address", comment: ""), for: .normal)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ongoingAppointment()
        olderAppointment()
    }
    
    //MARK: - Helper Method
    func ongoingAppointment() {
        apiHelper.GetData(urlString: kOngoingAppointments, tag: ONGOINGAPPOINTMENTS)
    }
    
    func olderAppointment() {
        apiHelper.GetData(urlString: kOlderAppointments, tag: OLDERAPPOINTMENTS)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
}


extension MyAppointmentsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        if ongoingAppointmentModel?.data?.count == 0 && olderAppointmentModel?.data?.count == 0 {
            messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
        } else {
            messageLabel.text = ""
        }
        if ongoingAppointmentModel?.data?.count != 0 && olderAppointmentModel?.data?.count != 0 {
            return 2
        } else if ongoingAppointmentModel?.data?.count != 0 || olderAppointmentModel?.data?.count != 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return ongoingAppointmentModel?.data?.count ?? 0
        } else {
            return olderAppointmentModel?.data?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAppointmentsTVCell", for: indexPath) as! MyAppointmentsTVCell
        if ongoingAppointmentModel?.data?.count != 0 && olderAppointmentModel?.data?.count != 0 || ongoingAppointmentModel?.data?.count != 0 {
            if indexPath.section == 0 {
                let data = ongoingAppointmentModel?.data?[indexPath.row]
                cell.bookingIdLbl.text = "Booking ID: \(data?.booking_id ?? "")"
                cell.dateLbl.text = data?.date
                cell.visitLbl.text = "\(data?.type ?? "") Visit"
                if data?.type == "home" {
                    cell.storeAddressLbl.text = data?.home_address
                    cell.storeNameLbl.text = "Name: \(data?.name ?? "")"
                    cell.storeAddressLbl.text = data?.home_address

                } else {
                    cell.storeAddressLbl.text = data?.store_address
                    cell.storeNameLbl.text = "Store Name: \(data?.store_name ?? "")"
                    cell.storeAddressLbl.text = data?.store_address

                }
                
            } else {
                let data = olderAppointmentModel?.data?[indexPath.row]
                cell.bookingIdLbl.text = "Booking ID: \(data?.booking_id ?? "")"
                cell.dateLbl.text = data?.date
                cell.visitLbl.text = "\(data?.type ?? "") Visit"
                if data?.type == "home" {
                    cell.storeAddressLbl.text = data?.home_address
                    cell.storeNameLbl.text = "Name: \(data?.name ?? "")"
                    cell.storeAddressLbl.text = data?.home_address

                } else {
                    cell.storeAddressLbl.text = data?.store_address
                    cell.storeNameLbl.text = "Store Name: \(data?.store_name ?? "")"
                    cell.storeAddressLbl.text = data?.store_address

                }
            }
        } else {
            let data = olderAppointmentModel?.data?[indexPath.row]
            cell.bookingIdLbl.text = "Booking ID: \(data?.booking_id ?? "")"
            cell.dateLbl.text = data?.date
            cell.visitLbl.text = "\(data?.type ?? "") Visit"
            if data?.type == "home" {
                cell.storeAddressLbl.text = data?.home_address
                cell.storeNameLbl.text = "Name: \(data?.name ?? "")"
                cell.storeAddressLbl.text = data?.home_address

            } else {
                cell.storeAddressLbl.text = data?.store_address
                cell.storeNameLbl.text = "Store Name: \(data?.store_name ?? "")"
                cell.storeAddressLbl.text = data?.store_address

            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)) //set these values as necessary
        returnedView.backgroundColor = .white

        let label = UILabel(frame: CGRect(x: 10, y: 5, width: UIScreen.main.bounds.width - 20, height: 30))

        if ongoingAppointmentModel?.data?.count != 0 && olderAppointmentModel?.data?.count != 0 || ongoingAppointmentModel?.data?.count == 0 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: self.sectionArray[section], comment: "")
        } else {
            if ongoingAppointmentModel?.data?.count != 0 && olderAppointmentModel?.data?.count != 0 || ongoingAppointmentModel?.data?.count != 0 {
                label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Ongoing Appointment", comment: "")
            } else {
                label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Older Appointment", comment: "")
            }
        }
        returnedView.addSubview(label)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
   
}


//MARk: - API Success
extension MyAppointmentsVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case ONGOINGAPPOINTMENTS:
            do{
                print(responseData)
                ongoingAppointmentModel = try jsonDecoder.decode(OngoingAppointmentModel.self, from: responseData.data!)
                if ongoingAppointmentModel?.status == true/*200*/{
                    // create session here
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                } else if ongoingAppointmentModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(ongoingAppointmentModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
        case OLDERAPPOINTMENTS:
            do{
                print(responseData)
                olderAppointmentModel = try jsonDecoder.decode(OlderAppointmentModel.self, from: responseData.data!)
                if olderAppointmentModel?.status == true/*200*/{
                    // create session here
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.reloadData()
                } else if olderAppointmentModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(olderAppointmentModel?.message ?? "")", interval: 4)
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
