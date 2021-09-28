//
//  TutorVC.swift
//  Bam
//
//  Created by ADS N URL on 13/04/21.
//

import UIKit

class TutorVC: UIViewController {
    
    //MARK: - IBOutlet Propreties
    @IBOutlet weak var continueBtn: UIButton!

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        continueBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Continue", comment: ""), for: .normal)
//        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        Bundle.setLanguage("en")
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")

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
    @IBAction func btnTap_Continue(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChooseLanguageVC") as! ChooseLanguageVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
