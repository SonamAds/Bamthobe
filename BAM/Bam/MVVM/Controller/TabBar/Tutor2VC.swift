//
//  Tutor2VC.swift
//  Bam
//
//  Created by ADS N URL on 13/04/21.
//

import UIKit

class Tutor2VC: UIViewController {

    //MARK: - IBOutlet Propreties
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var continueAsGuestBtn: UIButton!

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - IBActions
    @IBAction func btnTap_Login(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnTap_Signup(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnTap_Guest(_ sender: Any) {
        let objVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let TabViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
        appNavigation.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows[0].rootViewController = TabViewController
    }
}


