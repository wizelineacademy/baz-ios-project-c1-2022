//
//  ImageView.swift
//  BAZProjectC1
//
//  Created by rnunezi on 03/10/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
class ImageView : UIImageView {
    var imageUrl: String?
    
    func loadImage(urlStr: String) {
        imageUrl = urlStr
        image = UIImage()
        if let img = imageCache.object(forKey: NSString(string: imageUrl ?? "")) {
            image = img
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        imageUrl = urlStr
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print(err)
            } else {
                DispatchQueue.main.async {
                    guard let data = data,
                    let tempImg = UIImage(data: data) else { return }
                    
                    if self.imageUrl == urlStr {
                        self.alpha = 0.3;
                        self.image = tempImg
                        
                        UIView.animate(withDuration: 1.5) {
                            self.alpha = 1.0;
                        }
                    }
                    imageCache.setObject(tempImg, forKey: NSString(string: urlStr))
                }
            }
        }.resume()
    }
}
