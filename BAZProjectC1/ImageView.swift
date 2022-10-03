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
        self.addAnimation()
        if let img = imageCache.object(forKey: NSString(string: imageUrl ?? "")) {
            self.removeAnimation()
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
                        self.removeAnimation()
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

extension UIView {
    func addAnimation(transparency: CGFloat = 0.5, velocity: CFTimeInterval = 1, startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) {
        layer.masksToBounds = true
        let shimmerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        shimmerView.backgroundColor = UIColor.lightGray.withAlphaComponent(transparency)
        shimmerView.clipsToBounds = true
        shimmerView.tag = 2104082
        addSubview(shimmerView)
        let gradientLayer = addGradientLayer(startPoint: startPoint, endPoint: endPoint)
        let animation = addAnimation(duration: velocity)
        gradientLayer.add(animation, forKey: animation.keyPath)
    }

    func removeAnimation() {
        for subview in self.subviews where subview.tag == 2104082 {
            subview.removeFromSuperview()
            subview.layer.mask = nil
        }
    }
    
    private func addGradientLayer(startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let darkGray: CGColor = UIColor(red: 214/255, green: 215/255, blue: 217/255, alpha: 1).cgColor
        let lightGray: CGColor = UIColor(red: 241/255, green: 243/255, blue: 242/255, alpha: 1).cgColor
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [darkGray, lightGray, darkGray]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        for subview in self.subviews where subview.tag == 2104082 {
            subview.layer.addSublayer(gradientLayer)
        }
        return gradientLayer
    }
    
    private func addAnimation(duration: CFTimeInterval = 0.9) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = duration
        return animation
    }
}
