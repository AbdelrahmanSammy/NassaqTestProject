
//
//  RequestManager.swift
//  Party
//
//  Created by KemoTroy on 7/28/17.
//  Copyright © 2017 IT-Smart. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

protocol RequestManagerDelegate {
    func requestSuccessWithResponse(responseJSON:JSON ,forAPI: Int)
    func requestFailedWithMessage(message: String)
    func requestFailedWithError(error: String)
}

class RequestManager: NSObject {
    var delegate: RequestManagerDelegate?
    static let Request = RequestManager()

   
         func requestWithParameters(andURL: String,Header: HTTPHeaders? = nil ,forAPI: Int,Meth:HTTPMethod, Parparameters: [String:AnyObject]? = nil) {
            
            print("URL = " , andURL)
            
        Alamofire.request(andURL, method: Meth, parameters: Parparameters, encoding: JSONEncoding.default, headers: Header).validate()
            

       

        .responseJSON {
            response in 
         

            switch response.result {
                
            case .success:
                print("Validation Successful")
                let jsonValue = response.result.value!
                var values:JSON = JSON(response.result.value as Any)
                print(jsonValue,"&&&&")
                let Success = values["Success"].bool
                let message  = values["message"].string
                print(message)
                print(response.response?.statusCode,"&^^&")
                let status:String = String(describing: Success)
                print(status,"@#@")
            self.delegate?.requestSuccessWithResponse(responseJSON: values, forAPI: forAPI)
                
            break
            case .failure(let error):
                
                print(response.data,"no")
                var values:JSON = JSON(response.data as Any)
                print("Values IS =",values)
                   let Message = values["message"].stringValue
        
                
                
                if (response.response?.statusCode == 400){
              
                    self.delegate?.requestFailedWithMessage(message: Message)
                    
                print(values,"##")
                print(Message,"#$#")
                
                }
                else if (response.response?.statusCode == 404){
                    
                    self.delegate?.requestFailedWithMessage(message: Message)
                    
                    print(values,"##")
                    print(Message,"#$#")
                    
                }
                else{
                print("ERROR \(error.localizedDescription))")
                self.delegate!.requestFailedWithError(error: error.localizedDescription)
                }
        
                break
            }
        }
        
        
        
    }
    
    
}

