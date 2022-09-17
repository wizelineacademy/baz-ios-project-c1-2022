//  TrendingViewController.swift
//  BAZProjectC1

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [Movie] = []
    var objMovie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMovies()
    }
    
    //MARK: - S E R V I C E S
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMovies { [weak self] WS_resp, error in
            guard let self = self else{ return }
            if WS_resp != nil {
                self.objMovie = WS_resp
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objMovie?.results?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "c")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
//        config.text = movies[indexPath.row].title
        config.text = objMovie?.results?[indexPath.row].title
//        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
