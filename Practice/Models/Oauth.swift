//
//  Oauth.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/11/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class Oauth: BDBOAuth1SessionManager{
    static let authorize = Oauth(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "tSqnOAIcF9s8GuwxPVPaFfx2o", consumerSecret: "dnICSgHCrUQ4JIPfYvBPgoUk7UdaKGuWJT0o40KsqvG0Affwlt")
    
    
    var success : (()->())?
    var fail : ((Error)->())?
    /**
     Login Result
    */
    func fetchAccessToken(url:URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken) in
            UserMethod.method?.getUserCredential(success: { (UserProfile) in
                CurrentUser.currentUser = UserProfile//get back here if error
                self.success?()
                print("User name:", UserProfile.name!)
                print("User screenname:", UserProfile.screenname!)
                print("User tagline:", UserProfile.tagline!)
            }, failure: { (Error) in
                print("faile")
            })
        }) { (Error) in
            print("Error:",Error?.localizedDescription ?? "Default Error")
        }
    }
    
    func fetchRequestToken(_ success: @escaping () -> (), _ fail: @escaping (Error) -> ()){
        self.success = success
        self.fail = fail
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"twitterdemo://oauth"), scope: nil, success: { (requestToken) in
            print("Request token success!!")
            let autherizeUrl = URL(string:"https://api.twitter.com/oauth/authorize?oauth_token="+(requestToken?.token)!)
            print("URL:",autherizeUrl!)
            print("Token",requestToken?.token! ?? "Tooken Value Missing, while not getting error")
            UIApplication.shared.open(autherizeUrl!, options: [:], completionHandler: nil)
        }) { (Error) in
            print("Request token Fails!! :", Error?.localizedDescription ?? "Getting error without error description")
            self.fail?(Error!)
        }
    }
}
