//
//  AddresssBookVC.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit
import Alamofire


class AddresssBookVC: UIViewController {

    // MARK:- Variables
    var addressModel: AddressModel?
    var pushModel: AddressDataModel?
    var apiHelper = ApiHelper()
    var GETADDRESS = "1"
    var userManager = UserManager.userManager
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var addAddressBtn:UIButton!
    

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        addAddressBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Add A New Address", comment: ""), for: .normal)
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
        apiHelper.GetData(urlString: KGetAddress, tag: GETADDRESS)
    }

    
    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func btnTap_addAddress(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
}


//MARk: - UITableView Delegate and DataSource
extension AddresssBookVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        if addressModel?.data?.count == 0 {
            messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
        } else {
            messageLabel.text = ""
        }
        return addressModel?.data?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookTVCell", for: indexPath) as? AddressBookTVCell
        cell?.headingLbl.text = addressModel?.data?[indexPath.row].home_type
        cell?.descriptionLbl.text = addressModel?.data?[indexPath.row].address
        getLang(label: [cell!.headingLbl, cell!.descriptionLbl], btn: nil)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        pushModel = addressModel?.data?[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditAddressVC") as! EditAddressVC
        vc.pushModel = addressModel?.data?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARk: - API Success
extension AddresssBookVC: ApiResponseDelegate{
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case GETADDRESS:
                do{
                    print(responseData)
                    addressModel = try jsonDecoder.decode(AddressModel.self, from: responseData.data!)
                    if addressModel?.status == true/*200*/{
                    // create session here
                        tableView.reloadData()
                    } else if addressModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(addressModel?.message ?? "")", interval: 4)
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
