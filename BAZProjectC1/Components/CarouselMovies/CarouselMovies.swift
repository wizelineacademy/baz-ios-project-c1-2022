//
//  CarouselMovies.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import UIKit

fileprivate let START_ROW: Int = 0
fileprivate let START_SECTION: Int = 0

class CarouselMovies: UIView {
    
    private(set) lazy var typeCarousel: String = {
        return "MovieModel"
    }()
    
    private(set) lazy var infoCarousel: [MovieModel] = {
        return []
    }()
    
    private(set) lazy var infoCarouselCast: [CastModel] = {
        return []
    }()
    
    private var currentItem:Int = -1
    public weak var delegate:CarouselMoviesDelegate?
    public lazy var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 48
        layout.minimumInteritemSpacing = 48
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let carousel = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        carousel.backgroundColor = UIColor.appColorBlack
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.delegate = self
        carousel.dataSource = self
        carousel.showsHorizontalScrollIndicator = false
        carousel.showsVerticalScrollIndicator = false
        carousel.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        carousel.register(MovieCarouselCell.self, forCellWithReuseIdentifier: MovieCarouselCell.reuseIdentifier)
        return carousel
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public func commonInit() {
        setupUI()
    }
    
    private func setupUI() {
        addSubview(carousel)
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: self.layer.frame.height ),
                                     widthAnchor.constraint(equalToConstant: self.layer.frame.width),
                                     carousel.topAnchor.constraint(equalTo: self.topAnchor),
                                     carousel.leftAnchor.constraint(equalTo: self.leftAnchor),
                                     carousel.rightAnchor.constraint(equalTo: self.rightAnchor),
                                     carousel.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        let contentOffset = carousel.contentOffset
        carousel.setContentOffset(contentOffset, animated: false)
    }
    
    public  func setDataInfo(infoCarousel: [MovieModel]) {
        clearCarouselData()
        typeCarousel = "MovieModel"
        self.infoCarousel = infoCarousel
        carousel.reloadData()
    }
    
    public  func setDataInfo(infoCarousel: [CastModel]) {
        clearCarouselData()
        typeCarousel = "CastModel"
        self.infoCarouselCast = infoCarousel
        carousel.reloadData()
    }
    
    private func clearCarouselData()  {
        self.infoCarousel = []
        carousel.reloadData()
    }
    
    private func scrollToStar() {
        if self.infoCarousel.count != 0 {
            self.carousel.scrollToItem(at: IndexPath(row: START_ROW, section: START_SECTION), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
    }
}
