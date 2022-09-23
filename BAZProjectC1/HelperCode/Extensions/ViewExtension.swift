//
//  IESviewExtension.swift
//  IESpecomponentsCore
//
//  Created by 1029186 on 04/08/22.
//  Copyright © 2022 1029186®. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

    /// This method rounder corners of UIView
    /// - Parameter radious: size of the corner default is a circle corner
    func roundCornersView(radious: CGFloat? = nil) {
        if let radious = radious {
            self.layer.cornerRadius = radious
        } else {
            // Default the radious is a circle
            self.layer.cornerRadius = self.layer.frame.height / 2.0
        }
    }

    /// This method set a border of a IESButton
    /// - Parameters:
    ///   - width: the with of the border
    ///   - color: the color of border
    func setBorder(width: CGFloat? = 1.00, color: UIColor) {
        self.layer.borderWidth = width!
        self.layer.borderColor = color.cgColor
    }
}
