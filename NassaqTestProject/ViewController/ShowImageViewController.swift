//
//  ShowImageViewController.swift
//  NassaqTestProject
//
//  Created by KemoTroy on 8/12/18.
//  Copyright © 2018 BigFour. All rights reserved.
//

//
//  ShowImageViewController.swift
//  Party
//
//  Created by Abdulrahman Sammy on 7/19/18.
//  Copyright © 2018 IT-Smart. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
class ShowImageViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var PosImageView: UIImageView!
    
    @IBOutlet weak var EscButton: UIButton!
    
    @IBOutlet weak var SliderScrolle: UIScrollView!
    
    @IBAction func EscButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func ImagePresse(Sender: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SliderScrolle.minimumZoomScale = 1.0
        self.SliderScrolle.maximumZoomScale = 6.0
        SliderScrolle.delegate = self
        PosImageView.kf.setImage(with: URL(string:PostImage))
        // Do any additional setup after loading the view.
        let PostpanGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                action: #selector(ImagePresse(Sender:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(PostpanGestureRecognizer)
        
    }
    
    func viewForZooming(in SliderScrolle: UIScrollView) -> UIView? {
        return self.PosImageView
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

