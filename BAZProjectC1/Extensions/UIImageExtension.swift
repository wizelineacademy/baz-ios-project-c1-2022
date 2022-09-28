//
//  UIImageExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 22/09/22.
//

import Foundation
import UIKit
extension UIImage{
    static func imageFromColor(with color: UIColor, size: CGSize?) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size?.width ?? 0, height: size?.height ?? 0)
        UIGraphicsBeginImageContextWithOptions(size ?? CGSize(), false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        else{  return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}
