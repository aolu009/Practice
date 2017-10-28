//
//  UserProfile.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/11/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class UserProfile: JSONObject{
    override class var object: TwitObject.object{
        get {
            return TwitObject.object.profile
        }
    }
    private(set)var name : String?
    private(set)var screenname : String?
    private(set)var profileUrl : URL?
    private(set)var profileBkGndImageUrl: URL?
    private(set)var tagline: String?
    private(set)var numOfTweet: String?
    private(set)var numOfFollowings: String?
    private(set)var numOfFollowers: String?
    //# tweets, # following, # followers //followers_count //following, statuses_count
    
    override init(_ response: Any){
        //print(response)
        super.init(response)
        if let profileUrlString = json["profile_image_url_https"] as! String?{
            profileUrl = URL(string: profileUrlString)
        }
        if let profilebackgroundUrlString = json["profile_banner_url"] as! String?{//profile_background_image_url_https
            profileBkGndImageUrl = URL(string: profilebackgroundUrlString)
        }
        name = json["name"] as? String
        if let scrname = json["screen_name"] as? String{
            screenname = "@" + scrname
        }
        numOfTweet = String(json["statuses_count"] as! Int)
        numOfFollowers = String(json["followers_count"] as! Int)
        numOfFollowings = String(json["friends_count"] as! Int)
        tagline = json["description"] as? String
    }
    
    struct key{
        
    }
}
