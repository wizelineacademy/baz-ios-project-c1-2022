//
//  UIImageViewExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 17/09/22.
//

import Foundation
import UIKit
extension UIImageView {
    public func loadImageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url){
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            self?.contentMode = .scaleAspectFill
                        }
                    }
                }
            }
        }
    }
    public func rounderCorners(rounderValue: CGFloat = RounderBorderStyleForView.rounded.rawValue, backgroundColor: UIColor = UIColor.clear) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: [.topRight , .topLeft,.bottomLeft,.bottomRight],
                                      cornerRadii: CGSize(width: rounderValue, height: rounderValue)).cgPath
        self.layer.backgroundColor = backgroundColor.cgColor
        self.layer.mask = rectShape
    }
}

