//
//  UIViewExtension.swift
//  BAZProjectC1
//
//  Created by 961184 on 01/10/22.
//

import UIKit

extension UIView {
    /**
     A function that adds a loading animation to the view
     - Parameters:
        - transparency: The opacity value of the new color object, specified as a value from 0.0 to 1.0. Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
        - velocity: Specifies the basic duration of the animation, in seconds.
        - startPoint: The start point of the gradient when drawn in the layer’s coordinate space.
        - endPoint: The end point of the gradient when drawn in the layer’s coordinate space.
     */
    func addSkeletonAnimation(transparency: CGFloat = 0.5, velocity: CFTimeInterval = 1, startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) {
        layer.masksToBounds = true
        let shimmerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        shimmerView.backgroundColor = UIColor.lightGray.withAlphaComponent(transparency)
        shimmerView.clipsToBounds = true
        shimmerView.tag = 2104082
        addSubview(shimmerView)
        let gradientLayer = createGradientLayer(startPoint: startPoint, endPoint: endPoint)
        let animation = createAnimation(duration: velocity)
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    /**
     A function that remove a loading animation to the view
     */
    func removeSkeletonAnimation() {
        for subview in self.subviews where subview.tag == 2104082 {
            subview.removeFromSuperview()
            subview.layer.mask = nil
        }
    }
    
    /**
     A function that returns a CAGradientLayer from the selected configuration
     
     - Parameters:
        - startPoint: The start point of the gradient when drawn in the layer’s coordinate space.
        - endPoint: The end point of the gradient when drawn in the layer’s coordinate space.

     - Returns: A CAGradientLayer initialized with Dark Gray Color and light Gray Color
     */
    private func createGradientLayer(startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) -> CAGradientLayer {
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
    
    /**
     A function that returns a CABasicAnimation with a specific duration.
     
     - Parameters:
        - duration: Specifies the basic duration of the animation, in seconds.

     - Returns: A CABasicAnimation initialized with fromValue = [-1.0, -0.5, 0.0] and toValue = [1.0, 1.5, 2.0] that repeats infinite.
     */
    private func createAnimation(duration: CFTimeInterval = 0.9) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = duration
        return animation
    }
}
