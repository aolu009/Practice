//
//  CurrentUser.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/14/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit


class CurrentUser: NSObject{
    //static let profile = CurrentUser()
    private override init() {
        super.init()
    }
    static var _currentUser: UserProfile?
    class var currentUser: UserProfile?{
        get{
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                if let userData = userData{
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: [])
                    _currentUser = UserProfile(dictionary)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.json, options: [])
                defaults.set(data,forKey: "currentUserData")
            }
            else{
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}
