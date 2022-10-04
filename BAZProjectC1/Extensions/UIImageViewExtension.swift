//
//  UIImageViewExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 17/09/22.
//

import Foundation
import UIKit

extension UIImageView {
    public func loadImagel(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data) else {
                        return

                    }
            DispatchQueue.main.async { self?.image = image }
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

