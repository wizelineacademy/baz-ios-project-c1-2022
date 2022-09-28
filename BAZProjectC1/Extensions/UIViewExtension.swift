//
//  UIViewExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 22/09/22.
//

import Foundation
import UIKit

public enum RounderBorderStyleForView: CGFloat {
    case none = 0.0
    case rounded = 13.5
    case circular = 50.0
}

extension UIView {
    func setDashedBorder(color: UIColor, Style: RounderBorderStyleForView) {
        self.backgroundColor = .clear
        let bottomLineCGRect = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height:  self.frame.size.height)
        let dashBorder = CAShapeLayer()
        dashBorder.strokeColor = color.cgColor
        dashBorder.fillColor = nil
        dashBorder.lineDashPattern = [5, 7]
        self.layer.addSublayer(dashBorder)
        dashBorder.frame = bottomLineCGRect
        dashBorder.path = UIBezierPath(roundedRect: bottomLineCGRect, cornerRadius: Style.rawValue).cgPath
    }
    
    func getBlurView() -> UIView {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
}
