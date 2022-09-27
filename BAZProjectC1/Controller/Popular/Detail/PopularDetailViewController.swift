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
    var objPopular: PopularAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        self.setUpLeftMenu()
        self.setPopular()
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setPopular(){
        guard let index = index else { return }
        let dVote: Double = objPopular?.popular?[index].voteAverage ?? 0.0
        self.lblPlTitle.text = objPopular?.popular?[index].title
        self.lblPlOverview.text = objPopular?.popular?[index].overview
        self.lblPlVote.text = String(format: "%.1f", dVote )
        self.lbllPYear.text = objPopular?.popular?[index].releaseDate
        if let urlPoster = objPopular?.popular?[index].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgPlMovie.loadImage(url: url)
            
        }
    }
}
