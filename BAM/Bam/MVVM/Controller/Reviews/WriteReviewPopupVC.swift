//
//  WriteReviewPopupVC.swift
//  Bam
//
//  Created by ADS N URL on 22/03/21.
//

import UIKit
import Alamofire


protocol PassValueDelegate {
    func passValue(str: String)
}

class WriteReviewPopupVC: UIViewController {
    
    //MARK: - Variables
    var productId = "0"
    var subOrderId = "0"
    var rating = 0
    var delegate : PassValueDelegate?
    var productDetailModel: ProductDetailModelData?
    var apiHelper = ApiHelper()
    var ADDREVIEW = "1"
    var userManager = UserManager.userManager
    
    // MARK:- IBOutlets
    @IBOutlet weak var messageTF:UITextView!
    @IBOutlet weak var messageView:UIView!
    @IBOutlet weak var rating1Btn:UIButton!
    @IBOutlet weak var rating2Btn:UIButton!
    @IBOutlet weak var rating3Btn:UIButton!
    @IBOutlet weak var rating4Btn:UIButton!
    @IBOutlet weak var rating5Btn:UIButton!
    @IBOutlet weak var cancelBtn:UIButton!
    @IBOutlet weak var saveBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTF.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Type your message here…", comment: "")
        messageTF.textColor = UIColor.lightGray
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        messageTF.delegate = self
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK: - Helper Method
    func apiHit() {
        apiHelper.PostData(urlString: kAddReview, tag: ADDREVIEW, params: ["star":"\(rating)", "product_id":productId, "comments":messageTF.text ?? "", "sub_order_id": subOrderId])
    }
    
    //MARK: Actions
    @IBAction func btnTap_rating1(_ sender: UIButton) {
        if rating1Btn.currentImage == #imageLiteral(resourceName: "star") {
            rating = 1
            rating1Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        } else {
            rating = 0
            rating1Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }
    }
    
    @IBAction func btnTap_rating2(_ sender: UIButton) {
        if rating2Btn.currentImage == #imageLiteral(resourceName: "star") {
            rating = 2
            rating1Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        } else {
            rating = 0
            rating1Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }
    }
    
    @IBAction func btnTap_rating3(_ sender: UIButton) {
        if rating3Btn.currentImage == #imageLiteral(resourceName: "star") {
            rating = 3
            rating1Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        } else {
            rating = 0
            rating1Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }
    }
    
    @IBAction func btnTap_rating4(_ sender: UIButton) {
        if rating4Btn.currentImage == #imageLiteral(resourceName: "star") {
            rating = 4
            rating1Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        } else {
            rating = 0
            rating1Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }
    }
    
    @IBAction func btnTap_rating5(_ sender: UIButton) {
        if rating5Btn.currentImage == #imageLiteral(resourceName: "star") {
            rating = 5
            rating1Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
        } else {
            rating = 0
            rating1Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating2Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating3Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating4Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            rating5Btn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }
    }
    
    @IBAction func btnTap_save(_ sender: UIButton) {
        if rating == 0 {
            SnackBar().showSnackBar(view: self.view, text: "Please Select atleast one Star to rate", interval: 4)
        } else {
            apiHit()
        }
        
    }
    
    @IBAction func btnTap_cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: - UITextView Delegate
extension WriteReviewPopupVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTF.textColor == UIColor.lightGray {
            messageTF.text = ""
            messageTF.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTF.text.isEmpty {
            messageTF.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Type your message here…", comment: "")
            messageTF.textColor = UIColor.lightGray
        }
    }
}


//MARk: - API Success
extension WriteReviewPopupVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case ADDREVIEW:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(LoginModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                    // create session here
                        SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
                        self.dismiss(animated: false, completion: { () -> Void   in
                            
                            self.delegate?.passValue(str: "api")
                        })
                        
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
