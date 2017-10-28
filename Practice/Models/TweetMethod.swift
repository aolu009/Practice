//
//  TweetMethod.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/14/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TweetMethod: BDBOAuth1SessionManager{
    static let method = TweetMethod(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "tSqnOAIcF9s8GuwxPVPaFfx2o", consumerSecret: "dnICSgHCrUQ4JIPfYvBPgoUk7UdaKGuWJT0o40KsqvG0Affwlt")
    
    
    
    // Timeline method
    func timeline( success: @escaping ([Tweet]) -> Void, failure:@escaping (Error) -> Void ) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
            //print("Success with response:",response)
            success(self.arrayOfTweets(response))
        }, failure: { (task: URLSessionDataTask?, Error) -> Void in
            failure(Error)
        })
    }
    func userTimeline(screen_name: String, success: @escaping ([Tweet]) -> Void, failure:@escaping (Error) -> Void ) {
        let parameter = ["screen_name":screen_name]
        get("1.1/statuses/user_timeline.json", parameters: parameter, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
            //print("Success with response:",response)
            success(self.arrayOfTweets(response))
        }, failure: { (task: URLSessionDataTask?, Error) -> Void in
            failure(Error)
        })
    }
    
    
    //Get mentions
    func getMentions(success: @escaping ([Tweet]) -> Void, failure:@escaping (Error) -> Void ) {
        get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
            //print("Success with response:",response)
            success(self.arrayOfTweets(response))
        }, failure: { (task: URLSessionDataTask?, Error) -> Void in
            failure(Error)
        })
    }
    
    /*Retweet method*/
    func retweet( tweetId: String, success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void ) {
        //let validTweetString = TweetValidator().validTween(tweetString)
        let parameters = ["id": tweetId]
        post("1.1/statuses/retweet/\(tweetId).json", parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
            //print("Success with response:",response)
            let tweet = Tweet(response)
            success(tweet)
        }, failure: { (task: URLSessionDataTask?, Error) -> Void in
            failure(Error)
        })
    }
    // Favorite a tweet
    func favorite( tweetId: String, success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void ) {
        //let validTweetString = TweetValidator().validTween(tweetString)
        let parameters = ["id": tweetId]
        post("1.1/favorites/create.json", parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
            let tweet = Tweet(response)
            success(tweet)
        }, failure: { (task: URLSessionDataTask?, Error) -> Void in
            failure(Error)
        })
    }
    
    func composeOrReply(reply: Bool, postId:String?, tweetString: String){
        func compose( reply: Bool, postId:String?, tweetString: String, success: @escaping (NSDictionary) -> Void, failure: @escaping (Error) -> Void ) {
            var message : [String:String]
            if reply == true{
                message = ["status": tweetString,"in_reply_to_status_id":postId!]
            }
            else{
                message = ["status": tweetString]
            }
            post("1.1/statuses/update.json", parameters: message, progress: nil, success: { (task: URLSessionDataTask, response: Any) -> Void in
                //print("Success with response:",response)
                let tweet = response as! NSDictionary
                success(tweet)
            }, failure: { (task: URLSessionDataTask?, Error) -> Void in
                failure(Error)
            })
        }
    }
    
    private func arrayOfTweets(_ responses: Any) -> [Tweet] {
        var tweets = [Tweet]()
        let responses = responses as! [Any]
        for response in responses{
            tweets.append(Tweet(response))
        }
        return tweets
    }
}
