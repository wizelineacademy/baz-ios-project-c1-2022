//
//  UIImageExtension.swift
//  BAZProjectC1
//
//  Created by 1030361 on 27/09/22.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
