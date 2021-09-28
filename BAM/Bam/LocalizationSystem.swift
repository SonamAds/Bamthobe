//
//  LocalizationSystem.swift
//  Bam
//
//  Created by ADS N URL on 25/06/21.
//

import Foundation
import UIKit

class LocalizationSystem:NSObject {

    var bundle: Bundle!

    class var sharedInstance: LocalizationSystem {
        struct Singleton {
            static let instance: LocalizationSystem = LocalizationSystem()
        }
        return Singleton.instance
    }

    override init() {
        super.init()
        bundle = Bundle.main
    }

    func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }

    func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }

    //MARK:- setLanguage
    func setLanguage(languageCode:String) {
        var appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        appleLanguages.remove(at: 0)
        appleLanguages.insert(languageCode, at: 0)
        UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize() //needs restrat

        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
//            resetLocalization()
//            bundle = languageDirectoryPath
            bundle = Bundle.init(path: languageDirectoryPath)
        } else {
            resetLocalization()
        }
    }

    //MARK:- resetLocalization
    //Resets the localization system, so it uses the OS default language.
    func resetLocalization() {
        bundle = Bundle.main
    }

   // MARK:- getLanguage
     //Just gets the current setted up language.
    func getLanguage() -> String {
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        let prefferedLanguage = appleLanguages[0]
        if prefferedLanguage.contains("-") {
            let array = prefferedLanguage.components(separatedBy: "-")
            return array[0]
        }
        return prefferedLanguage
    }

}





var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {

    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {

        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
              let bundle = Bundle(path: path) else {

            return super.localizedString(forKey: key, value: value, table: tableName)
            }

        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {

    class func setLanguage(_ language: String) {

        defer {

            object_setClass(Bundle.main, AnyLanguageBundle.self)
        }

        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
//    class func getLanguage() -> String {
//        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
//        let prefferedLanguage = appleLanguages[0]
//        if prefferedLanguage.contains("-") {
//            let array = prefferedLanguage.components(separatedBy: "-")
//            return array[0]
//        }
//        return prefferedLanguage
//    }
}

