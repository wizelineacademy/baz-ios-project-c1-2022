//
//  ParallaxView.swift
//  BAZProjectC1g
//
//  Created by efloresco on 02/10/22.
//

import Foundation
import UIKit

protocol ParalaxProtocol {
    func didSelectItem(iIndex: Int)
}

class ParallaxView: UIView {
    
    var delegateParalax: ParalaxProtocol?
    
    let imgDetail: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = true
        backgroundColor = .black
        
        addSubview(imgDetail)
        
        imgDetail.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgDetail.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imgDetail.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgDetail.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgDetail.contentMode = .scaleAspectFit
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        self.isUserInteractionEnabled = true

    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        if delegateParalax != nil {
            delegateParalax?.didSelectItem(iIndex: recognizer.view!.tag)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
