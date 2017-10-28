//
//  UserMethod.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/14/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class UserMethod: BDBOAuth1SessionManager{
    static let method = UserMethod(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "tSqnOAIcF9s8GuwxPVPaFfx2o", consumerSecret: "dnICSgHCrUQ4JIPfYvBPgoUk7UdaKGuWJT0o40KsqvG0Affwlt")
    /*
     parameterize string
    */
    func getUserCredential( success: @escaping (UserProfile) -> Void, failure:@escaping (Error) -> Void ) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
            let user = UserProfile.init(response)
            success(user)
        }, failure: { (task: URLSessionDataTask?, Error) -> Void in
            failure(Error)
        })
    }
    
    func updateProfile(success: @escaping (UserProfile) -> Void, failure:@escaping (Error) -> Void){
        get("1.1/account/update_profile.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
            let user = UserProfile.init(response)
            success(user)
        }, failure: { (task: URLSessionDataTask?, Error) -> Void in
            failure(Error)
        })
    }
    
    //Get user info
    func getUserInfo(screen_name: String, success: @escaping (UserProfile) -> Void, failure:@escaping (Error) -> Void ) {
        let parameter = ["screen_name":screen_name]
        get("1.1/users/show.json", parameters: parameter, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
            let user = UserProfile(response)
            success(user)
        }, failure: { (task: URLSessionDataTask?, Error) -> Void in
            failure(Error)
        })
    }
}
