//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

final internal class TrendingViewController: UITableViewController, TrendingViewControllerFetcherDelegate {

    private var movies: [Movie] = []
    private let movieApi = MovieAPI(url: "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    func fetchMovies() {
        DispatchQueue.global().async {
            self.movies = self.movieApi.getMovies()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func retreiveImageFromSource(posterPath: String) -> UIImage {
        let apiURLHandler = APIURLHandler(url: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        return UIImage(data: apiURLHandler.getDataFromURL() ?? Data()) ?? UIImage()
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = retreiveImageFromSource(posterPath: movies[indexPath.row].posterPath)
        cell.contentConfiguration = config
    }

}

// MARK: - TrendingViewController's Delegate
protocol TrendingViewControllerFetcherDelegate {
    func fetchMovies()
    func retreiveImageFromSource(posterPath: String) -> UIImage
}
