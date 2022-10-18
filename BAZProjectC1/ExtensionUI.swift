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
            self.image = UIImage.init(named: "placeHolder")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let dataImg = try? Data(contentsOf: url), let img = UIImage(data: dataImg) else { return }
            self?.image = img
        }
    }
}

extension UILabel {
    
    func loadConfigurationFont(with bIsTitle: Bool) {
        self.font = UIFont(name: "Marker Felt", size: bIsTitle ? 16 : 14)
    }
}

extension UITextView {
    func loadConfigurationFont() {
        self.font = UIFont(name: "Marker Felt", size: 16)
    }
}
