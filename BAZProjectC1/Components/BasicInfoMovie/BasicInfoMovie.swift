//
//  BasicInfoMovie.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//

import UIKit

class BasicInfoMovie: UIView {
    
    var viewBackgroundColor: UIColor? = .clear
    private lazy var backView: UIView = {
        let backView = UIView(frame: self.bounds)
        backView.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        return backView
    }()
    
    public convenience init(frame:CGRect,viewBackgroundColor: UIColor){
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
        self.addSubview(backView)
        self.heightAnchor.constraint(equalToConstant: self.layer.frame.height ).isActive = true
        self.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        
        backView.heightAnchor.constraint(equalToConstant: self.layer.frame.height ).isActive = true
        backView.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        backView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
}
