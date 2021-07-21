//
//  FilterCameraDefine.swift
//  ChatRoomPostData
//
//  Created by sameapple on 2020/2/5.
//  Copyright © 2020 sameapple. All rights reserved.
//

import Foundation
import UIKit

// MARK:- 常用距离
public let kScreen  = UIScreen.main.bounds
public let kScreenW = UIScreen.main.bounds.size.width
public let kScreenH = UIScreen.main.bounds.size.height

public let SHOW_FULLSCREEN: Int = 0
public let RECORD_WIDTH: CGFloat = 720
public let RECORD_HEIGHT: CGFloat = 1280

public let s_functionList: [String] = ["mask", "Pause", "Beautify", "PreCalc", "TakeShot",
                                       "Torch", "Resolution", "CropRec", "MyFilter0",
                                       "MyFilter1", "MyFilter2", "MyFilter3", "MyFilter4"]

public let titleArray: [String] = ["原圖", "鮮豔", "鮮豔暖色", "鮮豔冷色", "戲劇",
                                   "戲劇暖色", "戲劇冷色", "黑白", "摩登", "清新"]

public let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height

public let filterScrollViewHeight: CGFloat = 86

public let filterImageWidth: CGFloat = 64
public let filterImageHeight: CGFloat = 64

public let filterLabelHeight: CGFloat = 20

public let c433127: UIColor = UIColor(red: 43.0/255.0, green: 31.0/255.0, blue: 27.0/255.0, alpha: 0.5)
public let c25515596: UIColor = UIColor(red: 255.0/255.0, green: 155.0/255.0, blue: 96.0/255.0, alpha: 1.0)
public let c221106144: UIColor = UIColor(red: 221.0/255.0, green: 106.0/255.0, blue: 144.0/255.0, alpha: 1.0)
public let c114113113: UIColor = UIColor(red: 114.0/255.0, green: 113.0/255.0, blue: 113.0/255.0, alpha: 1.0)
public let c245245245: UIColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
public let c255168218 : UIColor = UIColor(red: 255.0/255.0, green: 168.0/255.0, blue: 218.0/255.0, alpha: 1.0)

public let get_effectConfig: [String] = [
    "nil",
    "@adjust saturation 1.8 @adjust brightness 0.15",
    "@adjust saturation 1.8 @adjust brightness 0.15 @adjust whitebalance 0.2 1",
    "@adjust saturation 1.8 @adjust brightness 0.15 @adjust whitebalance -0.2 1",
    "@adjust contrast 1.24 @adjust saturation 1.24 @adjust shadowhighlight -20 20",
    "@adjust contrast 1.24 @adjust saturation 1.24 @adjust shadowhighlight -20 20 @adjust whitebalance 0.2 1",
    "@adjust contrast 1.24 @adjust saturation 1.24 @adjust shadowhighlight -20 20 @adjust whitebalance -0.2 1",
    "@adjust saturation 0 @adjust contrast 1.24 @adjust shadowhighlight -25 25",
    "@adjust contrast 0.9 @adjust saturation 0.9 @adjust level 0.15 1 0.61 @adjust colorbalance 0.04 -0.01 -0.04",
    "@adjust contrast 0.9 @adjust saturation 0.9 @adjust brightness 0.1 @adjust whitebalance 0.01 1"
]
