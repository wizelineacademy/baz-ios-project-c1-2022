//
//  backButton.swift
//  BAZProjectC1
//
//  Created by 1044336 on 28/09/22.
//
import UIKit

class backButton: UIButton {
    
    public lazy var iconButton: UIImageView = {
        let iconButton = UIImageView(frame: self.bounds)
        iconButton.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        iconButton.rounderCorners()
        iconButton.contentMode = .scaleAspectFit
        iconButton.image = UIImage(named: "back")?.withTintColor(UIColor.appColorYellowPrimary)
        return iconButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.appColorGrayPrimary.withAlphaComponent(0.2)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.addSubview(iconButton)
    }
}
