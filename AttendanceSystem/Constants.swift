//
//  Constants.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit


var loginUser : WowUser?

var backgroundImage : UIImage = UIImage(named: "Background2")! {
    didSet{
    backgroundImageView = UIImageView(image: backgroundImage)
    }
}
var backgroundImageView = UIImageView(image: backgroundImage)

var currentTheme = "Background2"

