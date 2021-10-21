//
//  LeftSideMenuVC.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit

class LeftSideMenuVC: UIViewController {
    
    // MARK:- Variables
    private let menuArr = [/*"Home",*/ "My Orders", /*"Offers", */"Loyality Points", "Gift Card", "Scan QR Code", "Address Book", "My Appointments"/*, "My Measurements"*/, "Settings", "Rate Our App", "Sign Out"]
    var userManager = UserManager.userManager
//    private let menuImgArr = [#imageLiteral(resourceName: "user"),#imageLiteral(resourceName: "Payment Method"),#imageLiteral(resourceName: "revenu"),#imageLiteral(resourceName: "atm"),#imageLiteral(resourceName: "INvite"),#imageLiteral(resourceName: "help"),#imageLiteral(resourceName: "Sign Out")]
    
    
    // MARK:- IBOutlets
     
    @IBOutlet weak var profileView:UIView!
    @IBOutlet weak var profileImg:UIImageView!
    @IBOutlet weak var profileNameLbl:UILabel!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    
    // MARK:- Helping Methods
    
    private func setupUI(){
        self.profileView.layer.cornerRadius = profileView.frame.height/2.0 + 10
    }
    
    func profileSetup() {
        let url: String!
        url = userManager.getImage()

        print("", url)
        self.profileImg.sd_setImage(with: URL(string: url ?? ""), placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            self.profileImg.image = image
            self.profileImg.contentMode = .scaleToFill
        }
        self.profileNameLbl.text = userManager.getUserName()
    }
    
}


//MARK: - UITable Delegates And DataSource
extension LeftSideMenuVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
            cell.menyTitleLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: menuArr[indexPath.row], comment: "")

//        if indexPath.row == 0 || indexPath.row == 6 {
//            cell.menuImg.image = menuImgArr[indexPath.row]
//        } else {
//            cell.menuImg.image = menuImgArr[indexPath.row].withRenderingMode(.alwaysTemplate)
////            cell.menuImg.tintColor = AppConstant.Colours.sideMenuImageColour
//        }
        
//        for element in UserDefaults.standard.dictionaryRepresentation() {
//            if element.key != "firebaseToken" {
//                UserDefaults.removeObject(<#T##self: UserDefaults##UserDefaults#>)
//            }
//        }
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        /*case 0:
//            guard let tabViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC else {
//                return
//                }
//            let navigationViewController = UINavigationController(rootViewController: tabViewController)
//            slideMenuController()?.changeMainViewController(navigationViewController, close: true)
            
            let objVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let TabViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
            appNavigation.setNavigationBarHidden(true, animated: true)
            UIApplication.shared.windows[0].rootViewController = TabViewController
       
//        case 6:
//            let urlString = BASE_URL + logout
//            if UserDefaults.standard.string(forKey: UD_LoginType) == "Twitter" {
//                clearAccounts()
//            } else if UserDefaults.standard.string(forKey: UD_LoginType) == "Google" {
////                UserDefaults.standard.removeObject(forKey: UD_Token)
//                GIDSignIn.sharedInstance().signOut()
//            } else if UserDefaults.standard.string(forKey: UD_LoginType) == "Facebook" {
//                AccessToken.current = nil
////                UserDefaults.standard.removeObject(forKey: UD_Token)
//            } else {
////                UserDefaults.standard.removeObject(forKey: UD_Token)
//            }
//            Webservice_logoutHit(url: urlString)
        */
        case /*1*/0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            mainTabBarController.selectedIndex = 2
            mainTabBarController.modalPresentationStyle = .fullScreen
            self.present(mainTabBarController, animated: true, completion: nil)
//            self.present(MyOrdersVC, animated: true, completion: nil)

       /* case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyOffersVC") as! MyOffersVC
            self.navigationController?.pushViewController(vc, animated: true)
          */
        case 1://3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoyaltyPointsVC") as! LoyaltyPointsVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "GiftListVC") as! GiftListVC
            self.navigationController?.pushViewController(vc, animated: true)
       
        case 3:
//            let vc = storyboard?.instantiateViewController(withIdentifier: "SenderGiftDetailVC") as! SenderGiftDetailVC
//            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddresssBookVC") as! AddresssBookVC
            self.navigationController?.pushViewController(vc, animated: true)
           
        case 5:
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyAppointmentsVC") as! MyAppointmentsVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        /*case 8:
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyMeasurmentsVC") as! MyMeasurmentsVC
            self.navigationController?.pushViewController(vc, animated: true)*/
            
        case 6:
            let vc = storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            self.navigationController?.pushViewController(vc, animated: true)
//        case :
//            let vc = storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
//            self.navigationController?.pushViewController(vc, animated: true)
       
        case 8:
//            let defaults = UserDefaults.standard
//            let dictionary = defaults.dictionaryRepresentation()
//            dictionary.keys.forEach { key in
//                print(key)
//                if key == UD_FirebaseToken {
//                } else {
//                    defaults.removeObject(forKey: key)
//                }
//            }
            userManager.setlogin(login: false)
            userManager.setApiToken(apiToken: "")
            userManager.setImage(image: "")
            userManager.setMobile(mobile: "")
            userManager.setUserName(name: "")
            userManager.setUserEmail(email: "")
            navigateToLogin()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let leftFooterView = loadFromNibNamed(ViewID.leftFooterView) as? LeftFooterView else {
            print("Left Header view not found")
            return nil
        }
        return leftFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    

//    //For Youtube Logout
//    func clearAccounts() {
//        for session in TWTRTwitter.sharedInstance().sessionStore.existingUserSessions() {
//            if let session = session as? TWTRSession {
//                TWTRTwitter.sharedInstance().sessionStore.logOutUserID(session.userID)
//            }
//        }
////        dismiss(animated: true) {
////        }
////        Webservice_logoutHit(url: urlString)
//    }
//
}


//extension LeftSideMenuVC {
//    func Webservice_logoutHit(url: String) {
//        WebServices().CallGlobalAPI(url: url, parameter: [:], methods: "GET", passHeader: true, uiView:self.view, progressView:true) {
//            (response) in
//            if response["success"] == true {
//
//                let defaults = UserDefaults.standard
//                let dictionary = defaults.dictionaryRepresentation()
//                dictionary.keys.forEach { key in
//                    print(key)
//                    if key == UD_FirebaseToken {
//                    } else {
//                        defaults.removeObject(forKey: key)
//                    }
//                }
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
//                self.navigationController?.pushViewController(vc!, animated: true)
//            } else {
////                self.showAlertMessage(titleStr: "Error", messageStr: response["error"].stringValue)
//                let defaults = UserDefaults.standard
//                let dictionary = defaults.dictionaryRepresentation()
//                dictionary.keys.forEach { key in
//                    print(key)
//                    if key == UD_FirebaseToken {
//                    } else {
//                        defaults.removeObject(forKey: key)
//                    }
//                }
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
//                self.navigationController?.pushViewController(vc!, animated: true)
//            }
//        }
//    }
//}
