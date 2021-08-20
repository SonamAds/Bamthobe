//
//  UIViewController + Extensions.swift
//  Bam
//
//  Created by ADS N URL on 17/03/21.
//

import UIKit
import SideMenu


extension UIViewController {
    
    
    //For Email Validation
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func setupSideMenu() {
                
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeftSideMenuVC") as? LeftSideMenuVC
                   //vc?.isLanguageSelect = false
        let menuLeftNavigationController = SideMenuNavigationController(rootViewController: vc!)
                    // menuLeftNavigationController.accessibilityLanguage = .some(L102Language.currentAppLanguage())
        SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
                    SideMenuManager.default.menuPresentMode = modes[0]
        SideMenuManager.default.menuPushStyle = .default
        SideMenuManager.default.leftMenuNavigationController?.setNavigationBarHidden(true, animated: false)
       // SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
       // SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuFadeStatusBar = false
            SideMenuManager.default.menuWidth =  min(round(min((self.navigationController!.view.frame.width), (self.navigationController!.view.frame.height)) * 0.75), 350)
    }
        
    @IBAction func menulefttAction(_ sender: Any) {
        let userManager = UserManager.userManager
        if userManager.getApiToken() == "" {
            navigateToLogin()
        } else {
            present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
        }
    }
    
    func navigateToLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let objVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
        appNavigation.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows[0].rootViewController = appNavigation
    }
    
    
//    //Set Navigation Bar Item Image for TabBar
//    func setNavigationBarItem() {
//        guard let menuImage = UIImage(named: "ic_menu"),
//            let notificationImage = UIImage(named: "ic_notifications") else {
//            print("Not found menu or notification image")
//            return
//        }
//        addLeftBarButtonWithImage(menuImage)
////        addRightBarButtonWithImage(notificationImage)
//    }
    
    //Load the UIView using Nibname
    func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    //Check current viewcontroller is presented, Pushed or not
    func isModal() -> Bool {
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.first != self {
                return false
            }
        }
        if self.presentingViewController != nil {
            return true
        }
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        }
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
    
    //Get topViewController from UIApllication Window or Current Navigation Controller
    public func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

