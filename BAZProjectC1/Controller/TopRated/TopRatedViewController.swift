//  TopRatedViewController.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import UIKit

final class TopRatedViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var tblTopRated: UITableView!{
        didSet {
            self.tblTopRated.delegate = self
            self.tblTopRated.dataSource = self
            self.tblTopRated.register(TopRatedTableViewCell.nib, forCellReuseIdentifier: TopRatedTableViewCell.identifier)
        }
    }
    
    //MARK: - V A R I A B L E S
    private var objMovie: MovieAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Rated"
        self.getMovies()
    }
    
    //MARK: - S E R V I C E S
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMoviesTrending(withURL: MovieCategory.topRated.rawValue) { [weak self] moviesResponse, error in
            guard let self = self else{ return }
            if moviesResponse != nil {
                self.objMovie = moviesResponse
                DispatchQueue.main.async {
                    self.tblTopRated.reloadData()
                }
            }
        }
    }
}

//MARK: - EXT-> UI · T A B L E · V I E W · D E L E G A T E
extension TopRatedViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMovie?.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.identifier, for: indexPath) as? TopRatedTableViewCell ?? TopRatedTableViewCell()
        if let topRated = objMovie?.movies?[indexPath.row]{
            cell.setTopRated(with: topRated)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        if let movie = objMovie?.movies?[indexPath.row] {
            detail.movie = movie
        }
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
