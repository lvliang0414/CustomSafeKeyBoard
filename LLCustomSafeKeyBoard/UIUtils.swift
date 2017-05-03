//
//  UIUtils.swift
//  CustomSafeKeyBoard
//
//  Created by LVLIANG－MAC on 2017/5/3.
//  Copyright © 2017年 tenyearsdream. All rights reserved.
//

import UIKit

class UIUtils {
    class func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class func getMainBgColor() -> UIColor {
        return UIColor.darkGray
    }
    
    class func getButtonColor() -> UIColor {
        return UIColor.gray
    }
    
    class func getTextColor() -> UIColor {
        return UIColor.white
    }
    
    class func getTextFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 25)
    }
    
    class func getNumberFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    
    
}
