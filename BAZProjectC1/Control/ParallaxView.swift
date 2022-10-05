//
//  ParallaxView.swift
//  BAZProjectC1g
//
//  Created by efloresco on 02/10/22.
//

import Foundation
import UIKit

protocol ParalaxFunctionImp : AnyObject {
    func paralaxView(_ paralaxView: ParallaxView, didSelectItem at: IndexPath)
    
}

class ParallaxView: UIView {
    
    weak var delegateParalax: ParalaxFunctionImp?
    
    let imgDetail: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupImage()
        addTapGesture()
    }
    
    private func setupView() {
        layer.borderWidth = 0.5
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = true
        backgroundColor = .black
    }
    
    private func setupImage() {
        addSubview(imgDetail)
        imgDetail.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgDetail.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imgDetail.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgDetail.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgDetail.contentMode = .scaleAspectFit
        
    }
    
    private func addTapGesture() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        self.isUserInteractionEnabled = true
    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        guard delegateParalax != nil else { return }
        delegateParalax?.paralaxView(self, didSelectItem: IndexPath(row: recognizer.view!.tag, section: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
