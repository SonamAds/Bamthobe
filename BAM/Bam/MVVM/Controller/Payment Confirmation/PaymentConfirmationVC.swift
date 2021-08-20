//
//  PaymentConfirmationVC.swift
//  Bam
//  Created by ADS N URL on 06/04/21.
//

import UIKit

class PaymentConfirmationVC: UIViewController {
    
    //MARK: - Variables
    var selectedView = 0
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var confirmationView: UIView!
    @IBOutlet weak var tickIV: UIImageView!
    @IBOutlet weak var thankyouLbl: UILabel!
    @IBOutlet weak var orderConfirmedLbl: UILabel!
    @IBOutlet weak var orderStatusBtn: UIButton!
    @IBOutlet weak var continueShoppingBtn: UIButton!
    @IBOutlet weak var loaderIV: UIImageView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var refreshLbl: UILabel!

    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedView == 0 {
            loaderView.isHidden = false
            confirmationView.isHidden = true
            headingLbl.text = "Payment Verification"
        } else {
            loaderView.isHidden = true
            confirmationView.isHidden = false
            headingLbl.text = "Order Confirmation"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.selectedView = 1
            self.loaderView.isHidden = true
            self.confirmationView.isHidden = false
            self.headingLbl.text = "Order Confirmation"
        }
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_ContinueShopping(_ sender: Any) {
        let objVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let TabViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
        appNavigation.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows[0].rootViewController = TabViewController
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_OrderStatus(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        mainTabBarController.selectedIndex = 2
        mainTabBarController.modalPresentationStyle = .fullScreen
                
        self.present(mainTabBarController, animated: true, completion: nil)
        
    }
}
