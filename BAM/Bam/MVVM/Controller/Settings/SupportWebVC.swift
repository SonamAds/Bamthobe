//
//  SupportWebVC.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit
import WebKit


class SupportWebVC: UIViewController, WKUIDelegate {

    // MARK:- Variables
    var selectedIndex = 0
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingView:UIView!
    @IBOutlet weak var webKit:WKWebView!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: selectedIndex == 0 ? "Terms & Condition" : selectedIndex == 1 ? "About Us" : selectedIndex == 2 ? "FAQ's" : selectedIndex == 3 ? "Contact Us" : "Privacy Policy", comment: "")

      //  headingLbl.text = selectedIndex == 0 ? "Terms & Conditions" : selectedIndex == 1 ? "About Us" : selectedIndex == 2 ? "FAQ's" : selectedIndex == 3 ? "Contact Us" : "Privacy Policy"
        LoadingIndicatorView.show()
        let url = URL(string: selectedIndex == 0 ? kTermsCondition : selectedIndex == 1 ? kAboutUs : selectedIndex == 2 ? kFaq : selectedIndex == 3 ? "" : kPrivacyPolicy)!
        webKit.navigationDelegate = self;
        webKit.load(URLRequest(url: url))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}


extension SupportWebVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingIndicatorView.hide()
     }
}
