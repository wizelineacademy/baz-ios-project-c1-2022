//
//  DetailMovieViewController.swift
//  BAZProjectC1
//
//  Created by 1029186 on 22/09/22.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overviewMovieLabel: UILabel!

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
//        title = movie.title
//        overviewMovieLabel.text = movie.overview ?? "Without overview"
//        MovieNetworkManager.shared.downloadImage(imagePath: movie.backdrop_path ?? "", width: 500) { [weak self] image in
//            DispatchQueue.main.async {
//                self?.backgroundImage.image = image ?? UIImage(systemName: "poster")
//            }
//        }
    }

    func initialConfiguration() {
        guard let movie = movie else {
            print("Sorry, no information about the movie was sent 🥲")
            return
        }
        title = movie.title ?? "No title"
        overviewMovieLabel.text = movie.overview ?? "Without overview"
        MovieNetworkManager.shared.downloadImage(imagePath: movie.backdrop_path ?? "", width: 500) { [weak self] image in
            DispatchQueue.main.async {
                self?.backgroundImage.image = image ?? UIImage(systemName: "poster")
            }
        }
    }
}
