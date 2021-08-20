//
//  GiftPopVC.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit

class GiftPopVC: UIViewController {

    //MARK:- Variables
    var selectedPop = ""
//    let tabBar = TabBarVC()
    var delegate : View1Delegate?
//    let tabBarController = UITabBarController()
//    tabBarController.viewControllers = [vc1, vc2]
    
    //MARK: - IBOutlets
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!


    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.layer.borderColor = AppUsedColors.appColor.cgColor
        submitBtn.layer.borderWidth = 1
//        apiHelper.responseDelegate = self
        
        if selectedPop == "Contact" {
            messageLbl.text = "Your request has been received by our team"
            submitBtn.setTitle("Go to Home", for: .normal)
        } else {
            messageLbl.text = "Your gift card is added to the cart"
            submitBtn.setTitle("Go to Cart", for: .normal)
        }
    }
    
    
    //MARK: - IBActions
    @IBAction func clickCloseBtn(_ sender :UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnTap_Submit(_ sender :UIButton) {
        if selectedPop == "Contact" {
            self.dismiss(animated: true, completion: { () -> Void in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.delegate?.dismissViewController(controller: vc)
            })
        } else {
            
            self.dismiss(animated: false, completion: { () -> Void   in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
                self.delegate?.dismissViewController(controller: vc)
            })
        }
    }
    
}

