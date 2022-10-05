//
//  BackButton.swift
//  BAZProjectC1
//
//  Created by 1044336 on 28/09/22.
//
import UIKit

class BackButton: UIButton {
    
    private lazy var iconButton: UIImageView = {
        let iconButton = UIImageView(frame: self.bounds)
        iconButton.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        iconButton.rounderCorners()
        iconButton.contentMode = .scaleAspectFit
        iconButton.image = UIImage(named: "back")?.withTintColor(UIColor.appColorYellowPrimary)
        return iconButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyles()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStyles()
    }
    
    override func draw(_ rect: CGRect) {
        setupStyles()
    }
    
    private func setupStyles() {
        backgroundColor = UIColor.appColorGrayPrimary.withAlphaComponent(0.2)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        addSubview(iconButton)
    }
}
