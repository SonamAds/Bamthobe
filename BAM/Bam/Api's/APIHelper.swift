//
//  APIHelper.swift
//  Bam
//
//  Created by ADS N URL on 14/04/21.
//

import Foundation
import Alamofire

let base_url = "https://bamthobe.com/admin/api/"//"http://projects.adsandurl.com/bam_thobe/api/"//"http://bamthode.herokuapp.com/public/api/"//

//"http://bamthode.herokuapp.com/public/api/"//
protocol ApiResponseDelegate {
    func onSuccess(responseData:AFDataResponse<Any>,tag:String)
    func onFailure(msg:String)
    func onError(error:AFError)
    
}

class ApiHelper:NSObject{
    var responseDelegate:ApiResponseDelegate?
    var userManager = UserManager.userManager
    func GetData(urlString:String,tag:String) {
        LoadingIndicatorView.show()
        let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
         print("urlString     \(base_url)\(newUrl!)")
        print(userManager.getApiToken())
        AF.request(base_url+(newUrl ?? ""),method: .get, headers: ["Authorization":"\(userManager.getApiToken())"/*,"Content-Type":"application/json"*/]).responseJSON { response in
            guard let delegate = self.responseDelegate else {
                LoadingIndicatorView.hide()
                return
            }
            
            if let errorvalue = response.error{
                delegate.onError(error: errorvalue)
                LoadingIndicatorView.hide()
            }else {
                if (response.value != nil){
                    LoadingIndicatorView.hide()
                    delegate.onSuccess(responseData: response, tag: tag)
                   
                }else{
                    LoadingIndicatorView.hide()
                    delegate.onFailure(msg: "Some error occurred. Please try after some time.")
                }
            }
        }
    }

    func PostData(urlString:String,tag:String,params : [String:Any]) {
        LoadingIndicatorView.show()
           let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
           print("urlString     \(base_url)\(newUrl!)")
           let params = params
           print("params    \(params)")
        print(userManager.getApiToken())
        if Int(tag)! < 0{
        AF.request(base_url+(newUrl ?? ""),method: .post, parameters:params).responseJSON { response in
              guard let delegate = self.responseDelegate else{
                LoadingIndicatorView.hide()
                   return
               }
              if let errorvalue = response.error{
                LoadingIndicatorView.hide()
                  delegate.onError(error: errorvalue)
              } else {
                  if (response.value != nil){
                    LoadingIndicatorView.hide()
                      delegate.onSuccess(responseData: response, tag: tag)
                  } else {
                    LoadingIndicatorView.hide()
                      delegate.onFailure(msg: "Some error occurred. Please try after some time.")
                  }
              }
           }
            
        } else {
            AF.request(base_url+(newUrl ?? ""),method: .post,parameters:params,headers: ["Authorization":"\(userManager.getApiToken())"]).responseJSON { response in
                  guard let delegate = self.responseDelegate else{
                       return
                   }
                  if let errorvalue = response.error{
                      delegate.onError(error: errorvalue)
                    LoadingIndicatorView.hide()
                  } else {
                      if (response.value != nil){
                        LoadingIndicatorView.hide()
                          delegate.onSuccess(responseData: response, tag: tag)
                      } else {
                        LoadingIndicatorView.hide()
                          delegate.onFailure(msg: "Some error occurred. Please try after some time.")
                      }
                  }
               }
            }
    }
    
    func DeleteData(urlString:String,tag:String,params : [String:Any]) {
        LoadingIndicatorView.show()
           let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
           print("urlString     \(base_url)\(newUrl!)")
           let params = params
           print("params    \(params)")
           AF.request(base_url+(newUrl ?? ""),method: .delete,parameters:params ).responseJSON { response in
              guard let delegate = self.responseDelegate else{
                LoadingIndicatorView.hide()
                   return
               }
              if let errorvalue = response.error{
                LoadingIndicatorView.hide()
                  delegate.onError(error: errorvalue)
              }else {
                  if (response.value != nil){
                    LoadingIndicatorView.hide()
                      delegate.onSuccess(responseData: response, tag: tag)
                  }else{
                    LoadingIndicatorView.hide()
                      delegate.onFailure(msg: "Some error occurred. Please try after some time.")
                  }
              }
           }
    }
    
    func UploadReq(urlString:String,tag:String, params : [String:Any],upImage:[UIImage]){
        LoadingIndicatorView.show()
        let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("urlString     \(base_url)\(newUrl!)")
        let params = params
        let imageParamName = "TopicPhotos"
        print("params    \(params)")
       // let header = ["Authorization" : "\(userManager.getApiToken())",
                     //            "Content-Type": "application/json"]
//,"Content-Type":"application/json"]
        print(userManager.getApiToken())
              AF.upload(multipartFormData: { (multipartFormData) in
                  for (key, value) in params {
                      multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                  }
                 for i in 0..<upImage.count {
                    if let datas = upImage[i].pngData() {
                          multipartFormData.append(datas, withName: "\(imageParamName)\(i)", fileName: "image.png", mimeType: "image/png")
                      }
                }

              }, to: base_url+(newUrl ?? ""), usingThreshold: UInt64.init(), method: .post, headers: ["Authorization":"\(userManager.getApiToken() ?? "")"]).responseJSON {
                response in
                guard let delegate = self.responseDelegate else{
                    LoadingIndicatorView.hide()
                     return
                 }
                if let errorvalue = response.error{
                    LoadingIndicatorView.hide()
                    delegate.onError(error: errorvalue)
                }else {
                    if (response.value != nil){
                        LoadingIndicatorView.hide()
                        delegate.onSuccess(responseData: response, tag: tag)
                    } else {
                        LoadingIndicatorView.hide()
                        delegate.onFailure(msg: "Some error occurred. Please try after some time.")
                    }
                }
                
        }
        
    }
    
     func UploadReq(urlString:String, tag:String, params:[String:Any], upImage:UIImage){
        LoadingIndicatorView.show()
        let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("urlString     \(base_url)\(newUrl!)")
        print(userManager.getApiToken(), params)
      
//        let parameter = ["":""]
//        let headers: HTTPHeaders
//        headers = ["Content-Type": "multipart/form-data", "Authorization":"\(userManager.getApiToken() ?? "")"/*,
//                    "Content-Disposition" : "form-data"*/]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            multipartFormData.append(upImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "file.jpeg", mimeType: "image/jpeg")
            },to: base_url+(newUrl ?? ""), method: .post,headers: ["Authorization":"\(userManager.getApiToken())", "Content-Type": "multipart/form-data"]).responseJSON { resp in
                guard let delegate = self.responseDelegate else{
                    LoadingIndicatorView.hide()
                    return
                }
                if let errorvalue = resp.error{
                    LoadingIndicatorView.hide()
                    delegate.onError(error: errorvalue)
                } else {
                    if (resp.value != nil){
                        LoadingIndicatorView.hide()
                        print("")
                        delegate.onSuccess(responseData: resp/*.response as! AFDataResponse*/, tag: tag)
                    } else{
                        LoadingIndicatorView.hide()
                        delegate.onFailure(msg: "Some error occurred. Please try after some time.")
                }
            }
        }
        
    }
       
}
