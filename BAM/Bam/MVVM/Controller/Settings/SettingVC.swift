//
//  SettingVC.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit
import SafariServices
class SettingVC: UIViewController {

    // MARK:- Variables
    private let menuArr = ["Terms & Conditions", "About Us", "FAQ's", "Contact Us", "Privacy Policy"]

    
    // MARK:- IBOutlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        headingLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Setting", comment: "")
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
       // profileSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        profileSetup()
    }

    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}


extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
            cell.menyTitleLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: menuArr[indexPath.row], comment: "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 3 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContactUsVC") as? ContactUsVC
            self.navigationController?.pushViewController(vc!, animated:true)
        } else {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SupportWebVC") as? SupportWebVC
            vc?.selectedIndex = indexPath.row
            self.navigationController?.pushViewController(vc!, animated:true)
        }
    }
}

