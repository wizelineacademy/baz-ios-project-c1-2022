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
        backView.backgroundColor = UIColor.appColorWhitePrimary.withAlphaComponent(0.1)
        backView.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        return backView
    }()
    public lazy var movieTitle: UILabel = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let movieTitle = UILabel(frame: frame)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.text = "movieTitle"
        movieTitle.numberOfLines = 0
        movieTitle.adjustsFontSizeToFitWidth = true
        movieTitle.sizeToFit()
        movieTitle.textColor = UIColor.appColorYellowPrimary
        movieTitle.backgroundColor = UIColor.appColorBlack.withAlphaComponent(0.75)
        return movieTitle
    }()
    
    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView(frame: contentView.bounds)
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
        contentView.addSubview(movieTitle)
        
        movieTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        movieTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        movieTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -32).isActive = true
    }
    func configuration(dataInfo: MovieModel){
        posterImage.image = UIImage.imageFromColor(with: UIColor.appColorYellowPrimary.withAlphaComponent(0.1), size: posterImage.frame.size)
        posterImage.loadImageFromUrl(urlString: "\(EndpointsList.imageResorce.description)\(dataInfo.poster_path ?? "")")
        movieTitle.text = dataInfo.title
        
    }
}
