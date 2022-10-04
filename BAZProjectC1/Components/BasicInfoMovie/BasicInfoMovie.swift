//
//  BasicInfoMovie.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//

import UIKit

class BasicInfoMovie: UIView {
    private var viewBackgroundColor: UIColor? = .clear
    private lazy var backView: UIView = {
        let backView = UIView(frame: self.bounds)
        backView.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        return backView
    }()
    
    internal convenience init(frame:CGRect,viewBackgroundColor: UIColor) {
        self.init(frame: frame)
        self.viewBackgroundColor = viewBackgroundColor
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        backView.backgroundColor = self.viewBackgroundColor 
        addSubview(backView)
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: self.layer.frame.height ),
                                     widthAnchor.constraint(equalToConstant: self.layer.frame.width),
                                     backView.heightAnchor.constraint(equalToConstant: self.layer.frame.height ),
                                     backView.widthAnchor.constraint(equalToConstant: self.layer.frame.width),
                                     backView.topAnchor.constraint(equalTo: self.topAnchor),
                                     backView.leftAnchor.constraint(equalTo: self.leftAnchor),
                                     backView.rightAnchor.constraint(equalTo: self.rightAnchor),
                                     backView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
