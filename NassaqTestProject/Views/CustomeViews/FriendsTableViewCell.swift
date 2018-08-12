//
//  FriendsTableViewCell.swift
//  NassaqTestProject
//
//  Created by KemoTroy on 8/9/18.
//  Copyright © 2018 BigFour. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var FriendsCollectionView: UICollectionView!
    
    
    var FriendArrayConroll = [FriendModel]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        FriendsCollectionView.delegate = self
        FriendsCollectionView.dataSource = self
        let Object =  PostsViewModel ()
        Object.GetFriends()
        Object.PostsDelegate = self
        
        
        FriendsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")


    
    }

    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FriendsTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FriendArrayConroll.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = Bundle.main.loadNibNamed("CollectionViewCell", owner: self, options: nil)?.first as!  CollectionViewCell
    collectionView.register(UINib(nibName: "CollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
 
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        let Object = FriendArrayConroll[indexPath.row]
        cell.ProfileImageView.kf.setImage(with: URL(string:Object.profile_image))
        
        cell.ProfileUserName.text = Object.user_name
        
     
    

        
        
        return cell
        
    }
    
    
    
    
    
    
    
    
    
    
}
extension FriendsTableViewCell:PostsViewModelManagerDelegate {
    
 
    func FriendsRequestResponse(FriendsArary: [FriendModel]) {
        
        FriendArrayConroll = FriendsArary
        
         FriendsCollectionView.reloadData()
    }
    
    
    
    
    
    
}

