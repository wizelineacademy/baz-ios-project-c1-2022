//  MovieDetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class MovieDetailViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    var index: Int?
    var objMovie: MovieAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
        self.setInfoTrending()
        self.setGradientOnImage()
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setGradientOnImage(){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: imgMovie.frame.width, height: imgMovie.frame.height)
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        imgMovie.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setInfoTrending(){
        guard let index = index else { return }
        let dVote: Double = objMovie?.movies?[index].voteAverage ?? 0.0
        self.lblTitle.text = objMovie?.movies?[index].title
        self.lblOverview.text = objMovie?.movies?[index].overview
        self.lblVote.text = String(format: "%.1f", dVote )
        self.lblYear.text = objMovie?.movies?[index].releaseDate
        if let urlPoster = objMovie?.movies?[index].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgMovie.loadImage(url: url)
            
        }
    }
}
