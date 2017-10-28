//
//  ProfileViewController.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/14/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit
import AFNetworking


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TimelineTableViewCellDelegate{
    
    
    @IBOutlet weak var profileTimelineTableView: UITableView!
    @IBOutlet weak var topLeftButton: UIButton!
    
    
    var page = pageType.accountTimeline
    var user: UserProfile?
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(page)
        getAsset()
        setupTable()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if page == pageType.accountTimeline || page == pageType.userTimeline{
            return section == 0 ? 1 : tweets == nil ? 0 : tweets.count
        }else{
            return section == 0 ? 0 : tweets == nil ? 0 : tweets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            return setupProfileCell(tableView)
        }else{
            return setupTimelineCell(tableView, indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
        
        
    }
    func timelineTableViewCell(nameTabbed: String) {
        getUserTimeline(with: nameTabbed) { (user, tweets) in
            self.presentUserProfilePage(withUser: user, withTweets: tweets)
        }
    }
    
    func timelineTableViewCell(replyPostId: String) {
        
    }
    func timelineTableViewCell(retweetPostId: String) {
        
    }
    func timelineTableViewCell(favoritePostId: String) {
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        if user === CurrentUser.currentUser{
            UserAccount.currentUser?.logout()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // Present compose
    
    // Present reply
    
    // Perform retweet and reload data
    
    // Present single tweet page
    
    
    
    
}
