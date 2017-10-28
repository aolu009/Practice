//
//  TimelineTableViewCell.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/15/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

protocol TimelineTableViewCellDelegate {
    func timelineTableViewCell(nameTabbed: String)
    func timelineTableViewCell(retweetPostId: String)
    func timelineTableViewCell(replyPostId: String)
    func timelineTableViewCell(favoritePostId: String)
    
}
class TimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var RetweetButton: UIButton!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var retweeted: UILabel!
    @IBOutlet weak var nameLabel: UIButton!
    var favoriteCount = "0"
    var retweetCount = "0"
    var postId : String?
    var delegate: TimelineTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onReply(_ sender: Any) {
        replyButton.isSelected = false
        self.delegate?.timelineTableViewCell(replyPostId: postId!)
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        RetweetButton.isSelected = false
        self.delegate?.timelineTableViewCell(retweetPostId: postId!)
    }
    
    @IBAction func onLike(_ sender: Any) {
        LikeButton.isSelected = false
        self.delegate?.timelineTableViewCell(favoritePostId: postId!)
    }
    
    @IBAction func onTabbingName(_ sender: Any) {
        self.delegate?.timelineTableViewCell(nameTabbed: self.screenNameLabel.text!)
    }

}
