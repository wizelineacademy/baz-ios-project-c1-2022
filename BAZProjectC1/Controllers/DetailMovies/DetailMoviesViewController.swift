//
//  DetailMoviesViewController.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 01/10/22.
//

import UIKit
import WebKit

class DetailMoviesViewController: UIViewController {
    
    var infoMovie: Movie?
    private let movieApi = MovieAPI()
    private var moviesSimilar: [Movie] = [Movie]()
    private var moviesReviews: [Reviews] = [Reviews]()
    private var moviesActors: [Actor] = [Actor]()
    private var moviesRecommendations: [Movie] = [Movie]()
    private var dataMoreInfo: [MoreInfoMovie] = [MoreInfoMovie]()
    private var keyVideo = ""
    
    @IBOutlet weak var wvVideoMovie: WKWebView!
    @IBOutlet weak var btnPlayTrailer: UIButton!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var animLoadTrailer: UIActivityIndicatorView!
    @IBOutlet weak var tblDetailMovies: UITableView! {
        didSet{
            tblDetailMovies.register(UINib(nibName: "DetailMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailMovieTableViewCell")
            tblDetailMovies.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblDetailMovies.dataSource = self
        self.tblDetailMovies.delegate = self
        self.animLoadTrailer.isHidden = true
        getVideoTrailer()
        getDataMoreInfo()
        sendRecentMovieNotification()
    }
    
    private func getDataMoreInfo(){
        self.dataMoreInfo.append(.description)
        self.movieApi.getCredits(id: self.infoMovie!.id) { movieActors in
            self.moviesActors = movieActors.sorted{ $0.order < $1.order }
            if movieActors.count > 0 { self.dataMoreInfo.append(.actors) }
            self.movieApi.getReviews(id: self.infoMovie!.id) { moviesReviews in
                self.moviesReviews = moviesReviews
                if moviesReviews.count > 0 { self.dataMoreInfo.append(.reviews) }
                self.movieApi.getMoviesSimilar(id: self.infoMovie!.id) { moviesSimilar in
                    self.moviesSimilar = moviesSimilar
                    if movieActors.count > 0 { self.dataMoreInfo.append(.similar) }
                    self.movieApi.getRecommendations(id: self.infoMovie!.id) { moviesRecommendations in
                        self.moviesRecommendations = moviesRecommendations
                        if moviesRecommendations.count > 0 { self.dataMoreInfo.append(.recommendations) }
                        DispatchQueue.main.async {
                            self.tblDetailMovies.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    private func sendRecentMovieNotification(){
        if let infoMovie = infoMovie {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notification.addRecentMovieHome"), object: nil, userInfo: ["recentMovie": infoMovie])
        }
    }
    
    @IBAction func showVideo(_ sender: Any) {
        DispatchQueue.main.async {
            self.animLoadTrailer.isHidden = false
            self.animLoadTrailer.startAnimating()
            let urlVide = URL(string: "https://www.youtube.com/watch?v=\(self.keyVideo)")
            self.wvVideoMovie.navigationDelegate = self
            self.wvVideoMovie.load(URLRequest(url: urlVide!))
        }
    }
    
    private func getVideoTrailer(){
        movieApi.getVideoMovie(id: infoMovie!.id) { videoMovie in
            if let firstVideo = videoMovie.filter({ $0.official && $0.site == "YouTube" && $0.type == "Trailer"}).first {
                self.keyVideo = firstVideo.key
                DispatchQueue.main.async {
                    self.btnPlayTrailer.isHidden = false
                    self.loadImg(img: self.infoMovie?.backdrop_path ?? "")
                }
            }else{
                DispatchQueue.main.async {
                    self.btnPlayTrailer.isHidden = true
                    self.loadImg(img: self.infoMovie?.poster_path ?? "")
                }
            }
        }
    }
    
    func loadImg(img: String){
        
        let urlImageName = "https://image.tmdb.org/t/p/w500\(img)"
        let urlString = urlImageName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        guard let url = URL(string: urlString) else { return }

        UIImage.loadFrom(url: url) { image in
            if let image = image {
                
                UIView.transition(with: self.imgMovie,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.imgMovie.image = image },
                                  completion: nil)
                
            } else {
                print("Image '\(String(describing: urlImageName))' does not exist!")
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
}

extension DetailMoviesViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.btnPlayTrailer.isHidden = false
        self.animLoadTrailer.stopAnimating()
    }
}

extension DetailMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMoreInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataMoreInfoType = dataMoreInfo[indexPath.row]
        
        switch dataMoreInfoType {
        case .description:
            let cell : DetailMovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailMovieTableViewCell", for: indexPath) as! DetailMovieTableViewCell
            cell.configCellDetail(movie: infoMovie!)
            return cell
        case .reviews:
            let cell : MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            cell.delegate = self
            cell.listReviews = moviesReviews
            cell.containerSize = CGSize(width: 350, height: 150)
            cell.configCell(title: "Reviews", typeCell: .reviews)
            return cell
        case .actors:
            let cell : MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            cell.listActors = moviesActors
            cell.containerSize = CGSize(width: 150, height: 200)
            cell.configCell(title: "Actors", typeCell: .actors)
            cell.delegate = self
            return cell
        case .similar:
            let cell : MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            cell.listMovies = moviesSimilar
            cell.containerSize = CGSize(width: 350, height: 250)
            cell.configCell(title: "Similar", typeCell: .similar)
            cell.delegate = self
            return cell
        case .recommendations:
            let cell : MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            cell.listMovies = moviesRecommendations
            cell.containerSize = CGSize(width: 300, height: 400)
            cell.configCell(title: "Recommendations", typeCell: .recommendations)
            cell.delegate = self
            return cell
        default:
            let cell: UITableViewCell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataMoreInfoType = dataMoreInfo[indexPath.row]
        switch dataMoreInfoType {
        case .reviews:
            return 200.0
        case .actors:
            return 240.0
        case .similar:
            return 300.0
        case .recommendations:
            return 450.0
        default:
            return UITableView.automaticDimension
        }
    }
    
}

extension DetailMoviesViewController: ManageControllersDelegate {
    func sendDetailMovies(movie: Movie) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DetailMovies", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailMoviesViewController") as! DetailMoviesViewController
        newViewController.infoMovie = movie
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
