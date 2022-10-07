//
//  PopularDetailViewController.swift
//  BAZProjectC1
//
//  Created by 291732 on 23/09/22.
//

import UIKit

class PopularDetailViewController: UIViewController {
    
    @IBOutlet weak var lblPlTitle: UILabel!
    @IBOutlet weak var imgPlMovie: UIImageView!
    @IBOutlet weak var lblPlOverview: UILabel!
    @IBOutlet weak var lblPlVote: UILabel!
    @IBOutlet weak var lbllPYear: UILabel!
    
    var index: Int?
    var objMovie: MovieAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
        self.setPopular()
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
        gradient.frame = CGRect(x: 0, y: 0, width: imgPlMovie.frame.width,
                                height: imgPlMovie.frame.height)
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor, endColor]
        imgPlMovie.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setPopular(){
        guard let index = index else { return }
        let dVote: Double = objMovie?.movies?[index].voteAverage ?? 0.0
        self.lblPlTitle.text = objMovie?.movies?[index].title
        self.lblPlOverview.text = objMovie?.movies?[index].overview
        self.lblPlVote.text = String(format: "%.1f", dVote )
        self.lbllPYear.text = objMovie?.movies?[index].releaseDate
        if let urlPoster = objMovie?.movies?[index].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgPlMovie.loadImage(url: url)
            
        }
    }
}
