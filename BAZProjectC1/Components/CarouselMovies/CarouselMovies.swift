//
//  CarouselMovies.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

class CarouselMovies: UIView {

    public weak var delegate:CarouselMoviesDelegate?
    public lazy var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let carousel = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.delegate = self
        carousel.dataSource = self
        //menuArea.backgroundColor = .blue
        carousel.tag = 2
        carousel.showsHorizontalScrollIndicator = false
        carousel.showsVerticalScrollIndicator = false
        carousel.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        //carousel.register(MenuOptionCell.self, forCellWithReuseIdentifier: MenuOptionCell.reuseIdentifier)
        return carousel
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    public func commonInit() {
        setupUI()
    }
    private func setupUI() {
        self.addSubview(carousel)
        self.heightAnchor.constraint(equalToConstant: self.layer.frame.height ).isActive = true
        self.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
//        carousel.heightAnchor.constraint(equalToConstant: self.layer.frame.height ).isActive = true
//        carousel.widthAnchor.constraint(equalToConstant: self.layer.frame.width).isActive = true
        carousel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        carousel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        carousel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        carousel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        let contentOffset = carousel.contentOffset
        carousel.setContentOffset(contentOffset, animated: false)
    }

}
