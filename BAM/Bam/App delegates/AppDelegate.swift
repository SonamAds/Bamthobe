//
//  AppDelegate.swift
//  Bam
//
//  Created by ADS N URL on 16/03/21.
//

import UIKit
//import Firebase
//import FirebaseMessaging
import UserNotifications
//import FBSDKCoreKit
//import FBSDKLoginKit
//import TwitterKit
import IQKeyboardManagerSwift
//import GooglePlaces
//import GoogleMaps


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userManager = UserManager.userManager
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
//        GMSPlacesClient.provideAPIKey("AIzaSyBcyqDtmrobvX9IRFIbjbnEslaGPbwvA30")
//        GMSServices.provideAPIKey("AIzaSyBcyqDtmrobvX9IRFIbjbnEslaGPbwvA30")
//        ApplicationDelegate.shared.application(application , didFinishLaunchingWithOptions:launchOptions)
//
//        TWTRTwitter.sharedInstance().start(withConsumerKey:"0aLTPPaeKehDAyQoQoEz81oPA", consumerSecret:"SqN09TdF7S8jtkmJJsA0ceyt9I7V0tQKUD2Bx2UVUHqWse4848")
        
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
        noificationSetup(application)
        processLogin()
        return true
    }

    
    //Social Delegates
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        //For Twitter
////        var valueTwitter: Bool = true
////        valueTwitter =  TWTRTwitter.sharedInstance().application(app, open: url, options: options)
////
////        return valueTwitter
//
//        if TWTRTwitter.sharedInstance().application(app, open:url, options: options) {
//            return true
//        }
//
//        //For Facebook
//        let appId = "866965127450074"
//        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" { // facebook
//            return ApplicationDelegate.shared.application(app, open: url, options: options)
//        }
//        return false
//
//    }
//
//    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
//        if (extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard) {
//               return false
//           }
//           return true
//       }
//
//
//    func application(_ application: UIApplication,
//                        open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        //For Twitter
//        let options: [String: AnyObject] = [UIApplication.OpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject, UIApplication.OpenURLOptionsKey.annotation.rawValue: annotation as AnyObject]
//
//        let twitterDidhandle = TWTRTwitter.sharedInstance().application(application, open: url, options: options)
//
//        //For Google
//        let googleDidhandle = GIDSignIn.sharedInstance().handle(url)
//
//        return googleDidhandle || twitterDidhandle
//    }
    
    //Login
    func processLogin() {
//        let objVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapVC") as! MapVC
//        self.window?.rootViewController = objVC
//        self.window?.makeKeyAndVisible()
        if userManager.getApiToken() != "" && userManager.getMobile() != "" {
            let objVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let TabViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
            appNavigation.setNavigationBarHidden(true, animated: true)
            UIApplication.shared.windows[0].rootViewController = TabViewController
        } else {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TutorVC") as? TutorVC
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }

}


//MARK:- Notification Setup
//extension AppDelegate: MessagingDelegate {
//    //Referesh token
//    func messaging(_messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        print("Firebase registration token: \(fcmToken)")
//        userManager.setDeviceToken(apiToken: fcmToken)
//    }
//    //End refresh token
//    
////    func messaging(_messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
////        print("received Data Message", remoteMessage.appData)
////    }
//    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//      print("Firebase registration token: \(String(describing: fcmToken))")
//        userManager.setDeviceToken(apiToken: fcmToken)
//      let dataDict:[String: String] = ["token": fcmToken ?? ""]
//      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//      // TODO: If necessary send token to application server.
//      // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
//    
//    func application(application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//      Messaging.messaging().apnsToken = deviceToken
//    }
//
//}

extension AppDelegate: UNUserNotificationCenterDelegate{
    func noificationSetup(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("didReceive Noti", userInfo)
        //            if let messageID = userInfo[gcmMessageIDKey] {
        //                print("", messageID)
        //            }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let userInfo = response.notification.request.content.userInfo as? [String:Any] {
            print("maindata",userInfo)
            
            DispatchQueue.global().sync {
                let userAlert = userInfo["aps"] as? [String: Any]
                let userAlertLink = userAlert!["alert"] as? [String: Any]

//                if (((userAlertLink?["body"] as? String)?.contains("http")) != nil) {
//                    if let url = URL(string: (userAlertLink?["body"] as? String)!) {
//                    UIApplication.shared.open(url)
//                }
//                    guard let url = URL(string: "https://stackoverflow.com") else { return }
//                    UIApplication.shared.open(url)
//                }

            }
        }
                
        completionHandler()
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if let userInfo = notification.request.content.userInfo as? [String:Any] {
            print("willPresent Noti", userInfo)
//            if let messageID = userInfo[gcmMessageIDKey] {
//                print("", messageID)
//            }
//            let userinfoJson = JSON(userInfo)
//            print("", userinfoJson)
            completionHandler([.alert, .badge, .sound])
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//            if let messageID = userInfo[gcmMessageIDKey] {
//                print("", messageID)
//            }
    }
    
}


//MARK:- Other ApppDelegate Methods
extension AppDelegate {
    
    //Make Root View Controller
//    func makeRootViewController() {
//        let storyboard = UIStoryboard(name: StoryboardID.main, bundle: nil)
//
//        guard let customTabbarViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerID.customTabbarViewController) as? CustomTabBarViewController,
//            let leftMenuViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerID.sideMenuVC) as? SideMenuVC
////            let rightMenuController = storyboard.instantiateViewController(withIdentifier: ViewControllerID.rightMenuViewController) as? RightMenuViewController
//        else {
//            return
//        }
//
//        let navigationViewController: UINavigationController = UINavigationController(rootViewController: customTabbarViewController)
//
//        //Create Side Menu View Controller with main, left and right view controller
//        let sideMenuViewController = SlideMenuController(mainViewController: navigationViewController, leftMenuViewController: leftMenuViewController/*, rightMenuViewController: rightMenuController*/)
//        window?.rootViewController = sideMenuViewController
//        window?.makeKeyAndVisible()
//    }
}
