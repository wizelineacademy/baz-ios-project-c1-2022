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
}

