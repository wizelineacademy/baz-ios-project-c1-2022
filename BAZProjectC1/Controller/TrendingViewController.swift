//  TrendingViewController.swift
//  BAZProjectC1

import UIKit

final class TrendingViewController: UITableViewController {
    
    private var objMovie: MovieAPIResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMovies()
        tableView.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    //MARK: - S E R V I C E S
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMovies { [weak self] moviesResponse, error in
            guard let self = self else{ return }
            if moviesResponse != nil {
                self.objMovie = moviesResponse
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
        objMovie?.movies?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell ?? MovieTableViewCell()
        if let movie = objMovie?.movies?[indexPath.row] {
            cell.setInfo(with: movie)
        }
        return cell
    }
}
