//
//  UIImageViewExtension.swift
//  BAZProjectC1
//
//  Created by 961184 on 01/10/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    /**
     A function that allows downloading and displaying an image in a UIImageView.
     - Parameters:
        - urlStr: A string representing the url of the image
     */
    func loadImage(urlStr: String) {
        image = UIImage()
        self.addSkeletonAnimation()
        if let img = imageCache.object(forKey: NSString(string: urlStr)) {
            self.removeSkeletonAnimation()
            image = img
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print(err)
            } else {
                DispatchQueue.main.async {
                    guard let data = data,
                          let tempImg = UIImage(data: data) else { return }
                    
                    self.removeSkeletonAnimation()
                    self.alpha = 0.3;
                    self.image = tempImg
                    
                    UIView.animate(withDuration: 1.5) {
                        self.alpha = 1.0;
                    }
                    imageCache.setObject(tempImg, forKey: NSString(string: urlStr))
                }
            }
        }.resume()
    }
}
