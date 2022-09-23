//
//  ImageDownload.swift
//  BAZProjectC1
//
//  Created by efloresco on 19/09/22.
//

import Foundation
import UIKit


extension UIImageView {
    func loadFrom(strUrl: String) {
        guard let url = URL(string: strUrl) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let dataImg = try? Data(contentsOf: url) {
                if let img = UIImage(data: dataImg) {
                        self?.image = img
                }
            }
        }
    }
}
