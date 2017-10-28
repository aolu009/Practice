//
//  Tweet.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/14/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class Tweet: JSONObject{
    override class var object: TwitObject.object{
        get {
            return TwitObject.object.tweet
        }
    }
    private(set)var text : String?
    private(set)var timeStamp : NSDate?
    private(set)var retwittCount = "0"
    private(set)var favoriteCount = "0"
    private(set)var postId : String?
    private(set)var screenname : String!
    private(set)var timeinterval : String?
    private(set)var retweeted: Bool?
    private(set)var userProfile: UserProfile?
    
    override init(_ response: Any){
        super.init(response)
        text = json["text"] as? String
        if let count = json["favourites_count"] as? Int{
            favoriteCount = String(count)
        }
        if let count = json["retweet_count"] as? Int{
            retwittCount = String(count)
        }
        if let user = json["user"]{
            userProfile = UserProfile(user)
        }
        if let retweet = json["retweeted"]{
            retweeted = retweet as? Bool
        }
        postId = json["id_str"] as? String
        let timeString = json["created_at"] as? String
        if let timeString = timeString{
            let formatter = DateFormatter()
            //Tue Aug 28 21:16:23 +0000 2012
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeString) as NSDate?
            timeinterval = getTimeStemp(timeStamp)
        }
    }
    
    private func getTimeStemp(_ timeInterVal: NSDate?) -> String{
        if Int(timeStamp!.timeIntervalSinceNow) < -21600{
            return String(describing: Int(timeStamp!.timeIntervalSinceNow / -21600)) + "d"
        }
        else if Int(timeStamp!.timeIntervalSinceNow) < -3600 {
            return String(describing: Int(timeStamp!.timeIntervalSinceNow / -21600)) + "h"
        }
        else{
            return String(describing: Int(timeStamp!.timeIntervalSinceNow / -60)) + "m"
        }
    }
    
}
