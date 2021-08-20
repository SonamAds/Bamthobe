//
//  TabBarVC.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit

class TabBarVC: UITabBarController {

    var userManager = UserManager.userManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tabBar.items?[0].title =         LocalizationSystem.sharedInstance.localizedStringForKey(key: "Home", comment: "")
//        tabBar.items?[1].title =         LocalizationSystem.sharedInstance.localizedStringForKey(key: "Cart", comment: "")
//        tabBar.items?[2].title =         LocalizationSystem.sharedInstance.localizedStringForKey(key: "Orders", comment: "")
//        tabBar.items?[3].title =         LocalizationSystem.sharedInstance.localizedStringForKey(key: "Profile", comment: "")

//        self.delegate = self
        self.tabBarController?.delegate = self
    }
}


extension TabBarVC: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
        if item.title == "Cart" || item.title == "Orders" || item.title == "Profile" {
            if userManager.getApiToken() == "" {
                navigateToLogin()
            }
        }
    }

    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
        let tabBarIndex = tabBarController.selectedIndex
            if tabBarIndex == 1 || tabBarIndex == 2 || tabBarIndex == 3 {
                if userManager.getApiToken() == "" {
                    navigateToLogin()
                }
            }

    }
}
