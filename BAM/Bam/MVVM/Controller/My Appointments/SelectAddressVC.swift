//
//  SelectAddressVC.swift
//  Bam
//
//  Created by ADS N URL on 22/03/21.
//

import UIKit
import Alamofire


class SelectAddressVC: UIViewController {
    
    //MARK: - Variables
//    var selectAddress = 0
    var thobeDict = [String: String]()
    var thobeArr = [[String: String]]()
    var addressModel: AddressModel?
    var apiHelper = ApiHelper()
    var GETADDRESS = "0"
    var ADDCART = "1"
    var ADDTOCART = "2"
    var userManager = UserManager.userManager
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var addAddressBtn:UIButton!
    @IBOutlet weak var confirmAppointmentBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addAddressBtn.layer.borderWidth = 1
        addAddressBtn.layer.borderColor = UIColor.lightGray.cgColor
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressApiHit()
    }
    
    //MARK: - Helper Method
    func addressApiHit() {
        apiHelper.GetData(urlString: KGetAddress, tag: GETADDRESS)
    }
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.PostData(urlString: kAddDesignThobeCart, tag: ADDCART, params: ["fabric": "\(thobeDict["fabric"] ?? "")", "collar": "\(thobeDict["collar"] ?? "")", "cuffs": "\(thobeDict["cuffs"] ?? "")", "pocket": "\(thobeDict["pocket"] ?? "")", "placket": "\(thobeDict["placket"] ?? "")", "button": "\(thobeDict["button"] ?? "")", "side_pocket": "\(thobeDict["side_pocket"] ?? "")", "side_pocket_2": "\(thobeDict["side_pocket_2"] ?? "")", "measurement": "\(thobeDict["measurement"] ?? "")", "measurement_type": "\(thobeDict["measurement_type"] ?? "")", "name": "\(thobeDict["name"] ?? "")", "mobile": "\(thobeDict["mobile"] ?? "")", "date": "\(thobeDict["date"] ?? "")", "branch": "\(thobeDict["branch"] ?? "")", "address": "\(thobeDict["address_id"] ?? "")", "time": "\(thobeDict["time"] ?? "")"])
    }
    
    func addToCartApiHit() {
        apiHelper.PostData(urlString: kAddCart, tag: ADDTOCART, params: ["product_id":"\(thobeDict["product_id"] ?? "")", "quantity":"1", "type": "normal", "measurement": "\(thobeDict["measurement"] ?? "")", "measurement_type": "\(thobeDict["measurement_type"] ?? "")", "name": "\(thobeDict["name"] ?? "")", "mobile": "\(thobeDict["mobile"] ?? "")", "date": "\(thobeDict["date"] ?? "")", "branch": "\(thobeDict["branch"] ?? "")", "address": "\(thobeDict["address_id"] ?? "")", "time": "\(thobeDict["time"] ?? "")"])
    }
    

    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func btnTap_addAddress(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_ConfirmAppointment(_ sender: UIButton) {
        if thobeDict["address_id"] != "" {
            if thobeDict["product_id"] != "" {
                addToCartApiHit()
            } else {
            apiHit()
            }
        } else {
            SnackBar().showSnackBar(view: self.view, text: "Select Address", interval: 4)
        }
    }
 
}


extension SelectAddressVC: View1Delegate{
    func dismissViewController(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated:true)
    }
}


//MARk: - UITableView Delegate and DataSource
extension SelectAddressVC: UITableViewDelegate, UITableViewDataSource {
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
            messageLabel.text = "NO DATA FOUND"
        } else {
            messageLabel.text = ""
        }
        return addressModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookTVCell", for: indexPath) as? AddressBookTVCell
        cell?.headingLbl.text = addressModel?.data?[indexPath.row].home_type
        cell?.descriptionLbl.text = addressModel?.data?[indexPath.row].address
        if thobeDict["address_id"] == "\(addressModel?.data?[indexPath.row].id ?? 0)" {
            cell?.tickIV.isHidden = false
        } else {
            cell?.tickIV.isHidden = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if thobeDict["address_id"] != "" {
            thobeDict["address_id"] = ""
            confirmAppointmentBtn.alpha = 0.5
        } else {
//            selectAddress = addressModel?.data?[indexPath.row].id ?? 0
            thobeDict["address_id"] =  "\(addressModel?.data?[indexPath.row].id ?? 0)"
            confirmAppointmentBtn.alpha = 1
        }
        tableView.reloadData()
        
    }
}


//MARk: - API Success
extension SelectAddressVC: ApiResponseDelegate{
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
          
            case ADDCART:
                do{
                    print(responseData)
                    let resultJson = try JSONSerialization.jsonObject(with: responseData.data!, options: []) as? [String:AnyObject]
                    print("resultJson", resultJson)
                    if let dictionary = resultJson as? [String: Any] {
                     print("dictionary", dictionary)
                        if let status = dictionary["status"] as? Bool {
                         print("status", status)
                            if status == true {
                                if let nestedDictionary = dictionary["message"] as? String {
                                 SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                                    mainTabBarController.selectedIndex = 1
                                    mainTabBarController.modalPresentationStyle = .fullScreen

                                    self.present(mainTabBarController, animated: true, completion: nil)
                                }
                            }else {
                             print("status 400")
                              if let nestedDictionary = dictionary["message"] as? String {
                                 SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
                              }
                        }
                      }
                    }
                 }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
       case ADDTOCART:
           do{
               print(responseData)
               let response = try jsonDecoder.decode(AddtoCartModel.self, from: responseData.data!)
               if response.status == true/*200*/{
                   // create session here
                SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                mainTabBarController.selectedIndex = 1
                mainTabBarController.modalPresentationStyle = .fullScreen

                self.present(mainTabBarController, animated: true, completion: nil)
               
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
