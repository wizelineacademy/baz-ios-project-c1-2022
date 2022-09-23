//  UpcomingDetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 23/09/22.

import UIKit

class UpcomingDetailViewController: UIViewController {
    
    @IBOutlet weak var lblUTitle: UILabel!
    @IBOutlet weak var imgUMovie: UIImageView!
    @IBOutlet weak var lblUOverview: UILabel!
    @IBOutlet weak var lblUVote: UILabel!
    @IBOutlet weak var lblUYear: UILabel!
    
    var index: Int?
    var objUpcoming: UpcomingAPIResponse?

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
        let dVote: Double = objUpcoming?.upcoming?[index ?? 0].voteAverage ?? 0.0
        self.lblUTitle.text = objUpcoming?.upcoming?[index ?? 0].title
        self.lblUOverview.text = objUpcoming?.upcoming?[index ?? 0].overview
        self.lblUVote.text = String(format: "%.1f", dVote )
        self.lblUYear.text = objUpcoming?.upcoming?[index ?? 0].releaseDate
        if let urlPoster = objUpcoming?.upcoming?[index ?? 0].backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlPoster)"){
            let _ = imgUMovie.loadImage(url: url)
        }
    }
}
