//
//  CartVC.swift
//  Bam
//
//  Created by ADS N URL on 12/04/21.
//

import UIKit
import Alamofire


class CartVC: UIViewController {
    
    //MARK: - Variables
    var selectedRow = 0
    var selectedSection = 0
    var cartModel: CartModel?
    var apiHelper = ApiHelper()
    var GETCART = "0"
    var DELETEPRODUCT = "1"
    var THOBEQTY = "2"
    var userManager = UserManager.userManager
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemsLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var btn_Checkout: UIButton!

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        itemsLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Items", comment: "")
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        apiHit()
    }
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.GetData(urlString: kGetCart, tag: GETCART)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnTap_Checkout(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_BackCustomize(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnTap_ContinueShopping(_ sender: UIButton) {
        let objVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let TabViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
        appNavigation.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows[0].rootViewController = TabViewController
    }
    
}


extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.tableView.backgroundView = messageLabel;
        if cartModel?.data?.normal?.count == 0 && cartModel?.data?.gift_cart?.count == 0 && cartModel?.data?.customize?.count == 0 {
            messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
            btn_Checkout.isHidden = true
            itemsLbl.isHidden = true
        } else {
            messageLabel.text = ""
            btn_Checkout.isHidden = false
            itemsLbl.isHidden = false
        }
        
        if section == 0 {
            return cartModel?.data?.normal?.count ?? 0
        } else if section == 2 {
            return cartModel?.data?.gift_cart?.count ?? 0
        } else {
            return cartModel?.data?.customize?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVCell", for: indexPath) as! CartTVCell
        cell.giftDeleteBtn.tag = indexPath.row + 1
        cell.thodeDeleteBtn.tag = indexPath.row + 1
        cell.giftPriceLbl.tag = indexPath.section
        cell.thodeLbl.tag = indexPath.section
        cell.deleteDelegate = self
        if indexPath.section == 0 {
            let data = cartModel?.data?.normal?[indexPath.row]
            cell.thodeLbl.text = data?.title
            cell.thodeDescriptionLbl.text = data?.description
            cell.addCartValueTF.text = data?.quantity
//            let cost = String(data!.total_cost!)
            cell.thodePriceLbl.text = "SAR " + (data?.total_cost ?? "")
            let url = (data?.image ?? "")
            cell.thodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.thodeIV.image = image
            }
            cell.giftView.isHidden = true
            cell.priceView.isHidden = true
            cell.thodeView.isHidden = false
            cell.lessDetailHeightConstraint.constant = 0
        } else if indexPath.section == 2 {
            let data = cartModel?.data?.gift_cart?[indexPath.row]
//            cell.giftLbl.text = data?.title
//            cell.giftQtyLbl.text = "1"//data?.
            cell.giftDescriptionLbl.text = data?.description
            cell.giftPriceLbl.text = "SAR " + "\(data?.price ?? "0")"
            let url = (data?.image ?? "")
            cell.giftIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.giftIV.image = image
            }
            cell.giftView.isHidden = false
            cell.thodeView.isHidden = true
            cell.priceView.isHidden = true
            cell.lessDetailHeightConstraint.constant = 0
        } else {
            let data = cartModel?.data?.customize?[indexPath.row]
            let url = (data?.image ?? "")
            cell.thodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.thodeIV.image = image?.withRenderingMode(.alwaysTemplate)
                cell.thodeIV.tintColor = hexStringToUIColor(hex: data?.view_more?.color_code ?? "")

            }

            cell.thodeLbl.text = data?.title
            cell.thodeDescriptionLbl.text = data?.description
            cell.addCartValueTF.text = "\(data?.quantity ?? 0)"
//            let cost = String((data?.quantity ?? 0) * (data?.price ?? 0))
            cell.thodePriceLbl.text = "SAR \(data?.price ?? 0)"
            cell.visitingChargePriceLbl.text = "SAR \(data?.view_more?.visiting_charge ?? "0")"
//            cell.advancePriceLbl.text = "SAR \(data?.view_more?.advanced_payment ?? 0)"
//            cell.remPriceLbl.text = "SAR \(data?.view_more?.remaining ?? 0)"
            cell.subTotalPriceLbl.text = "SAR \(data?.price ?? 0)"//"\(data?.view_more?.thodePriceLbl ?? 0)"

            cell.fabricPriceLbl.text = "SAR \(data?.view_more?.fabric ?? "0")"
            cell.collarPriceLbl.text = "SAR \(data?.view_more?.collar ?? "0")"
            cell.cuffPriceLbl.text = "SAR \(data?.view_more?.cuffs ?? "0")"
            cell.pocketPriceLbl.text = "SAR \(data?.view_more?.pocket ?? "0")"
            cell.placketPriceLbl.text = "SAR \(data?.view_more?.placket ?? "0")"
            cell.buttonPriceLbl.text = "SAR \(data?.view_more?.button ?? "0")"
