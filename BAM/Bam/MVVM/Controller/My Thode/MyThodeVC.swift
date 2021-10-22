//
//  MyThodeVC.swift
//  Bam
//
//  Created by ADS N URL on 12/04/21.
//

import UIKit
import Alamofire


class MyThodeVC: UIViewController {
    
    //MARK: - Variables
    var thobeDict = [String: String]()
    var thobeArr = [[String: String]]()
    var delegate : backDelegate?
    var apiHelper = ApiHelper()
    var ADDCART = "1"
    var userManager = UserManager.userManager
    
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var itemsLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var backCustomizeBtn: UIButton!
    @IBOutlet weak var nextCustomizeSV: UIStackView!
    @IBOutlet weak var nextCustomizeLbl: UIButton!
    @IBOutlet weak var backCustomizeSV: UIStackView!
    @IBOutlet weak var backCustomizeLbl: UIButton!
    @IBOutlet weak var nextCustomizeBtn: UIButton!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        backCustomizeLbl.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Side Pocket", comment: ""), for: .normal)
        nextCustomizeLbl.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Measurement", comment: ""), for: .normal)
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.PostData(urlString: kAddDesignThobeCart, tag: ADDCART, params: ["fabric": "\(thobeDict["fabric"] ?? "")", "collar": "\(thobeDict["collar"] ?? "")", "cuffs": "\(thobeDict["cuffs"] ?? "")", "pocket": "\(thobeDict["pocket"] ?? "")", "placket": "\(thobeDict["placket"] ?? "")", "button": "\(thobeDict["button"] ?? "")", "side_pocket": "\(thobeDict["side_pocket"] ?? "")", "side_pocket_2": "\(thobeDict["side_pocket_2"] ?? "")", "measurement": "\(thobeDict["measurement"] ?? "")", "measurement_type": "\(thobeDict["measurement_type"] ?? "")", "name": "\(thobeDict["name"] ?? "")", "mobile": "\(thobeDict["mobile"] ?? "")", "date": "\(thobeDict["date"] ?? "")", "branch": "\(thobeDict["branch"] ?? "")", "address": "\(thobeDict["address_id"] ?? "")"])
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func btnTap_NextCustomize(_ sender: UIButton) {
//            addCartApi()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SavedMeasurementsVC") as! SavedMeasurementsVC
        vc.thobeDict = thobeDict
        vc.thobeArr = thobeArr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_BackCustomize(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func addMoreThobePressed(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeVC.self) {//CustomizeThodeVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
 
    
    @IBAction func btnTap_GoToCart(_ sender: UIButton) {
        apiHit()
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "AlertWithoutClickVC") as! AlertWithoutClickVC
//        vc.selectedPop = "Appointment"
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
//        vc.delegate = self
//        self.present(vc, animated: true)
    }
    
}


//MARK: - UITableView Delegate and DataSource
extension MyThodeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyThodeTVCell", for: indexPath) as! MyThodeTVCell
        
        cell.fabricEditBtn.tag = indexPath.row + 1
        cell.delegate = self
        cell.fabricPriceLbl.text = "SAR \(thobeArr[0]["price"] ?? "")"
        cell.fabricIV.sd_setImage(with: URL(string: thobeArr[0]["image"] ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.fabricIV.image = image
            cell.fabricIV.contentMode = .scaleAspectFit
        }
        
        cell.cuffsPriceLbl.text = "SAR \(thobeArr[2]["price"] ?? "")"
        cell.cuffsLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Cuff", comment: "")
        cell.cuffsIV.sd_setImage(with: URL(string: thobeArr[2]["image"] ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.fabricIV.image = image
            cell.fabricIV.contentMode = .scaleAspectFit
        }
        
        cell.collarPriceLbl.text = "SAR \(thobeArr[1]["price"] ?? "")"
        cell.collarIV.sd_setImage(with: URL(string: thobeArr[1]["image"] ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.fabricIV.image = image
            cell.fabricIV.contentMode = .scaleAspectFit
        }
        
        cell.buttonPriceLbl.text = "SAR \(thobeArr[5]["price"] ?? "")"
        cell.buttonIV.sd_setImage(with: URL(string: thobeArr[5]["image"] ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.fabricIV.image = image
            cell.fabricIV.contentMode = .scaleAspectFit
        }
        
        cell.pocketPriceLbl.text = "SAR \(thobeArr[3]["price"] ?? "")"
        cell.pocketIV.sd_setImage(with: URL(string: thobeArr[3]["image"] ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.fabricIV.image = image
            cell.fabricIV.contentMode = .scaleAspectFit
        }
        
        cell.placketPriceLbl.text = "SAR \(thobeArr[4]["price"] ?? "")"
        cell.placketIV.sd_setImage(with: URL(string: thobeArr[4]["image"] ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.fabricIV.image = image
            cell.fabricIV.contentMode = .scaleAspectFit
        }
        
        cell.sidePocketPriceLbl.text = "SAR \(thobeArr[6]["price"] ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        delegate?.branchSelected(id: 1, name: "My Thobe")
//        navigationController?.popViewController(animated: true)
    }
      
}


//MARK: - Custom Delegate
extension MyThodeVC: ThodeDetailDelegate {
    func didTap(row: Int, selectedThobe: Int) {
        delegate?.branchSelected(id: selectedThobe, name: "My Thobe")
        navigationController?.popViewController(animated: true)
    }
    
}

//MARk: - API Success
extension MyThodeVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
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
