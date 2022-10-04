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
    let movieApi = MovieAPI()
    var moviesSimilar: [Movie] = [Movie]()
    var keyVideo = ""
    
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
        getMoviesSimilar()
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
    
    private func getMoviesSimilar(){
        movieApi.getMoviesSimilar(id: infoMovie!.id) { moviesSimilar in
            self.moviesSimilar = moviesSimilar
            DispatchQueue.main.async {
                self.tblDetailMovies.reloadData()
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
        return moviesSimilar.count == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : DetailMovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailMovieTableViewCell", for: indexPath) as! DetailMovieTableViewCell
            cell.configCellDetail(movie: infoMovie!)
            return cell
        }else{
            let cell : MoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            cell.configCell(listMovies: moviesSimilar, title: "Similar")
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 0 {
            return 450.0
        }else{
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
