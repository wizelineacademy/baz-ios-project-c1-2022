//
//  UIColorExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 22/09/22.
//

import Foundation
import UIKit

extension UIColor{
    static func getColorFromHexString (with hex:String) -> UIColor{
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    static var appColorBlack: UIColor{ return getColorFromHexString(with: "#000000")}
    
    static var appColorGrayPrimary: UIColor{ return getColorFromHexString(with: "#242529")}
    static var appColorGraySecondary: UIColor{ return getColorFromHexString(with: "#9EA2AB")}
    
    static var appColorYellowPrimary: UIColor{ return getColorFromHexString(with: "#F3D46C")}
    static var appColorYellowSecondary: UIColor{ return getColorFromHexString(with: "")}
    static var appColorYellowTertiary: UIColor{ return getColorFromHexString(with: "")}
    static var appColorWhitePrimary: UIColor{ return getColorFromHexString(with: "#FFFFFF")}
}
