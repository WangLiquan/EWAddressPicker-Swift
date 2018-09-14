//
//  CommonHelper.swift
//  EWDatePicker
//
//  Created by Ethan.Wang on 2018/8/27.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import Foundation
import UIKit

struct ScreenInfo {
    static let Frame = UIScreen.main.bounds
    static let Height = Frame.height
    static let Width = Frame.width
    static let navigationHeight:CGFloat = navBarHeight()

    static func isIphoneX() -> Bool {
        return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
    }
    static private func navBarHeight() -> CGFloat {
        return isIphoneX() ? 88 : 64;
    }
}
//便捷的类方法
extension UIColor {
    class func colorWithRGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

extension UIColor {

    @nonobjc static let x666666 = UIColor.colorWithRGBA(r: 102, g: 102, b: 102, a: 1)

    @nonobjc static let x333333 = UIColor.colorWithRGBA(r: 51, g: 51, b: 51, a: 1)

    @nonobjc static let x4FB0FF = UIColor.colorWithRGBA(r: 79, g: 176, b: 255, a: 1)

}
