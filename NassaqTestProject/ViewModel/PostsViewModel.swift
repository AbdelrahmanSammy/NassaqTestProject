//
//  PostsViewModel.swift
//  NassaqTestProject
//
//  Created by KemoTroy on 8/12/18.
//  Copyright © 2018 BigFour. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

@objc protocol PostsViewModelManagerDelegate {
   @objc optional func PostRequestResponse(PostsArary:[PostsModel])
    @objc optional func FriendsRequestResponse(FriendsArary:[FriendModel])
}


class  PostsViewModel: NSObject {
    
    
    var PostsDelegate:PostsViewModelManagerDelegate?
    static let PostsViewModelRequest = PostsViewModel()

    var PostArray = [PostsModel]()
    var FriendArray = [FriendModel]()



    
    
     func GetPosts () {
        RequestManager.Request.requestWithParameters(andURL: Posts, Header: nil,forAPI: Nassaq_APIS.Posts.rawValue, Meth: .get,Parparameters: nil)
        RequestManager.Request.delegate = self
        
        print("Posts View Model post Done")

}
    func GetFriends()
    
    {
        
        
        RequestManager.Request.requestWithParameters(andURL: Friends, Header: nil,forAPI: Nassaq_APIS.Friends.rawValue, Meth: .get,Parparameters: nil)
        RequestManager.Request.delegate = self
        
        
        
    }
    
    
    
    
}

extension PostsViewModel:RequestManagerDelegate  {
    
    func requestSuccessWithResponse(responseJSON: JSON, forAPI: Int) {
        
        switch forAPI {
        case Nassaq_APIS.Posts.rawValue:
            print("Enter")
            for (_,subJson):(String, JSON) in responseJSON["posts"]
            {
                let itemObject = PostsModel()
                itemObject.post_image = subJson["post_image"].stringValue
                itemObject.profile_image = subJson["profile_image"].stringValue
                itemObject.country = subJson["country"].stringValue
                itemObject.date = subJson["date"].stringValue
                itemObject.user_name = subJson["user_name"].stringValue
                
                let date = Date()
                let formatter = DateFormatter()
                
                let tempLocale = formatter.locale
                formatter.dateFormat = "y-MM-dd'T'HH:mm:ss+HH:mm"
                let PostDate = formatter.date(from: itemObject.date)
                formatter.dateFormat = "yyy-MM-dd"
                
                let calendar = Calendar.current
                let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
                let differenceOfDate = Calendar.current.dateComponents(components, from: PostDate!, to: date)
                
                print (differenceOfDate)
                print(differenceOfDate.year)
                print(differenceOfDate.month)
                print(differenceOfDate.day)
                print(differenceOfDate.hour)
                if differenceOfDate.year != 0 {
                    
                    itemObject.date = (differenceOfDate.year?.description)! + " year ago"
                    
                }
                else  if differenceOfDate.month != 0 {
                    
                    itemObject.date = (differenceOfDate.month?.description)! + " month ago"
                    
                }
                else  if differenceOfDate.day != 0 {
                    
                    itemObject.date = (differenceOfDate.day?.description)! + " day ago"
                    
                }
                else  if differenceOfDate.hour != 0 {
                    
                    itemObject.date = (differenceOfDate.hour?.description)! + " hours ago"
                    
                }
                else {
                    itemObject.date = (differenceOfDate.minute?.description)! + " minute ago"
                }
                
                
                PostArray.append(itemObject)
                
            }
            
            self.PostsDelegate?.PostRequestResponse!(PostsArary: PostArray)
            
        case Nassaq_APIS.Friends.rawValue:
            
            
            
            for (_,subJson):(String, JSON) in responseJSON["users"]
            {
                let itemObject = FriendModel()
                itemObject.user_name = subJson["user_name"].stringValue
                itemObject.profile_image = subJson["profile_image"].stringValue
                
                FriendArray.append(itemObject)
                
                
                
                
            }

            self.PostsDelegate?.FriendsRequestResponse!(FriendsArary: FriendArray)
            NotificationCenter.default.post(name: NSNotification.Name("UpdatePosts"), object: nil)


        default:
            break
        }
        
    }
    
    func requestFailedWithMessage(message: String) {
        print("requestFailedWithMessage is  =",message)
        
    }
    
    func requestFailedWithError(error: String) {
        print("requestFailedWithError is  =",error)
        
    }
    
    
    
    
    
    
}

