//
//  movieImageView.swift
//  BAZProjectC1
//
//  Created by 1044336 on 28/09/22.
//

import Foundation
import UIKit


open class movieImageView: UIView {
    
    public lazy var posterImage: UIImageView = {
        let posterImage = UIImageView(frame: self.bounds)
        posterImage.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        posterImage.rounderCorners()
        posterImage.contentMode = .redraw
        return posterImage
    }()
    
    private lazy var backView: UIView = {
        let backView = UIView(frame: self.bounds)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        let gradient = CAGradientLayer()
        gradient.frame = backView.bounds
        gradient.colors = [UIColor.appColorGrayPrimary.withAlphaComponent(0.3).cgColor,
                           UIColor.appColorBlack.withAlphaComponent(1).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        backView.layer.insertSublayer(gradient, at: 0)
        return backView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    func setupView() {
        self.backgroundColor = UIColor.appColorBlack
        self.addSubview(posterImage)
        self.addSubview(backView)
    }
    func loadImage(with imageString: String) {
        posterImage.loadImageFromUrl(urlString: "\(EndpointsList.imageResorce.description)\(imageString)")
    }
}
