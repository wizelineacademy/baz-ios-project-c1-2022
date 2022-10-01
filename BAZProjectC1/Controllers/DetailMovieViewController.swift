//
//  DetailMovieViewController.swift
//  BAZProjectC1
//
//  Created by 1029186 on 22/09/22.
//

import UIKit

class DetailMovieViewController: UIViewController {

    // MARK: IBOutlets -
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var backgroundMovieImageView: UIImageView!
    @IBOutlet private weak var headerDetailMovieView: UIView!
    @IBOutlet private weak var clasitificationImageView: UIImageView!
    @IBOutlet private weak var ratingView: PropertyMovieView!
    @IBOutlet private weak var yearView: PropertyMovieView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    // MARK: Class properties -
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupInitialData()
    }

    // MARK: Private method helper -
    private func setupInitialView() {
        backButton.layer.cornerRadius = 5.00
        headerDetailMovieView.roundCornersView(radious: 15.00)
        headerDetailMovieView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setupInitialData() {
        guard let movie = movie else {
            print("Sorry, the movie information has not been sent 🥲")
            return
        }
        MovieNetworkManager.shared.downloadImage(imagePath: movie.backdrop_path ?? "", width: 500) { [weak self] backgroundImage in
            DispatchQueue.main.async {
                self?.backgroundMovieImageView.image = backgroundImage ?? UIImage(systemName: "poster")
            }
        }
        if movie.adult ?? false { clasitificationImageView.image = UIImage(named: "clasificationB") }
        ratingView.generatePropertyView(getRating())
        yearView.generatePropertyView(movie.release_date?.getYear ?? "YYYY")
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }

    fileprivate func getRating() -> String {
        if let votes = movie?.vote_average {
            return "Rating \(Int(votes * 100 / 10))%"
        } else { return "Rating ?%" }
    }

    // MARK: Class actions -
    @IBAction func backButtontaped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
