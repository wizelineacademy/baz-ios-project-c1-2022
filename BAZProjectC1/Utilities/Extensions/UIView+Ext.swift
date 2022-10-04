//
//  UIView+Ext.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 01/10/22.
//

import UIKit
import Foundation

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, corner: CGFloat, backgroundColor: UIColor) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.cornerRadius = corner
        layer.backgroundColor = backgroundColor.cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadowView(color: UIColor, opacity: Float = 0.5, offSet: CGSize) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
       
    }
    
    func setOvalShadow(color: UIColor = UIColor.white){
        //Removemos si exiten sublayers
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        let roundPath = UIBezierPath(ovalIn: self.bounds)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = roundPath.cgPath
        maskLayer.fillColor = color.cgColor//UIColor.red.cgColor
        self.layer.addSublayer(maskLayer)
    }
    
    
    func setTrapecioShadow(){
         //var maskLayer: CAShapeLayer!
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.fillColor = UIColor.white.cgColor
        //self.layer.mask = maskLayer
        
        let headerRect = self.bounds
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y:  headerRect.height))
        path.addLine(to: CGPoint(x: headerRect.width, y:  headerRect.height))
        path.addLine(to: CGPoint(x: headerRect.width, y: (headerRect.height / 2)))

        maskLayer.path = path.cgPath
        self.layer.addSublayer(maskLayer)
    }
    
    func createShadowLayer(width: CGFloat, height: CGFloat) -> CALayer {
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: width, height: height)
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        return shadowLayer
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func applyGradient(colours: [UIColor], direction: GradientColorDirection = .vertical) -> Void {
        self.applyGradient(colours: colours, locations: nil, cornerRadius: nil, direction : direction)
    }
    
    func applyGradient(colours: [UIColor], cornerRadius: CGFloat, direction: GradientColorDirection = .vertical)  -> Void{
        self.applyGradient(colours: colours, locations: nil, cornerRadius: cornerRadius, direction: direction)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, cornerRadius: CGFloat?, direction: GradientColorDirection = .vertical) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.cornerRadius = cornerRadius ?? 0
        if direction == .horizontal{
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    static func nibForClass() -> Self {
        return loadNib(self)
    }
    
    static func loadNib<A>(_ owner: AnyObject, bundle: Bundle = Bundle.main) -> A {
        let nibName = NSStringFromClass(classForCoder()).components(separatedBy: ".").last!
        let nib = bundle.loadNibNamed(nibName, owner: owner, options: nil)!
        for item in nib {
            if let item = item as? A {
                return item
            }
        }
        
        return nib.last as! A
        
    }
    func addTransitionFade(_ duration: TimeInterval = 0.5) {
        let animation = CATransition()
        
        animation.type = CATransitionType.fade
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = duration
        
        layer.add(animation, forKey: "kCATransitionFade")
        
    }
}
