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
        backView.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        let gradient = CAGradientLayer()
        gradient.frame = backView.bounds
        gradient.colors = [UIColor.appColorGrayPrimary.withAlphaComponent(0.1).cgColor,
                           UIColor.appColorBlack.withAlphaComponent(0.875).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.9)
        backView.layer.insertSublayer(gradient, at: 0)
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
        movieTitle.textColor = UIColor.appColorWhitePrimary
        movieTitle.textAlignment = .left
        return movieTitle
    }()
    
    public lazy var movieRanking: UILabel = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let movieRanking = UILabel(frame: frame)
        movieRanking.translatesAutoresizingMaskIntoConstraints = false
        movieRanking.text = "movieRanking"
        movieRanking.numberOfLines = 0
        movieRanking.adjustsFontSizeToFitWidth = true
        movieRanking.sizeToFit()
        movieRanking.textColor = UIColor.appColorWhitePrimary
        movieRanking.textAlignment = .left
        return movieRanking
    }()
    
    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView(frame: contentView.bounds)
        posterImage.layer.cornerRadius = RounderBorderStyleForView.rounded.rawValue
        posterImage.rounderCorners()
        return posterImage
    }()
    
    private lazy var movieRankingImage: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        let movieRankingImage = UIImageView(frame: frame)
        movieRankingImage.translatesAutoresizingMaskIntoConstraints = false
        movieRankingImage.image = UIImage(named: "startRanking")?.withTintColor(UIColor.appColorYellowPrimary)
        return movieRankingImage
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(posterImage)
        contentView.addSubview(backView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieRankingImage)
        contentView.addSubview(movieRanking)
        movieRankingImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        movieRankingImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        movieRankingImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        movieRankingImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        movieRankingImage.heightAnchor.constraint(equalTo: movieRankingImage.widthAnchor, multiplier: contentView.frame.size.height / contentView.frame.size.width).isActive = true
        movieRanking.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        movieRanking.leftAnchor.constraint(equalTo: movieRankingImage.rightAnchor, constant: 8).isActive = true
        movieTitle.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        movieTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        movieTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        movieTitle.bottomAnchor.constraint(equalTo: movieRankingImage.topAnchor, constant: -8).isActive = true
    }
    
    func configuration(dataInfo: MovieModel) {
        posterImage.image = UIImage.imageFromColor(with: UIColor.appColorYellowPrimary.withAlphaComponent(0.1), size: posterImage.frame.size)
        posterImage.loadImageFromUrl(urlString: "\(EndpointsList.imageResorce.description)\(dataInfo.poster_path ?? "")")
        movieTitle.text = dataInfo.title
        movieRanking.text = "\(Int(dataInfo.vote_average ?? 0))"
    }
}