//
//  MovieDetailsViewController.swift
//  BAZProjectC1
//
//  Created by 1030361 on 29/09/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
//    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    var movie: Movie?
    var img: UIImage?
    private var movieDetail: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        navBar.topItem?.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backButtonFunction))
        setData()
    }

    @objc func backButtonFunction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setData() {
        if let img = img {
            imgView.image = img
        }
        if let movie = movie {
//            navBar.topItem?.title = movie.title
            fetchMovieDetail(movieID: movie.id)
        }
    }
    
    private func fetchMovieDetail(movieID: Int) {
        let movieApi = MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es")
        DispatchQueue.global().sync {
            self.movieDetail = movieApi.getMovieDetail()
            self.lblDescription.text = self.movieDetail?.content
        }
    }

    
}
