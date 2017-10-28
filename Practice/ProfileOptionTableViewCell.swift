//
//  ProfileOptionTableViewCell.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/16/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class ProfileOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