//            cell.sidePocketPriceLbl.text = "SAR \(data?.view_more?.fabric ?? 0)"
            cell.advancePriceLbl.text = "SAR \(data?.view_more?.advanced_payment ?? "0")"
            cell.remPriceLbl.text = "SAR \(data?.view_more?.remaining ?? "0")"
//            cell.visitingChargePriceLbl.text = "SAR \(data?.view_more?.fabric ?? 0)"
            cell.sidePocketSV.isHidden = true
            
            cell.giftView.isHidden = true
            cell.thodeView.isHidden = false
            cell.lessDetailHeightConstraint.constant = 30
            
            if selectedRow == indexPath.row && cell.priceView.isHidden == true {
                cell.priceView.isHidden = false
            } else if selectedRow == indexPath.row && cell.priceView.isHidden == false {
                cell.priceView.isHidden = true
            } else {
                cell.priceView.isHidden = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 1 {
//            let cell = tableView.cellForRow(at: indexPath) as? CartTVCell
//            if cell?.priceView.isHidden == false {
//                cell?.priceView.isHidden = true
//            } else {
//                cell?.priceView.isHidden = false
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            let cell = tableView.cellForRow(at: indexPath) as? CartTVCell
            if cell?.priceView.isHidden == false {
                return 412
            } else {
                return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
      
}

//MARK: - Custom Delegate
extension CartVC: CartProductDeleteDelegate {
    func showDetails(rows: Int, section: Int) {
        selectedSection = section
        selectedRow = rows - 1
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
//        let indexPath = IndexPath(row: rows - 1, section: section - 1)
//
//        let cell = tableView.cellForRow(at: indexPath) as? CartTVCell
//        if cell?.priceView.isHidden == false {
//            cell?.priceView.isHidden = true
//        } else {
//            cell?.priceView.isHidden = false
//        }
//        tableView.reloadRows(at: [indexPath], with: .fade)

//        tableView.reloadSections(IndexSet(integer: section), with: .bottom)
    }
    
    func changeQuantity(rows: Int, quantity: String, section: Int) {
        self.workingQuantity(sender: rows, qty: quantity, sections: section)
    }
    
    func deleteProduct(row: Int, section: Int) {
        if section == 0 {
            apiHelper.PostData(urlString: kDeleteProduct, tag: DELETEPRODUCT, params: ["cart_id":"\(cartModel?.data?.normal?[row - 1].id ?? 0)", "type": cartModel?.data?.normal?[row - 1].type ?? ""])
        } else if section == 1 {
            apiHelper.PostData(urlString: kDeleteProduct, tag: DELETEPRODUCT, params: ["cart_id":"\(cartModel?.data?.customize?[row - 1].id ?? 0)", "type": cartModel?.data?.customize?[row - 1].type ?? ""])
        } else {
            apiHelper.PostData(urlString: kDeleteProduct, tag: DELETEPRODUCT, params: ["cart_id":"\(cartModel?.data?.gift_cart?[row - 1].id ?? 0)", "type": cartModel?.data?.gift_cart?[row - 1].type ?? ""])
        }
    }
    
    
    func workingQuantity(sender: Int, qty: String, sections: Int) {
        if sections == 0 {
            apiHelper.PostData(urlString: kAddCart, tag: THOBEQTY, params: ["product_id":(cartModel?.data?.normal?[sender - 1].product_id ?? ""), "type": cartModel?.data?.normal?[sender - 1].type ?? "", "quantity": qty])
        } else if sections == 1 {
            apiHelper.PostData(urlString: kAddThobeQuantity, tag: THOBEQTY, params: ["cart_id":"\(cartModel?.data?.customize?[sender - 1].id ?? 0)", "type": cartModel?.data?.customize?[sender - 1].type ?? "", "quantity": qty])
        }
        
//        let keys = Array(qtyArray.values)
//        var totalStr = 0
//        for i in 0..<keys.count {
//            if keys[i] != "" {
//                totalStr = totalStr + Int(keys[i])!
//            }
//        }
//        totalItemsLbl.setTitle(String(totalStr) + " Items", for: .normal)
    }
}


//MARk: - API Success
extension CartVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case GETCART:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(CartModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                        cartModel = response
//                        let data = cartModel?.data
//                        let cnt = 0
//                        for i in 0..<(response.data!.count) {
//                            
//                        }
                        itemsLbl.text = "Items (\(cartModel?.data?.total_quantity ?? 0))"

                        tableView.reloadData()
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
            case DELETEPRODUCT:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(DeleteProductModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                        // create session here
                        apiHit()
                        SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
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
                
            case THOBEQTY:
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
