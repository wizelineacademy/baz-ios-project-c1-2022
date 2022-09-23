//
//  TopRatedDetailViewController.swift
//  BAZProjectC1
//
//  Created by 291732 on 23/09/22.
//

import UIKit

class TopRatedDetailViewController: UIViewController {
    
    @IBOutlet weak var lblTTitle: UILabel!
    @IBOutlet weak var imgTMovie: UIImageView!
    @IBOutlet weak var lblTOverview: UILabel!
    @IBOutlet weak var lblTVote: UILabel!
    @IBOutlet weak var lblTYear: UILabel!
    
    var index: Int?
    var objTopRated: TopRatedAPIResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
        self.setTopRated()
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setTopRated(){
        let dVote: Double = objTopRated?.topRateds?[index ?? 0].voteAverage ?? 0.0
        self.lblTTitle.text = objTopRated?.topRateds?[index ?? 0].title
        self.lblTOverview.text = objTopRated?.topRateds?[index ?? 0].overview
        self.lblTVote.text = String(format: "%.1f", dVote )
        self.lblTYear.text = objTopRated?.topRateds?[index ?? 0].releaseDate
        if let urlPoster = objTopRated?.topRateds?[index ?? 0].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgTMovie.loadImage(url: url)
            
        }
    }

}
