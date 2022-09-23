//  NowPlayingDetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 23/09/22.

import UIKit

class NowPlayingDetailViewController: UIViewController {
    
    @IBOutlet weak var lblPTitle: UILabel!
    @IBOutlet weak var imgPMovie: UIImageView!
    @IBOutlet weak var lblPOverview: UILabel!
    @IBOutlet weak var lblPVote: UILabel!
    @IBOutlet weak var lblPYear: UILabel!
    
    var index: Int?
    var objNowPlaying: NowPlayingAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
        self.setInfoTrending()
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setInfoTrending(){
        let dVote: Double = objNowPlaying?.nowPlaying?[index ?? 0].voteAverage ?? 0.0
        self.lblPTitle.text = objNowPlaying?.nowPlaying?[index ?? 0].title
        self.lblPOverview.text = objNowPlaying?.nowPlaying?[index ?? 0].overview
        self.lblPVote.text = String(format: "%.1f", dVote )
        self.lblPYear.text = objNowPlaying?.nowPlaying?[index ?? 0].releaseDate
        if let urlPoster = objNowPlaying?.nowPlaying?[index ?? 0].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgPMovie.loadImage(url: url)
            
        }
    }
    
    
}
