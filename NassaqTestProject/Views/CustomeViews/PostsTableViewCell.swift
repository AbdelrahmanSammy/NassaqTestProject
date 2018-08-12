//
//  PostsTableViewCell.swift
//  NassaqTestProject
//
//  Created by KemoTroy on 8/9/18.
//  Copyright © 2018 BigFour. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var ProfileView: UIView!
    
    @IBOutlet weak var PrfileImageView: UIImageView!
    
    @IBOutlet weak var ProfileNameLabel: UILabel!
    
    @IBOutlet weak var CountryLabel: UILabel!
    @IBOutlet weak var DurationLabel: UILabel!
    
    @IBOutlet weak var PostImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        PrfileImageView.layer.cornerRadius = PrfileImageView.frame.size.width/2
        ProfileView.layer.cornerRadius = ProfileView.frame.size.width/2
        PrfileImageView.clipsToBounds = true
        ProfileView.clipsToBounds = true
        
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

