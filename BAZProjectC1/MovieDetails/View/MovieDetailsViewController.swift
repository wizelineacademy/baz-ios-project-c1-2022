//
//  MovieDetailsViewController.swift
//  BAZProjectC1
//
//  Created by 1030361 on 29/09/22.
//

import UIKit

private enum SegmentSelected {
    case cast(Int)
    case reviews(Int)
    case similar(Int)
    case recommended(Int)
    
    var url: MovieAPI {
        switch self {
        case let .cast(movieID):
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es")
        case let .reviews(movieID):
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        case let .similar(movieID):
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es")
        case let .recommended(movieID):
            return MovieAPI(url: "https://api.themoviedb.org/3/movie/\(movieID)/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es")
        }
    }
}

final internal class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                self.segmentSelected = .cast(movie.id)
                self.detailsURL = "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es"
            }
        }
    }
    var img: UIImage?
    private var segmentSelected: SegmentSelected?
    private var detailsURL: String?
    private var movieReviews: [MovieReviews]?
    private var movieRecommendations, movieSimilars: [MovieSimilars]?
    private var movieDetail: MovieDetail?
    private var movieCast: [Cast]?
    private let movieDetailAPI = MovieDetailAPI(url: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setData()
        configureCollectionView()
        configureSegmentedControll()
        fetchMovieDetails()
        fetchMovieCast()
    }
    
    private func setData() {
        if let img = img {
            imgView.image = img
        }
        if let movie = movie {
            self.title = movie.title
        }
    }
    
    func fetchMovieDetails() {
        movieDetailAPI.urlString = detailsURL ?? ""
        movieDetail = movieDetailAPI.getMovieDetails()
        descriptionTextView.text = movieDetail?.overview
    }

    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if let movie = movie {
            switch sender.selectedSegmentIndex {
            case 0:
                segmentSelected = .cast(movie.id)
                fetchMovieCast()
                mainCollectionView.reloadData()
            case 1:
                segmentSelected = .reviews(movie.id)
                fetchMovieReviews()
                mainCollectionView.reloadData()
            case 2:
                segmentSelected = .similar(movie.id)
                fetchMovieSimilars()
                mainCollectionView.reloadData()
            case 3:
                segmentSelected = .recommended(movie.id)
                fetchMovieRecommended()
                mainCollectionView.reloadData()
            default:
                segmentSelected = .cast(movie.id)
                fetchMovieCast()
                mainCollectionView.reloadData()
            }
        }
    }
    
    private func fetchMovieReviews() {
        movieDetailAPI.urlString = segmentSelected?.url.urlString ?? ""
        movieReviews = movieDetailAPI.getMovieReviews()
    }
    
    private func fetchMovieCast() {
        movieDetailAPI.urlString = segmentSelected?.url.urlString ?? ""
        movieCast = movieDetailAPI.getMovieCast()
    }
    
    private func fetchMovieSimilars() {
        movieDetailAPI.urlString = segmentSelected?.url.urlString ?? ""
        movieSimilars = movieDetailAPI.getMovieSimilars()
    }
    
    private func fetchMovieRecommended() {
        movieDetailAPI.urlString = segmentSelected?.url.urlString ?? ""
        movieRecommendations = movieDetailAPI.getMovieRecommendations()
    }
    
}

// MARK: - MovieDetailsViewController's DataSource and Delegate
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movie = movie {
            switch segmentSelected {
            case .reviews(movie.id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCollectionViewCell", for: indexPath) as? MovieDetailCollectionViewCell else { return UICollectionViewCell() }
                cell.tableView.reloadData()
                cell.movieReviews = movieReviews
                return cell
            case .cast(movie.id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieInfoCollectionViewCell", for: indexPath) as? MovieInfoCollectionViewCell else { return UICollectionViewCell() }
                cell.collectionView.reloadData()
                cell.castArray = movieCast
                cell.bMovies = false
                return cell
            case .similar(movie.id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieInfoCollectionViewCell", for: indexPath) as? MovieInfoCollectionViewCell else { return UICollectionViewCell() }
                cell.collectionView.reloadData()
                cell.moviesArray = movieSimilars
                cell.bMovies = true
                return cell
            case .recommended(movie.id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieInfoCollectionViewCell", for: indexPath) as? MovieInfoCollectionViewCell else { return UICollectionViewCell() }
                cell.collectionView.reloadData()
                cell.moviesArray = movieRecommendations
                cell.bMovies = true
                return cell
            default:
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
}

extension MovieDetailsViewController: ViewControllerCommonsDelegate {
    func configureCollectionView() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(UINib(nibName: "MovieDetailCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MovieDetailCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "MovieInfoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MovieInfoCollectionViewCell")
    }
    
    func configureSegmentedControll() {
        segmentedControl.setTitle("Cast", forSegmentAt: 0)
        segmentedControl.setTitle("Reviews", forSegmentAt: 1)
        segmentedControl.setTitle("Similar", forSegmentAt: 2)
        segmentedControl.setTitle("Recomended", forSegmentAt: 3)
    }
    
    
    func retreiveImageFromSource(posterPath: String) -> UIImage {
        let apiURLHandler = APIURLHandler(url: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        let uiImage = UIImage(data: apiURLHandler.getDataFromURL() ?? Data()) ?? UIImage()
        return uiImage
    }
}
