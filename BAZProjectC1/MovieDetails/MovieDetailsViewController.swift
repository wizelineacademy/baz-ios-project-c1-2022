//
//  MovieDetailsViewController.swift
//  BAZProjectC1
//
//  Created by 1030361 on 29/09/22.
//

import UIKit

enum SegmentSelected {
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

class MovieDetailsViewController: UIViewController
{
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
    private var segmentSelected: SegmentSelected?
    private var detailsURL: String?
    var img: UIImage?
    private var movieReviews: [MovieReviews]?
    private var movieRecommendations, movieSimilars: [MovieSimilars]?
    private var movieDetail: MovieDetail?
    private var movieCast: [Cast]?
    let movieDetailAPI = MovieDetailAPI(url: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setData()
        configureSegmentedControll()
        fetchMovieDetails()
        
        fetchMovieCast()
        
        setupCollectionView()
        
//        mainViewController.register(UINib(nibName: "MovieDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieDetailCollectionViewCell")
    }

    private func setupTableView() {
//        reviewsTableView.dataSource = self
//        reviewsTableView.delegate = self
//        reviewsTableView.register(UINib(nibName: "ReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewsTableViewCell")
    }
    
    private func setupCollectionView() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(UINib(nibName: "MovieDetailCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MovieDetailCollectionViewCell")
        mainCollectionView.register(UINib(nibName: "MovieInfoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MovieInfoCollectionViewCell")
    }
    
    private func setData() {
        if let img = img {
            imgView.image = img
        }
        if let movie = movie {
            self.title = movie.title
        }
    }
    
    private func fetchMovieDetails() {
//        let movieDetailAPI = MovieDetailAPI(url: detailsURL ?? "")
        movieDetailAPI.urlString = detailsURL ?? ""
        movieDetail = movieDetailAPI.getMovieDetails()
        descriptionTextView.text = movieDetail?.overview
//        movieDetailAPI.urlString = reviewsURL ?? ""
//        movieReviews = movieDetailAPI.getMovieReviews()
//        movieDetailAPI.urlString = recomendationsURL ?? ""
//        movieRecommendations = movieDetailAPI.getMovieRecommendations()
//        movieDetailAPI.urlString = similarsURL ?? ""
//        movieSimilars = movieDetailAPI.getMovieSimilars()
//        movieDetailAPI.urlString = castURL ?? ""
//        movieCast = movieDetailAPI.getMovieCast()
    }
    
    func configureSegmentedControll() {
        segmentedControl.setTitle("Cast", forSegmentAt: 0)
        segmentedControl.setTitle("Reviews", forSegmentAt: 1)
        segmentedControl.setTitle("Similar", forSegmentAt: 2)
        segmentedControl.setTitle("Recomended", forSegmentAt: 3)
    }

    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        
        if let movie = movie {
            switch sender.selectedSegmentIndex {
            case 0:
                segmentSelected = .reviews(movie.id)
                fetchMovieCast()
                mainCollectionView.reloadData()
            case 1:
                segmentSelected = .reviews(movie.id)
                fetchMovieReviews()
                mainCollectionView.reloadData()
            case 2:
                segmentSelected = .similar(movie.id)
            case 3:
                segmentSelected = .recommended(movie.id)
            default:
                segmentSelected = .cast(movie.id)
            }
        }

//        fetchMovies()
    }
    
    private func fetchMovieReviews() {
        movieDetailAPI.urlString = segmentSelected?.url.urlString ?? ""
        movieReviews = movieDetailAPI.getMovieReviews()
        print("movieReviews\(movieReviews)")
    }
    
    private func fetchMovieCast() {
        movieDetailAPI.urlString = segmentSelected?.url.urlString ?? ""
        movieCast = movieDetailAPI.getMovieCast()
    }
}

//extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movieReviews?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let reviewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as? ReviewsTableViewCell else { return UITableViewCell() }
//        reviewsTableViewCell.lblAuthor.text = movieReviews?[indexPath.row].author
//        reviewsTableViewCell.lblReview.text = movieReviews?[indexPath.row].content
//        reviewsTableViewCell.selectionStyle = .none
////        print("movieReviews?[indexPath.row].content \(movieReviews?[indexPath.row].content)")
//        return reviewsTableViewCell
//    }
//
    
//}


extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movie = movie {
            switch segmentSelected {
            case .reviews(movie.id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCollectionViewCell", for: indexPath) as? MovieDetailCollectionViewCell else { return UICollectionViewCell() }
                cell.movieReviews = movieReviews
                return cell
            case .cast(movie.id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieInfoCollectionViewCell", for: indexPath) as? MovieInfoCollectionViewCell else { return UICollectionViewCell() }
                cell.castArray = movieCast
                return cell
            case .similar(movie.id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieInfoCollectionViewCell", for: indexPath) as? MovieInfoCollectionViewCell else { return UICollectionViewCell() }
                cell.moviesArray = movieSimilars
                return cell
            case .recommended(movie.id):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieInfoCollectionViewCell", for: indexPath) as? MovieInfoCollectionViewCell else { return UICollectionViewCell() }
                cell.moviesArray = movieRecommendations
                return cell
            default:
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCollectionViewCell", for: indexPath) as? MovieDetailCollectionViewCell else { return UICollectionViewCell() }
//        cell.movieReviews = movieReviews
//
//        return cell
//    }
}
