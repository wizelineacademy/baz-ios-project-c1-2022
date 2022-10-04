//
//  movieCarouselCell.swift
//  BAZProjectC1
//
//  Created by 1044336 on 22/09/22.
//

import UIKit

fileprivate let PADDING_SCREEN_PIXEL: CGFloat = 16
fileprivate let IMAGE_CONSTANT_SIZE: CGFloat = 24


class MovieCarouselCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MovieCarouselCell.self)
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
        let movieTitle = UILabel(frame: .zero)
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
        let movieRanking = UILabel(frame: .zero)
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
        let movieRankingImage = UIImageView(frame: .zero)
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
        let ASPECT_RATION_SCREEN: CGFloat = contentView.frame.size.height / contentView.frame.size.width
        NSLayoutConstraint.activate([ movieRankingImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1 * (PADDING_SCREEN_PIXEL / 2)),
                                      movieRankingImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: PADDING_SCREEN_PIXEL),
                                      movieRankingImage.widthAnchor.constraint(equalToConstant: IMAGE_CONSTANT_SIZE),
                                      movieRankingImage.heightAnchor.constraint(equalToConstant: IMAGE_CONSTANT_SIZE),
                                      movieRankingImage.heightAnchor.constraint(equalTo: movieRankingImage.widthAnchor, multiplier: ASPECT_RATION_SCREEN),
                                      movieRanking.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1 * (PADDING_SCREEN_PIXEL / 2)),
                                      movieRanking.leftAnchor.constraint(equalTo: movieRankingImage.rightAnchor, constant:  (PADDING_SCREEN_PIXEL / 2)),
                                      movieTitle.widthAnchor.constraint(equalToConstant: contentView.frame.width),
                                      movieTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1 * (PADDING_SCREEN_PIXEL )),
                                      movieTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: PADDING_SCREEN_PIXEL ),
                                      movieTitle.bottomAnchor.constraint(equalTo: movieRankingImage.topAnchor, constant: -1 * (PADDING_SCREEN_PIXEL / 2))])
    }
    
    func configuration(dataInfo: MovieModel) {
        posterImage.loadPosterImage(from: dataInfo.getMoviePosterString())
        movieTitle.text = dataInfo.getMovieTitleString()
        movieRanking.text = dataInfo.getMovieRankingString()
    }
}
