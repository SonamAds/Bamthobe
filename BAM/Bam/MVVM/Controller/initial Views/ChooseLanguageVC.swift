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
        Bundle.setLanguage("en")
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")

//        UserDefaults.standard.set("en", forKey: "lang")
//        UserDefaults.standard.synchronize()
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tutor2VC") as! Tutor2VC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func btnTap_Arabic(_ sender: Any) {
        Bundle.setLanguage("ar")
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
//        UserDefaults.standard.set("ar", forKey: "lang")
//        UserDefaults.standard.synchronize()
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tutor2VC") as! Tutor2VC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
