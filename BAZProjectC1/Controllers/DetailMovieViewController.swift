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
    @IBOutlet private weak var castCollectionView: UICollectionView!
    @IBOutlet private weak var similarMoviesCollectionView: UICollectionView!
    @IBOutlet private weak var recommendationMoviesCollectionView: UICollectionView!

    // MARK: Class properties -
    var movie: Movie?
    var creditsMovie: Casting?
    var similarMovies: Movies?
    var recommendationMovies: Movies?

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeNotification()
        setupInitialView()
        setupInitialData()
        setupCollectionViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenterHelper.shared.removeObserver(self)
    }

    // MARK: Private method helper -
    private func setupInitialView() {
        backButton.layer.cornerRadius = 5.00
        headerDetailMovieView.roundCornersView(radious: 15.00)
        headerDetailMovieView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setupCollectionViews() {
        castCollectionView.register(UINib(nibName: "DetailsMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsMovie")
        similarMoviesCollectionView.register(UINib(nibName: "DetailsMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsMovie")
        recommendationMoviesCollectionView.register(UINib(nibName: "DetailsMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsMovie")
        castCollectionView.dataSource = self
        similarMoviesCollectionView.dataSource = self
        recommendationMoviesCollectionView.dataSource = self
        similarMoviesCollectionView.delegate = self
        recommendationMoviesCollectionView.delegate = self
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
        getCreditsMovie()
        getSimilarMovies()
        getRecommendationMovies()
        if movie.adult ?? false { clasitificationImageView.image = UIImage(named: "clasificationB") }
        ratingView.generatePropertyView(getRating())
        yearView.generatePropertyView(movie.release_date?.getYear ?? "YYYY")
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }

    private func subscribeNotification() {
        NotificationCenterHelper.shared.subscribeNotification(self, with: #selector(receivedNotification(_:)), name: NSNotification.Name(rawValue: "DetailMovie.Notification"))
    }

    private func getCreditsMovie() {
        MovieNetworkManager.shared.fetchCreditsMovie(movie?.id ?? 0) { [weak self] objectResponse, error in
            guard let casting = objectResponse?.cast else { return }
            self?.creditsMovie = casting
            // TODO: refresh the cast collection view with the current data
            DispatchQueue.main.async {
                self?.castCollectionView.reloadData()
            }
        }
    }

    private func getSimilarMovies() {
        MovieNetworkManager.shared.fetchRelationsMovies(with: movie?.id ?? 0, isSimilar: true) { [weak self] objectResponse, error in
            guard let movies = objectResponse?.results else { return }
            self?.similarMovies = movies
            DispatchQueue.main.async {
                self?.similarMoviesCollectionView.reloadData()
            }
        }
    }

    private func getRecommendationMovies() {
        MovieNetworkManager.shared.fetchRelationsMovies(with: movie?.id ?? 0, isSimilar: false) { [weak self] objectResponse, error in
            guard let movies = objectResponse?.results else { return }
            self?.recommendationMovies = movies
            DispatchQueue.main.async {
                self?.recommendationMoviesCollectionView.reloadData()
            }
        }
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

    @objc private func receivedNotification(_ notification: NSNotification) {
        guard let newMovie = notification.userInfo?["SelectedMovie"] as? Movie else {
            return
        }
        let newDetailMovieView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController
        newDetailMovieView?.movie = newMovie
        navigationController?.pushViewController(newDetailMovieView!, animated: true)
    }
}

// MARK: DetailMovieViewController's UICollectionViewDataSouce
extension DetailMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: return creditsMovie?.count ?? 0
        case 1: return similarMovies?.count ?? 0
        case 2: return recommendationMovies?.count ?? 0
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var imagePath: String = ""
        var titleCollection: String = ""
        let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsMovie", for: indexPath) as! DetailsMovieCollectionViewCell
        switch collectionView.tag {
        case 0:
            imagePath = creditsMovie?[indexPath.item].profile_path ?? ""
            titleCollection = creditsMovie?[indexPath.item].name ?? "Without name"
        case 1:
            imagePath = similarMovies?[indexPath.item].poster_path ?? ""
            titleCollection = similarMovies?[indexPath.item].title ?? "Without title"
        case 2:
            imagePath = recommendationMovies?[indexPath.item].poster_path ?? ""
            titleCollection = recommendationMovies?[indexPath.item].title ?? "Without title"
        default: break
        }
        MovieNetworkManager.shared.downloadImage(imagePath: imagePath, width: 200) { posterImage in
            DispatchQueue.main.async {
                detailCell.posterImageView.image = posterImage
                detailCell.titleLabel.text = titleCollection
            }
        }
        return detailCell
    }
}

// MARK: DetailMovieViewController's UICollectionViewDelegate
extension DetailMovieViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedMovie: Movie?
        switch collectionView.tag {
        case 1:
            selectedMovie = similarMovies![indexPath.item]
        case 2:
            selectedMovie = recommendationMovies![indexPath.item]
        default: return
        }
        NotificationCenterHelper.shared.post(name: NSNotification.Name(rawValue: "DetailMovie.Notification"), object: nil, userInfo: ["SelectedMovie": selectedMovie!])
    }
}
