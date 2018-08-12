//
//  Constants.swift
//  Party
//
//  Created by ahmed elshobary on 7/3/17.
//  Copyright © 2017 IT-Smart. All rights reserved.
//

import Foundation
import UIKit

let LIGHTER_BROWN = 0xCC1D3A
let ALPHA_COMPONENT: CGFloat = 0.6
let LOADER_WIDTH: CGFloat = 50.0
var PostImage = ""
var IDUnBookmark:String = ""
enum Nassaq_APIS: Int {
    case Posts = 0
    case Friends = 1

  
}




let API_URL = "http://elofight.com/stest/"
let Posts = API_URL + "data.php"
let Friends = API_URL + "users.php"









func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )


}

