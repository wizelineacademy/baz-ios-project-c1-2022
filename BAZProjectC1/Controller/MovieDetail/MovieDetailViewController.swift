//  MovieDetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class MovieDetailViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    var index: Int?
    var objMovie: MovieAPIResponse?
    var objNowPlay: NowPlayingAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(named:"back"), style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }

    private func setInfoTrending(){
        self.lblTitle.text = objMovie?.movies?[index ?? 0].title
        if let urlPoster = objMovie?.movies?[index ?? 0].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgMovie.loadImage(url: url)
        }
    }
    
    private func setInfoNowPlaying() {
        self.lblTitle.text = objNowPlay?.nowPlaying?[index ?? 0].title
        if let urlPoster = objNowPlay?.nowPlaying?[index ?? 0].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgMovie.loadImage(url: url)
        }
    }
}
