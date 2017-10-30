//
//  TableViewCell.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/15/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backGroungImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var screenNameText: UILabel!
    @IBOutlet weak var numOfTweets: UILabel!
    @IBOutlet weak var numOfFollowings: UILabel!
    @IBOutlet weak var numOfFollowers: UILabel!
    @IBOutlet weak var numOfLikes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
