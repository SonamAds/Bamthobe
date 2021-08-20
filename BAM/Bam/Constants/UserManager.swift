//
//  UserManager.swift
//  Bam
//
//  Created by ADS N URL on 14/04/21.
//

import Foundation
import UIKit
 

class UserManager: NSObject{
    static let userManager = UserManager()
    func isLogin()->Bool{
       return UserDefaults.standard.bool(forKey: "login")
    }
    
    func setlogin(login:Bool){
         UserDefaults.standard.set(login, forKey: "login")
    }
    
    
    func setUserId(id:Int){
      UserDefaults.standard.set(id,forKey: "id")
    }
    
    func getUserId() -> Int {
        let id =  UserDefaults.standard.integer(forKey: "id")
        debugPrint(id)
        if id == nil{
         return 0
        }
        return id
    }
    func setUserName(name:String){
      UserDefaults.standard.set(name,forKey: "name")
    }
    func getUserName() ->String {
        return UserDefaults.standard.string(forKey: "name") ?? ""
    }
    func setUserEmail(email:String){
         UserDefaults.standard.set(email,forKey: "email")
       }
    func getUserEmail() ->String {
       return UserDefaults.standard.string(forKey: "email") ?? ""
    }
     
    func setDeviceToken(token:String){
        UserDefaults.standard.set(token, forKey: "firebaseToken")
    }
    func getDeviceToken() ->String{
        return UserDefaults.standard.string(forKey: "firebaseToken") ?? ""
    }
    
    
    func setApiToken(apiToken:String){
        UserDefaults.standard.set(apiToken, forKey: "token")
    }
    func getApiToken() ->String{
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    func setImage(image:String){
         UserDefaults.standard.set(image, forKey: "image")
    }
    func getImage() ->String {
        return UserDefaults.standard.string(forKey: "image") ?? ""
    }
    
    func setEmailVerifiedAt(emailVerifiedAt:String){
         UserDefaults.standard.set(emailVerifiedAt, forKey: "email_verified_at")
    }
    func getEmailVerifiedAt() ->String{
        return UserDefaults.standard.string(forKey: "email_verified_at") ?? ""
    }
    
    func setGender(gender:String){
        UserDefaults.standard.set(gender, forKey: "gender")
    }
    func getGender() ->String{
        return UserDefaults.standard.string(forKey: "gender") ?? ""
    }
    func setMobile(mobile:String){
        UserDefaults.standard.set(mobile, forKey: "mobile")
    }
    func getMobile() ->String{
        return UserDefaults.standard.string(forKey: "mobile") ?? ""
    }
    
    func setRole(roleId:String){
        UserDefaults.standard.set(roleId, forKey: "role_id")
    }
    func getRole() ->String{
        return UserDefaults.standard.string(forKey: "role_id") ?? ""
    }
    func setType(type:String){
        UserDefaults.standard.set(type, forKey: "type")
    }
    func getType() ->String{
        return UserDefaults.standard.string(forKey: "type") ?? ""
    }
    func setPasswordShow(passwordShow:String){
        UserDefaults.standard.set(passwordShow, forKey: "password_show")
    }
    func getPasswordShow() ->String{
        return UserDefaults.standard.string(forKey: "password_show") ?? ""
    }
//    func setSelectedCatArray(selectedCatArray:Array<Any>){
//        UserDefaults.standard.set(selectedCatArray, forKey: "selectedCatArray")
//    }
//    func getSelectedCatArray() ->Array<Any>{
//        return UserDefaults.standard.array(forKey: "selectedCatArray") ?? []
//    }
//
//    func setLat(lat:Double){
//      UserDefaults.standard.set(lat, forKey: "lat")
//    }
//    func getLat() ->Double{
//      return UserDefaults.standard.double(forKey: "lat")
//    }
//    func setLong(long:Double){
//      UserDefaults.standard.set(long, forKey: "long")
//    }
//    func getLong() ->Double{
//       return UserDefaults.standard.double(forKey: "long")
//    }
//
//    func isFilterStatus()->Bool{
//       return UserDefaults.standard.bool(forKey: "filter")
//    }
//
//    func setFilterStatus(filter:Bool){
//         UserDefaults.standard.set(filter, forKey: "filter")
//    }
//
//    func setScreenSelection(screen:Int){
//        UserDefaults.standard.set(screen, forKey: "screen")
//    }
//    func getScreenSelection() ->Int{
//        return UserDefaults.standard.integer(forKey: "screen") ?? 0
//    }
    
    
}
