//
//  UserAccount.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/11/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class UserAccount: BDBOAuth1SessionManager {
    // Singleton tracks and updates currently logged in user's account.
    static let currentUser = UserAccount(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "tSqnOAIcF9s8GuwxPVPaFfx2o", consumerSecret: "dnICSgHCrUQ4JIPfYvBPgoUk7UdaKGuWJT0o40KsqvG0Affwlt")
    
    private var currentUser: UserProfile?{
        get{
            return CurrentUser.currentUser
        }
    }
    private var name: String?{
        return currentUser?.name
    }
    var isSignedIn: Bool {
        get {
            return currentUser != nil
        }
    }
    func login(success:@escaping ()->(),fail: @escaping () -> ()){
        deauthorize()
        Oauth.authorize?.fetchRequestToken({ 
            success()
        }, { (error) in
            print(error)
            fail()
        })
        
    }
    func logout(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserAccount.event.didSignOut), object: nil)
        CurrentUser.currentUser = nil
        deauthorize()
    }
    
    
    struct event{
        static let didSignOut = "didSignOut"
    }
}
