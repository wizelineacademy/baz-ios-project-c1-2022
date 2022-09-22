//
//  movieCarouselCell.swift
//  BAZProjectC1
//
//  Created by 1044336 on 22/09/22.
//

import UIKit

class movieCarouselCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: movieCarouselCell.self)
    
    private lazy var backView: UIView = {
        let backView = UIView(frame: contentView.bounds)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = UIColor.appColorGrayPrimary.withAlphaComponent(0.55)
        backView.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        return backView
    }()
    
    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView(frame: contentView.bounds)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        posterImage.rounderCorners()
        return posterImage
    }()
    
    required init?(coder: NSCoder) {    fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    func setupUI(){
        contentView.addSubview(posterImage)
        contentView.addSubview(backView)
//        contentView.addSubview(backView)
//        NSLayoutConstraint.activate([backView.topAnchor.constraint(equalTo: contentView.topAnchor),
//                                     backView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//                                     backView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//                                     backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    func configuration(dataInfo: MovieModel){
        print(dataInfo)
        posterImage.loadImageFromUrl(urlString: "\(EndpointsList.imageResorce.description)\(dataInfo.poster_path)")
        
    }
}
