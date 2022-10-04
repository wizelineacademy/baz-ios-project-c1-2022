//
//  DetailMovieViewController.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 27/09/22.
//

import UIKit

/// This Class send a request, for get url
/// - Parameters:
///   - requestUrl: URL path of an API
///   - completion: action when the service response

class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var MovieTitleLabel: UILabel!
    @IBOutlet weak var MoviePosterImage: UIImageView!
    var detailMovie: PosterCollectionCell?
    var movieSelected: MovieData?
    private let viewModel = TrendingMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        
        
        if let  movieTitle = movieSelected?.title,
           let overView = movieSelected?.overview,
           let imageLink = movieSelected?.posterPath {
            descriptionLabel.text = overView
            MovieTitleLabel.text = movieTitle
            MoviePosterImage.downloaded(from: imageLink)
        } else {
            if let  movieTitle = detailMovie?.title,
               let overView = detailMovie?.overView,
               let imageLink = detailMovie?.posterImage {
                descriptionLabel.text = overView
                MovieTitleLabel.text = movieTitle
                MoviePosterImage.downloaded(from: imageLink)
            }
        }
    }
}
