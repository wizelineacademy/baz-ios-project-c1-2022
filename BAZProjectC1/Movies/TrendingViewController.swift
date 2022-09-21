//
//  TrendingViewController.swift
//  BAZProjectC1
//
//

import UIKit

final class TrendingViewController: UITableViewController {

    private var movies = [MovieData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMoviesTrending()
    }
    
    func showMoviesTrending() {
        let movieApi = MovieAPI()
        movieApi.moviesList(completion: { data in
            self.movies = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, searchType: "trending")
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
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }
    
}
