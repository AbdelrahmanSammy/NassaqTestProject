
//
//  PostViewController.swift
//  NassaqTestProject
//
//  Created by KemoTroy on 8/9/18.
//  Copyright © 2018 BigFour. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
class PostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var HomeView: UIView!
    @IBOutlet weak var HomeImageView: UIImageView!
    
    @IBOutlet weak var SearchView: UIView!
    
    @IBOutlet weak var SettingView: UIView!
    
    @IBOutlet weak var LikeView: UIView!
    
    @IBOutlet weak var ProfileView: UIView!
    
    
    @IBOutlet weak var PostTableView: UITableView!
    
    @IBOutlet weak var CameraBurtton: UIButton!
    @IBOutlet weak var CameraImageView: UIImageView!
    
    @IBOutlet weak var CameraView: UIView!
    
    var PostArrayController = [PostsModel]()
    
    @IBAction func CameraButtonAction(_ sender: Any) {
        
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        let action = UIAlertController(title: "title", message: "Choose a source", preferredStyle: .actionSheet)
        
        
        action.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in ImagePicker.sourceType = .camera
            self.present(ImagePicker, animated: true, completion: nil)}))
        
        action.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in ImagePicker.sourceType = .photoLibrary
            self.present(ImagePicker, animated: true, completion: nil)}))
        
        action.addAction(UIAlertAction(title: "Camera", style: .default, handler:nil
        ))
        self.present(ImagePicker, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CameraView.roundCorners(cornerRadius: 15.0)
        HomeView.layer.cornerRadius = HomeView.frame.size.width/2
        PostsViewModel.PostsViewModelRequest.PostsDelegate = self
        
             NotificationCenter.default.addObserver(self, selector: #selector(UpdatePosts), name: NSNotification.Name("UpdatePosts"), object: nil)
 
  
    }
    
    
    
    //let Object = PostsViewModel()

    
    @objc func UpdatePosts (){
        PostsViewModel.PostsViewModelRequest.GetPosts()
        print ("UpdatePosts = true ")
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImageJPEGRepresentation(image, 0.9)
        let bas = imageData?.base64EncodedString()
       
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

extension PostViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0 {return 1}
        
        return PostArrayController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        if indexPath.section == 0 {
     
            
            
            tableView.register(UINib(nibName: "FriendsTableViewCell" , bundle: nil), forCellReuseIdentifier: "FriendsTableViewCell")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell", for: indexPath) as! FriendsTableViewCell
            
       
            
            return cell
        }
        else {
            
            
            tableView.register(UINib(nibName: "PostsTableViewCell" , bundle: nil), forCellReuseIdentifier: "PostsTableViewCell")
            PostTableView.separatorStyle = .none
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as! PostsTableViewCell
            let Object = PostArrayController[indexPath.row]
            cell.PostImageView.kf.setImage(with:URL(string:Object.post_image))
            cell.PrfileImageView.kf.setImage(with: URL(string:Object.profile_image))
            cell.PrfileImageView.layer.cornerRadius = cell.PrfileImageView.frame.size.width/2
            cell.PrfileImageView.clipsToBounds = true
            cell.DurationLabel.text = Object.date
            cell.ProfileNameLabel.text = Object.user_name
            cell.CountryLabel.text = Object.country
   
            return cell
            
        }

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            print("Cell Selected")


        }
        
        else {

            PostImage = PostArrayController[indexPath.row].post_image

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "ShowImageViewController") as! ShowImageViewController
        
        HomeViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
        HomeViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        
        self.present(HomeViewController, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    if indexPath.section == 0
        
    {
        
        return 150
        
        }
        
    else {return 300 }
        
    
    }
  
    
}

extension PostViewController:PostsViewModelManagerDelegate {
    
    func PostRequestResponse(PostsArary:[PostsModel]){
        
        PostArrayController = PostsArary
        PostTableView.reloadData()
        print("PostViewModelDelegate Fire")
        
    }
}

extension UIView {
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
}
