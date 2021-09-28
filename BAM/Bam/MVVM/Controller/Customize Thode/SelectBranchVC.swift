//
//  SelectBranchVC.swift
//  Bam
//
//  Created by ADS N URL on 04/05/21.
//

import UIKit
import Alamofire

protocol backDelegate {
    func branchSelected(id: Int, name: String)
}


class SelectBranchVC: UIViewController {

    // MARK:- Variables
    var branchId = 0
    var branchName = ""
    var delegate: backDelegate?
    var branchModel: BranchModel?
    var apiHelper = ApiHelper()
    var GETBRANCH = "1"
    var userManager = UserManager.userManager
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var continueBtn:UIButton!
    

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0.5
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
    }

    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: kGetBranch, tag: GETBRANCH)
    }

    
    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_Continue(_ sender: UIButton) {
//        self.delegate?.branchSelected(id: self.branchId, name: self.branchName)
        self.dismiss(animated: true, completion: {() -> Void   in
            self.delegate?.branchSelected(id: self.branchId, name: self.branchName)
        })
        

    }
}


//MARk: - UITableView Delegate and DataSource
extension SelectBranchVC: UITableViewDelegate, UITableViewDataSource {
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
        if branchModel?.data?.count == 0 {
            messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
        } else {
            messageLabel.text = ""
        }
        return branchModel?.data?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookTVCell", for: indexPath) as? AddressBookTVCell
        cell?.headingLbl.text = branchModel?.data?[indexPath.row].branch
        cell?.descriptionLbl.text = branchModel?.data?[indexPath.row].address
        if branchId == branchModel?.data?[indexPath.row].id {
            cell?.tickIV.isHidden = false
        } else {
            cell?.tickIV.isHidden = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if branchId == branchModel?.data?[indexPath.row].id ?? 0{
            branchId = 0
            branchName = ""
        } else {
            branchId = branchModel?.data?[indexPath.row].id ?? 0
            branchName = branchModel?.data?[indexPath.row].branch ?? ""
        }
        tableView.reloadData()
    }
}


//MARk: - API Success
extension SelectBranchVC: ApiResponseDelegate{
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case GETBRANCH:
                do{
                    print(responseData)
                    branchModel = try jsonDecoder.decode(BranchModel.self, from: responseData.data!)
                    if branchModel?.status == true/*200*/{
                    // create session here
                        tableView.delegate = self
                        tableView.dataSource = self
                        tableView.reloadData()
                    } else if branchModel?.status == false {
                        LoadingIndicatorView.hide()
                        SnackBar().showSnackBar(view: self.view, text: "\(branchModel?.message ?? "")", interval: 4)
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

