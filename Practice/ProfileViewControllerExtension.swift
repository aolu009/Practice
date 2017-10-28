//
//  ProfileViewControllerExtension.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/20/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//
import UIKit

extension ProfileViewController{
    func setupProfileCell(_ tableView: UITableView) -> ProfileTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.isUserInteractionEnabled = false
        if let backgroungImageUrl = user?.profileBkGndImageUrl{
            cell.backGroungImage.setImageWith(backgroungImageUrl)
            
        }
        if let profileImageUrl = user?.profileUrl{
            cell.profileImage.setImageWith(profileImageUrl)
        }
        cell.nameText.text = user?.name
        cell.screenNameText.text = user?.screenname
        cell.numOfFollowers.text = user?.numOfFollowers
        cell.numOfFollowings.text = user?.numOfFollowings
        cell.numOfTweets.text = user?.numOfTweet
        return cell
    }
    func setupTimelineCell(_ tableView: UITableView,_ index: Int) -> TimelineTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell") as! TimelineTableViewCell
        //TODO: Dummy tweet when no tweet available
        let tweet = tweets[index]
        if let user = tweet.userProfile{
            cell.userProfileImage.setImageWith(user.profileUrl!) // need to avoid nil
            cell.nameLabel.setTitle(user.name, for: .normal)
            cell.screenNameLabel.text = user.screenname
        }
        cell.delegate = self
        cell.postId = tweet.postId
        cell.retweetCount = tweet.retwittCount
        cell.favoriteCount = tweet.favoriteCount
        cell.timeIntervalLabel.text = tweet.timeinterval
        cell.tweetTextLabel.text = tweet.text
        cell.retweeted.isHidden = !tweet.retweeted!
        return cell
    }
    
    
    func setupTable(){
        profileTimelineTableView.delegate = self
        profileTimelineTableView.dataSource = self
        profileTimelineTableView.estimatedRowHeight = 300
        profileTimelineTableView.rowHeight = UITableViewAutomaticDimension
        profileTimelineTableView.layoutIfNeeded()
    }
    
    func getAsset(){
        if page == pageType.accountTimeline || page == pageType.timeline{
            getAccountTimeline()
        }else if page == pageType.mentions{
            TweetMethod.method?.getMentions(success: { (tweets) in
                self.tweets = tweets
                self.profileTimelineTableView.reloadData()
            }, failure: { (error) in
                print(error)
            })
        }else{
            self.profileTimelineTableView.reloadData()
        }
    }
    func getAccountTimeline(){
        TweetMethod.method?.timeline(success: { (tweets) in
            self.tweets = tweets
            self.user = CurrentUser.currentUser
            self.topLeftButton.setTitle("Logout", for: .normal)
            self.profileTimelineTableView.reloadData()
            
        }, failure: { (error) in
            print(error)
        })
    }
    
    func getUserTimeline(with screenName: String, complete: @escaping (_ user: UserProfile,_ tweets: [Tweet]) -> ()){
        UserMethod.method?.getUserInfo(screen_name: screenName, success: { (user) in
            TweetMethod.method?.userTimeline(screen_name: user.screenname!, success: { (tweets) in
                complete(user, tweets)
            }, failure: { (error) in
                print(error)
            })
        }, failure: { (error) in
            print(error)
        })
    }
    func presentUserProfilePage(withUser user: UserProfile, withTweets tweets: [Tweet]){
        let TimelineStoryboard = UIStoryboard(name: "Timeline", bundle: nil)
        let navController = TimelineStoryboard.instantiateViewController(withIdentifier: "ProfileNavViewController") as! ProfileNavViewController
        let topvc = navController.topViewController as! ProfileViewController
        topvc.page = pageType.userTimeline
        topvc.tweets = tweets
        topvc.user = user
        topvc.topLeftButton.setTitle("Back", for: .normal)
        self.present(navController, animated: true, completion: nil)
    }
    
    func updatefavorite(postID: String){
        TweetMethod.method?.favorite(tweetId: postID, success: { (tweet) in
            self.tweets.insert(tweet, at: 0)
            self.profileTimelineTableView.reloadData()
        }, failure: { (error) in
            print(error)
        })
    }
    func updateretweet(postID: String){
        TweetMethod.method?.retweet(tweetId: postID, success: { (tweet) in
            self.tweets.insert(tweet, at: 0)
            self.profileTimelineTableView.reloadData()
        }, failure: { (error) in
            print(error)
        })
    }
    func performReplyAction(postID: String){
        
    }
    
    
    
    struct pageType{
        static let accountTimeline = "accountTimeline"
        static let timeline = "timeline"
        static let userTimeline = "userTimeline"
        static let mentions = "mentions"
    }
}
