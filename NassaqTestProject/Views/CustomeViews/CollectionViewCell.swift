//
//  CollectionViewCell.swift
//  NassaqTestProject
//
//  Created by KemoTroy on 8/9/18.
//  Copyright © 2018 BigFour. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ProfileView: UIView!
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    
    @IBOutlet weak var ProfileUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
ProfileImageView.layer.cornerRadius = ProfileImageView.frame.size.width/2
ProfileImageView.clipsToBounds = true
ProfileView.layer.cornerRadius = ProfileView.frame.size.width/2
ProfileView.clipsToBounds = true
        

        
        
        
    }

}




