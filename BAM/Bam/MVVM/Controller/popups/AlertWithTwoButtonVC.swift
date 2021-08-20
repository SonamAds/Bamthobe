//
//  AlertWithTwoButtonVC.swift
//  Bam
//
//  Created by ADS N URL on 06/04/21.
//

import UIKit
import Alamofire

class AlertWithTwoButtonVC: UIViewController {
    
    //MARK:- Variables
    var selectedPop = ""
    var delegate: View1Delegate?
    var thobeDict = [String: String]()
    var thobeArr = [[String: String]]()
    var apiHelper = ApiHelper()
    var ADDCART = "1"
    var ADDTOCART = "2"
    var userManager = UserManager.userManager
    
    //MARK: - IBOutlets Properties
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        noBtn.layer.borderColor = AppUsedColors.appColor.cgColor
        noBtn.layer.borderWidth = 1
//        apiHelper.responseDelegate = self
//        if selectedPop == "Contact" {
//            messageLbl.text = "Your request has been received by our team"
//            submitBtn.setTitle("Go to Home", for: .normal)
//        } else {
//            messageLbl.text = "Your gift card is added to the cart"
//            submitBtn.setTitle("Go to Cart", for: .normal)
//        }
        apiHelper.responseDelegate = self
    }


    //MARK: - API Method
    func apiHit() {
        apiHelper.PostData(urlString: kAddDesignThobeCart, tag: ADDCART, params: ["fabric": "\(thobeDict["fabric"] ?? "")", "collar": "\(thobeDict["collar"] ?? "")", "cuffs": "\(thobeDict["cuffs"] ?? "")", "pocket": "\(thobeDict["pocket"] ?? "")", "placket": "\(thobeDict["placket"] ?? "")", "button": "\(thobeDict["button"] ?? "")", "side_pocket": "\(thobeDict["side_pocket"] ?? "")", "side_pocket_2": "\(thobeDict["side_pocket_2"] ?? "")", "measurement": "\(thobeDict["measurement"] ?? "")", "measurement_type": "\(thobeDict["measurement_type"] ?? "")", "name": "\(thobeDict["name"] ?? "")", "mobile": "\(thobeDict["mobile"] ?? "")", "date": "\(thobeDict["date"] ?? "")", "branch": "\(thobeDict["branch"] ?? "")", "address": "\(thobeDict["address_id"] ?? "")"])
    }
    
    func addToCartApiHit() {
        apiHelper.PostData(urlString: kAddCart, tag: ADDTOCART, params: ["product_id":"\(thobeDict["product_id"] ?? "")", "quantity":"1", "type": "normal", "measurement": "\(thobeDict["measurement"] ?? "")", "measurement_type": "\(thobeDict["measurement_type"] ?? "")", "name": "\(thobeDict["name"] ?? "")", "mobile": "\(thobeDict["mobile"] ?? "")", "date": "\(thobeDict["date"] ?? "")", "branch": "\(thobeDict["branch"] ?? "")", "address": "\(thobeDict["address_id"] ?? "")", "time": "\(thobeDict["time"] ?? "")"])
    }
    
    
    //MARK: - IBActions
    @IBAction func btnTap_No(_ sender :UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnTap_Yes(_ sender :UIButton) {
        if thobeDict["product_id"] != "" {
            addToCartApiHit()
        } else {
            apiHit()
        }
//        self.dismiss(animated: true, completion: { () -> Void   in
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyThodeVC") as! MyThodeVC
//            vc.thobeDict = self.thobeDict
//            vc.thobeArr = self.thobeArr
//            self.delegate?.dismissViewController(controller: vc)
//        })
    }
    
}


//MARk: - API Success
extension AlertWithTwoButtonVC: ApiResponseDelegate {
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
//
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
//
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
