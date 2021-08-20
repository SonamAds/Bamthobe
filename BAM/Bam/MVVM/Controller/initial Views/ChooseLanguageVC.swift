//
//  ChooseLanguageVC.swift
//  Bam
//
//  Created by ADS N URL on 16/03/21.
//

import UIKit

class ChooseLanguageVC: UIViewController {
    
    //MARK: - IBOutlet Propreties
    @IBOutlet weak var btn_English: UIButton!
    @IBOutlet weak var btn_Arabic: UIButton!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_Arabic.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Arabic", comment: ""), for: .normal)
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
    @IBAction func btnTap_English(_ sender: Any) {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        UIView.appearance().semanticContentAttribute = .forceLeftToRight

//        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
//        } else {
//
//        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tutor2VC") as! Tutor2VC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func btnTap_Arabic(_ sender: Any) {
//        SnackBar().showSnackBar(view: self.view, text: "Coming Soon", interval: 4)
//        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
//                    LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
//                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
//                } else {
//                    LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
//                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
//                }
                
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "vc") as! ViewController
//                let appDlg = UIApplication.shared.delegate as? AppDelegate
//                appDlg?.window?.rootViewController = vc
        
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tutor2VC") as! Tutor2VC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
